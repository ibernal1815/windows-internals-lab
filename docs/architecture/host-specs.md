# Host Hardware and Hypervisor Specifications

## Overview
This document details the physical hardware and hypervisor configurations used to host the Windows Internals lab. Because this environment runs on a single workstation with a 512GB NVMe drive, specific optimization techniques were implemented to maintain high performance across three simultaneous virtual machines.

## Physical Host Specifications
* **Processor:** Intel Core i5-14400F (10 Cores / 16 Threads). The hybrid architecture (6 P-cores and 4 E-cores) is leveraged by assigning high-priority analysis tasks to P-core threads.
* **Memory:** 48GB DDR4. This capacity allows for generous allocation to the Windows 11 and Server 2022 guests while leaving 20GB+ for the host OS to handle documentation and web research.
* **Storage:** 512GB NVMe SSD. To prevent storage exhaustion, a Linked Clone strategy is used for all workstation instances.
* **Graphics:** AMD Radeon RX 7600. Handles host-side rendering, allowing the CPU to focus entirely on hypervisor tasks.

## Hypervisor Configuration (VMware Workstation Pro)
The following settings are applied globally to ensure the lab accurately simulates modern enterprise hardware requirements.

### Virtualization Engine
To support Windows 11 security features and advanced Sysinternals telemetry, the following processor settings are enabled:
* **Virtualize Intel VT-x/EPT:** Enabled to allow the guest OS to use hardware acceleration.
* **Virtualize IOMMU:** Enabled to support Virtualization-Based Security (VBS) and Core Isolation features within the Windows 11 guests.



### Security and TPM
Since Windows 11 and Server 2022 require a Trusted Platform Module (TPM), the VMs are configured with:
* **Encryption:** Only the VM metadata is encrypted to satisfy the requirement for a virtual TPM (vTPM) without significantly impacting disk I/O performance.
* **vTPM:** A virtual Trusted Platform Module is added to each guest to ensure full compatibility with modern Windows boot requirements.

## Resource Allocation Table

| VM Name | Operating System | vCPU Cores | Assigned RAM | Disk Role |
| :--- | :--- | :--- | :--- | :--- |
| **DC-01** | Windows Server 2022 | 2 | 8GB | Full Clone (Infrastructure) |
| **WS-01** | Windows 11 Pro | 4 | 10GB | Linked Clone (Target) |
| **WS-02** | Windows 11 Pro | 2 | 8GB | Linked Clone (Auditor) |
| **Total** | **--** | **8** | **26GB** | **--** |

## Storage and Optimization Strategy

### Linked Clone Methodology
The 512GB NVMe capacity is a primary constraint. To solve this, I utilize a "Golden Image" workflow:
1. A single **Windows 11 Master Image** is installed and fully updated.
2. A snapshot is taken in a powered-off state.
3. **WS-01** and **WS-02** are created as **Linked Clones** from that snapshot.



> **Technical Impact:** Linked clones read from the Master Image disk but write to unique delta files. This reduces the total storage footprint for two Windows 11 instances by approximately 50-60%, preserving critical NVMe space.

### Memory Management
With 48GB of RAM available, I have disabled memory ballooning and pagefile dependency within the hypervisor where possible. By assigning 8GB+ to each Windows 11 instance, the guest OS is less likely to swap data to the virtual disk, which reduces SSD wear and maintains high-speed responsiveness during intensive Process Monitor (ProcMon) traces.

## Network Configuration
The lab utilizes a custom **VMnet1** Host-Only network.
* **IP Scheme:** 192.168.10.0/24
* **DHCP/DNS:** VMware's built-in DHCP is disabled in the Virtual Network Editor. All IP addressing and DNS resolution are handled by the Windows Server 2022 Domain Controller to simulate a production enterprise environment.

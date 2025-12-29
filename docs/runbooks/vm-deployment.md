# VM Deployment and Golden Image Workflow

## Overview
This runbook outlines the process for deploying a resource-efficient lab environment on VMware Workstation Pro. To maximize the 512GB NVMe storage, a "Golden Image" strategy is used for Windows 11 workstations, while Windows Server 2022 is deployed as a standalone infrastructure node.

## Phase 1: Windows 11 Golden Image Setup
The Golden Image serves as the read-only parent for all workstation clones.

1. **Virtual Hardware Configuration:**
   - **RAM:** 8GB
   - **CPU:** 4 Cores (Enable VT-x/EPT and IOMMU)
   - **TPM:** Encrypt VM and add a Virtual TPM module.
   - **Network:** Set to NAT temporarily for updates, then switch to VMnet1 (Host-Only).
2. **OS Installation:** - Perform a clean install of Windows 11 Pro.
   - Create a local administrator account (do not sign in with a Microsoft Account).
3. **Initial Optimization:**
   - Install **VMware Tools** immediately.
   - Run the `infrastructure/setup-scripts/init-workstation.ps1` script to debloat the OS and download Sysinternals.
   - Disable Windows Update and Hibernation (`powercfg -h off`).
4. **Finalizing the Image:**
   - Shut down the VM completely.
   - Go to **VM > Snapshot > Take Snapshot** and name it `Golden_Base_Clean`.



## Phase 2: Deploying Linked Clones (WS-01 & WS-02)
Linked clones allow multiple workstations to share the disk space of the Golden Image.

1. Right-click the **Windows 11 Golden Image** and select **Manage > Clone**.
2. Select **An existing snapshot** (Golden_Base_Clean).
3. **Critical:** Select **Create a linked clone**.
4. Name the new VM (e.g., `WS-01-Target`) and choose the storage location.
5. Repeat for `WS-02-Auditor`.

## Phase 3: Windows Server 2022 (DC-01)
The Domain Controller is deployed as a **Full Clone** or a separate installation to ensure infrastructure stability.

1. **Hardware:** 8GB RAM, 2 Cores.
2. **Static IP Assignment:**
   - IP Address: `192.168.10.2`
   - Subnet Mask: `255.255.255.0`
   - DNS: `127.0.0.1`
3. **Role Installation:** Install **Active Directory Domain Services (AD DS)** and promote to a Domain Controller for the `LAB.LOCAL` forest.

# Windows Internals and Sysinternals Troubleshooting Lab

## Project Overview
This lab environment is built to move beyond high-level OS administration and focus on the underlying mechanics of the Windows operating system. Using VMware Workstation Pro as the hypervisor, I have deployed a virtualized domain environment to simulate enterprise-level troubleshooting and security analysis. 

The core objective is to utilize the Microsoft Sysinternals Suite to observe process-to-kernel interactions, investigate registry persistence, and resolve system performance bottlenecks in a controlled, isolated sandbox.

## Hardware Configuration and Resource Management
Efficiently running a multi-VM lab on a single workstation required a strategic allocation of hardware resources to ensure host stability during heavy analysis.

| Component | Specification | Allocation Strategy |
| :--- | :--- | :--- |
| CPU | Intel i5-14400F | Assigned 4 cores to DC-01; 2-4 cores to workstations. |
| Memory | 48GB DDR4 | 8GB for DC-01, 8GB per Client; 24GB reserved for Host. |
| Storage | 512GB NVMe | Utilized Linked Clones to minimize disk footprint. |
| GPU | AMD RX 7600 | Dedicated to host-side rendering and documentation. |

> **Storage Strategy:** To address the 512GB storage limitation, I created a single "Golden Image" of Windows 11. All workstation VMs are Linked Clones of this image. This allows me to run multiple instances while only storing the delta changes (writes) on the NVMe, significantly reducing the total GB used.

## Network Architecture
The lab operates on a Host-Only virtual network (VMnet). This ensures that all experiments—including simulated malware persistence or network packet captures—are completely isolated from my physical home network and the public internet.

* **Domain Controller (DC-01):** Windows Server 2022. Functions as the DNS and Active Directory authority for the lab.
* **Workstation 01 (WS-01):** Windows 11 Enterprise. Used as the primary target for system analysis and script execution.
* **Workstation 02 (WS-02):** Windows 11 Pro. Used as a secondary client to test cross-OS compatibility of Sysinternals tools and Group Policy settings.

## Technical Focus Areas
This repository documents my use of the following tools to solve specific technical challenges:

### 1. Process and Thread Analysis
I use Process Explorer to move beyond the standard Task Manager. This involves:
* Identifying parent-child process relationships and orphaned processes.
* Verifying digital signatures of running images to find unsigned binaries.
* Analyzing thread-level CPU usage to find specific "hung" service components within svchost.exe.

### 2. Real-time Monitoring
Using Process Monitor (ProcMon), I capture and filter system events to:
* Debug application launch failures caused by missing DLLs or incorrect file paths.
* Track unauthorized file system changes in protected directories.
* Identify "Access Denied" errors in the Windows Registry to fix permission issues.

### 3. Forensic Visibility
I have implemented Sysmon across the domain to provide persistent logging of:
* Process creation with command-line arguments and file hashes (SHA256).
* Network connections initiated by system processes.
* Unauthorized driver loading and remote thread injection.

## Repository Structure
* **infrastructure/**: PowerShell scripts for VM debloating and environment initialization.
* **configs/**: Custom XML configurations for Sysmon and pre-configured ProcMon filters.
* **scenarios/**: Detailed logs of troubleshooting "war games," including problem descriptions and resolutions.
* **docs/**: Network diagrams and research notes regarding Windows Internals concepts.
* **evidence/**: Log exports, CSV data, and screenshots of tool outputs during analysis.
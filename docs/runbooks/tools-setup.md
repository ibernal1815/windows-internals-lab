# Analysis Tools Installation and Configuration

## Overview
This document describes the deployment of the diagnostic and monitoring toolset used in the lab. The primary focus is the **Microsoft Sysinternals Suite**, which provides deep visibility into Windows internals.



## Automated Deployment
To ensure consistency across all lab nodes, tools are deployed using the `infrastructure/setup-scripts/init-workstation.ps1` PowerShell script.

### Installation Path
All tools are centrally located at `C:\Tools\` for ease of access and to avoid path length issues in the Windows environment.

### Automated Steps:
1. **Directory Creation:** Ensures `C:\Tools` exists.
2. **Web Download:** Fetches the latest `SysinternalsSuite.zip` directly from Microsoft servers.
3. **Extraction:** Unpacks the full suite into the tools directory.
4. **Environment Path:** Adds `C:\Tools` to the System PATH so utilities like `procexp` or `procmon` can be launched directly from a command prompt.

## Core Tool Configuration

### 1. Sysmon (System Monitor)
Sysmon is installed with a custom configuration to log process creations, network connections, and file time changes to the Windows Event Log.

**Installation Command:**
```powershell
.\Sysmon64.exe -i ..\configs\sysmon\main-config.xml -accepteula
```

**Logs:** Viewed in Event Viewer under `Applications and Services Logs/Microsoft/Windows/Sysmon/Operational`.

### 2. Process Monitor (ProcMon)
To reduce noise during analysis, the following configuration is applied:
* **Backing Store:** Configured to use a file on disk rather than virtual memory to prevent host RAM exhaustion during long traces.
* **Filters:** Custom filters located in `configs/procmon/` are imported to exclude standard system noise (e.g., SearchIndexer.exe, MsMpEng.exe).

### 3. Wireshark
Installed on **WS-02 (Auditor)** to capture traffic across the VMnet1 interface. 
* **Promiscuous Mode:** Enabled to capture traffic between other VMs on the virtual switch.
* **Display Filters:** Common filters are saved to identify SMB, DNS, and LDAP traffic within the domain.

## Maintenance
Tools should be updated monthly by re-running the initialization script to ensure the latest versions—which often include bug fixes for new Windows 11 builds—are present.

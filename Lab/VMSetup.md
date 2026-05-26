# VM Setup

This document covers the configuration of both virtual machines used in this lab. It is intended as a reference for reproducing the environment from scratch and for understanding the decisions behind each configuration choice.

## Hypervisor

VirtualBox is used as the hypervisor on a Windows 11 Pro host. Both VMs are configured through the VirtualBox GUI. No Vagrant or automated provisioning is used. Setup is manual and documented here step by step.

## Victim Machine

The victim machine is a clean Windows 11 Pro installation representing an enterprise workstation. It receives no hardening beyond a standard out-of-box configuration. The goal is to reflect a realistic target system, not a locked-down one.

### Virtual Hardware

| Setting | Value |
|---|---|
| OS | Windows 11 Pro |
| RAM | 8GB |
| CPU Cores | 4 |
| Storage | 80GB dynamically allocated VDI |
| Network Adapter | Host-only adapter only |
| Clipboard | Disabled |
| Drag and Drop | Disabled |

### Software Installed

| Software | Purpose |
|---|---|
| VirtualBox Guest Additions | Display resolution and host integration |
| Windows Updates | Applied to current patch level at time of baseline snapshot |

No investigation tooling is installed on the victim machine. Any tooling that must run on the victim during an investigation is transferred from the analyst machine through the host-only network at the time of the investigation and documented in the relevant investigation notes.

### Snapshot Baseline

After OS installation and Windows updates are applied, two snapshots are taken in order:

1. `baseline-clean` — no tooling, no configuration changes beyond OS setup
2. `baseline-configured` — taken after Guest Additions are installed and display is configured

All investigation scenarios revert to `baseline-clean` or `baseline-configured` as appropriate before beginning.

## Analyst Machine

The analyst machine is a Windows 11 Pro installation used exclusively for triage and analysis. It is never used as a target. All investigation tooling is installed here.

### Virtual Hardware

| Setting | Value |
|---|---|
| OS | Windows 11 Pro |
| RAM | 8GB |
| CPU Cores | 4 |
| Storage | 80GB dynamically allocated VDI |
| Network Adapter | Host-only adapter only |
| Clipboard | Bidirectional (host to analyst only) |
| Drag and Drop | Disabled |

### Software Installed

| Software | Purpose |
|---|---|
| VirtualBox Guest Additions | Display resolution and host integration |
| WinDbg | Process inspection, memory analysis, crash dump examination |
| Volatility 3 | Memory image analysis and artifact extraction |
| MemProcFS | Filesystem-based memory forensics interface |
| KAPE | Artifact collection and triage from live and offline targets |
| Windows Assessment and Deployment Kit (ADK) | WPR and logman support for ETW tracing |
| Python 3 | Required for Volatility 3 and supporting scripts |
| Visual Studio Code | Documentation and script editing |
| Windows Updates | Applied to current patch level at time of baseline snapshot |

### Snapshot Baseline

1. `baseline-clean` — OS installation and updates only
2. `baseline-configured` — all tooling installed and verified functional

## Network Configuration

Both machines use a single VirtualBox host-only network adapter. The host-only network is configured with a static IP range assigned by VirtualBox. Neither machine has a NAT adapter or bridged adapter attached.

| Machine | Adapter | Network |
|---|---|---|
| Victim | Host-only | VirtualBox host-only network |
| Analyst | Host-only | VirtualBox host-only network |

File transfer between the two machines is performed over the host-only network using a shared folder or direct SMB share established at investigation time. No persistent shares are maintained between scenarios.

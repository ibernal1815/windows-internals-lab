# Lab Environment

This document defines the physical and virtual environment used throughout this investigation lab. All investigations documented in this repository were conducted in this environment unless otherwise noted in the individual investigation.

## Host Workstation

| Component | Specification |
|---|---|
| Operating System | Windows 11 Pro |
| CPU | Intel Core i5-14400F |
| RAM | 48GB DDR4 |
| GPU | AMD Radeon RX 7600 |
| Hypervisor | VirtualBox |

## Virtual Machines

Two virtual machines are used throughout this lab. Both run on the host workstation under VirtualBox and are connected exclusively to a host-only network adapter. Neither machine has access to the internet or any external network. All investigation activity is contained within this isolated environment.

| Machine | OS | RAM | Cores | Role |
|---|---|---|---|---|
| Victim | Windows 11 Pro | 8GB | 4 | Instrumented target for investigation scenarios |
| Analyst | Windows 11 Pro | 8GB | 4 | Clean workstation used for triage and analysis |

## Network Configuration

Both virtual machines are attached to a VirtualBox host-only adapter. There is no NAT, no bridged networking, and no external routing of any kind. The host-only adapter allows the two VMs to communicate with each other and with the host workstation for file transfer purposes only.

This configuration reflects a controlled forensic environment where the investigator operates from a clean machine and examines artifacts collected from the target without risking contamination or external exposure.

## Snapshot Strategy

Each virtual machine maintains a baseline snapshot taken immediately after initial OS installation and configuration, before any investigation tooling is installed or any scenarios are run. This baseline is never overwritten.

| Snapshot | Description |
|---|---|
| baseline-clean | Taken after OS installation and Windows updates, before any tooling |
| baseline-configured | Taken after all investigation tooling is installed and configured |

Before each investigation scenario, the victim machine is reverted to the appropriate baseline snapshot to ensure a consistent starting state. The analyst machine is not reverted between scenarios unless contamination is suspected.

## Design Decisions

The analyst and victim machines are kept strictly separated. Tooling lives on the analyst machine. The victim machine is treated as the subject of investigation. This mirrors the separation maintained in real enterprise environments where an investigator collects artifacts from a target system and performs analysis on a dedicated workstation rather than directly on the endpoint.

Full VM configuration details including virtual hardware, adapter settings, and software installed on each machine are documented in `VMSetup.md`.

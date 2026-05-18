# Lab Environment

This project is conducted in a controlled virtual lab designed to reflect realistic student and entry-level IT constraints while still allowing meaningful observation of Windows internals.

The goal of the lab is repeatability, clarity, and isolation. All investigations are performed in virtual machines to avoid impacting the host system and to allow rollback through snapshots.

## Host System

The lab runs on a single workstation with the following specifications:

- Intel i5-14400F CPU
- 48 GB DDR4 RAM
- 512 GB NVMe storage
- Oracle VirtualBox

These resources allow multiple Windows virtual machines to run concurrently while maintaining conservative allocations per VM.

## Virtual Machines

### Windows 11 Pro Workstation

This system is the primary investigation target.

- 2 vCPU
- 6 to 8 GB RAM
- 80 GB disk (thin provisioned)
- Windows 11 Pro
- Sysinternals Suite installed locally
- Sysmon installed with a documented configuration

This VM is used for process, registry, file system, security, and network investigations.

### Windows Server Domain Controller (optional per scenario)

Some scenarios require authentication boundaries and centralized identity.

- 2 vCPU
- 4 to 6 GB RAM
- 60 to 80 GB disk
- Windows Server
- Active Directory Domain Services
- DNS

This VM is only powered on when needed for domain-related scenarios.

## Networking

Virtual machines are connected using VirtualBox host-only networks to ensure isolation from the production network. No external exposure is required for any scenario in this project.

## Snapshot Strategy

Snapshots are used as controlled checkpoints:

- Clean operating system baseline
- Baseline with Sysinternals installed
- Baseline with Sysmon installed
- Pre-scenario snapshot
- Post-scenario snapshot

This approach allows experiments to be repeated and mistakes to be rolled back without contaminating future observations.

## Scope and Safety

All activity remains within the lab environment. No production systems are analyzed or modified. The project focuses on observation and explanation, not exploitation.

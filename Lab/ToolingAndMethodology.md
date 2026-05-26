# Tooling and Methodology

This document explains the tooling used across this lab and the investigative methodology applied to each scenario. It is meant to be read before working through any investigation so the reasoning behind tool selection and workflow decisions is clear.

## Investigative Philosophy

Every investigation in this lab starts from a question or an observed condition, not from a predetermined answer. The workflow moves from broad to narrow: establish what is normal for the system, identify what deviates from that baseline, and then work to explain the deviation using evidence rather than assumption.

The analyst machine is always kept clean and separate from the victim. Tooling does not live on the target. Evidence is collected and brought to the analyst workstation for examination. This discipline is maintained throughout every investigation regardless of the scenario complexity.

## Tooling

### WinDbg

WinDbg is used for process and memory inspection at the internals level. In this lab it operates in usermode, examining live processes, inspecting memory regions, walking process environment blocks, and analyzing crash dumps. It is the primary tool for understanding what Windows is doing beneath the surface of standard event telemetry.

Common use cases in this lab:

- Inspecting the PEB and TEB of a process under investigation
- Examining loaded modules and their base addresses
- Walking the VAD tree to understand memory region permissions and types
- Analyzing minidumps and full memory dumps collected during an investigation

### Volatility 3

Volatility is used for offline memory image analysis. When a memory acquisition is taken from the victim machine, Volatility provides the primary interface for examining processes, network connections, loaded drivers, registry hives, and injected regions within that image.

Volatility is run on the analyst machine against memory images transferred from the victim. It is never run on the victim directly.

### MemProcFS

MemProcFS mounts a memory image as a filesystem, allowing rapid browsing of processes, modules, handles, and registry artifacts without constructing individual plugin commands. It is used alongside Volatility for initial triage of a memory image before narrowing into specific areas of interest.

### KAPE

KAPE is used for structured artifact collection from the victim machine. Collection targets are defined before each relevant investigation and documented in `ArtifactCollection/`. KAPE runs on the victim at investigation time, collects the defined targets, and the output is transferred to the analyst machine for examination.

KAPE is not used for analysis. It is a collection tool only. Analysis of KAPE output is performed on the analyst machine using the appropriate tooling for each artifact type.

### Windows Event Viewer and wevtutil

Event logs are examined both through the GUI Event Viewer during live investigation on the victim and through wevtutil for export and offline analysis. Key channels examined across investigations include:

- Security
- System
- Application
- Microsoft-Windows-PowerShell/Operational
- Microsoft-Windows-TaskScheduler/Operational
- Microsoft-Windows-WMI-Activity/Operational

Exported logs are transferred to the analyst machine and examined there.

### logman and WPR

logman and the Windows Performance Recorder are used to configure and capture ETW traces from the victim machine. ETW sessions are defined per investigation based on the providers relevant to the question being investigated. Traces are captured on the victim and transferred to the analyst machine for analysis.

ETW provider selection and session configuration decisions are documented in `ETW/`.

### Native Windows Utilities

Native utilities are used throughout investigations to gather quick system state information and to corroborate findings from forensic tooling. Key utilities used include:

| Utility | Primary Use |
|---|---|
| tasklist | Process enumeration with PID and session information |
| sc | Service configuration and state inspection |
| reg | Registry key and value querying |
| whoami | Token and privilege inspection |
| netstat | Active connection and listening port enumeration |
| wmic | Process, service, and system object querying |
| schtasks | Scheduled task enumeration |
| icacls | Permission inspection on files and directories |

## Investigation Workflow

Each investigation follows the same general workflow regardless of the specific scenario:

1. Define the question or observed condition that drives the investigation
2. Revert the victim machine to the appropriate baseline snapshot
3. Establish a normal system baseline before introducing any condition
4. Introduce the condition or reproduce the observed behavior
5. Collect relevant artifacts using KAPE, event log export, and ETW traces as appropriate
6. Acquire a memory image if the investigation requires memory analysis
7. Transfer all collected artifacts to the analyst machine
8. Examine artifacts on the analyst machine and document findings
9. Produce a written analysis with supporting evidence references
10. Document takeaways and areas for further investigation

This workflow is reflected in the structure of each investigation folder. Deviations from this workflow are noted in the relevant `InvestigationNotes.md`.

## Evidence Handling

All evidence collected during an investigation is stored in the `Evidence/` subfolder of the relevant investigation. Raw captures, memory images, and exported logs are excluded from version control when they exceed a practical size for repository storage. In those cases, the `Evidence/` folder contains a manifest describing what was collected, where it was stored locally, and the hash values of each artifact.

Screenshots are always included directly in the repository as they are the most accessible form of evidence for a reader following along with the investigation.

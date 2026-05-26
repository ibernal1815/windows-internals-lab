# Windows Internals Investigation Lab

This repository documents a structured Windows internals investigation lab built to develop deep analytical skill in examining Windows systems at the process, memory, registry, and event log layers. The work performed here reflects the investigative depth expected at the L2/L3 SOC and digital forensics level.

The lab operates across two isolated virtual machines: an instrumented victim and a clean analyst workstation. No external network access. No third-party monitoring agents on the victim. Investigations rely on what Windows exposes natively and what purpose-built forensics tooling can extract from it.

## Scope

This is not a malware development lab. It is not a red team lab. The focus is investigative: understanding what happened on a Windows system, why it looks the way it does, and how to reconstruct activity from the artifacts Windows leaves behind.

Topics covered:

- Windows internals concepts including process structures, memory layout, handles, tokens, and the user/kernel boundary
- Deep event log analysis across Security, System, Application, and PowerShell operational channels
- ETW (Event Tracing for Windows) using raw kernel and usermode providers beyond what standard logging captures
- Memory forensics including acquisition, analysis with Volatility and MemProcFS, and process and module inspection
- Artifact collection and triage using KAPE with documented collection targets and output methodology
- Structured triage playbooks covering process anomalies, privilege escalation, and lateral movement indicators
- Native Windows investigation using built-in utilities to reconstruct activity without relying on third-party tooling

## Tooling

| Tool | Purpose |
|---|---|
| WinDbg | Process and memory inspection, crash dump analysis, internals exploration |
| Volatility | Memory image analysis, process and module enumeration, artifact extraction |
| MemProcFS | Memory forensics with a filesystem interface for rapid artifact browsing |
| KAPE | Structured artifact collection from live and offline systems |
| Windows Event Viewer / wevtutil | Event log querying and export |
| logman / WPR | ETW session configuration and trace capture |
| tasklist, netstat, sc, reg, whoami, wmic | Native Windows utilities used throughout investigations |

## Repository Structure

```
Lab/                    Environment specifications, VM configuration, tooling methodology, and changelog
Investigations/         Structured investigation walkthroughs with background, notes, analysis, and evidence
Playbooks/              Repeatable triage workflows for common investigation scenarios
ETW/                    ETW provider reference material and trace configuration notes
MemoryForensics/        Memory acquisition procedures and Volatility analysis documentation
ArtifactCollection/     KAPE targets, collection methodology, and artifact handling notes
References/             Windows internals concepts, event log field reference, and native tool documentation
```

## Lab Environment

Two virtual machines running in VirtualBox on a single host workstation. Both machines are connected to a host-only network adapter with no external routing. The victim machine receives no hardening beyond a standard enterprise baseline. The analyst machine has no tooling installed on the victim and maintains clean separation throughout each investigation.

| Machine | OS | RAM | Cores | Role |
|---|---|---|---|---|
| Victim | Windows 11 Pro | 12GB | 4 | Instrumented target |
| Analyst | Windows 11 Pro | 12GB | 4 | Triage and analysis workstation |

Host specifications and full VM configuration are documented in `Lab/LabEnvironment.md` and `Lab/VMSetup.md`.

## Investigation Structure

Each investigation follows a consistent format:

- `Background.md` defines the starting question or observed condition
- `InvestigationNotes.md` documents the live investigative process
- `Analysis.md` contains findings, interpretations, and supporting evidence references
- `Takeaways.md` summarizes conclusions and skills reinforced
- `Evidence/` holds screenshots, captures, and exported artifacts relevant to the investigation

## Starting Point

1. `Lab/LabEnvironment.md`
2. `Lab/ToolingAndMethodology.md`
3. `Playbooks/TriageWorkflow.md`
4. `Investigations/Investigation01_ApplicationStartup`

## License

This project is licensed under the MIT License. See LICENSE for details.

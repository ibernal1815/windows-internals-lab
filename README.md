# Windows Internals Sysinternals Lab

This repository documents a structured Windows internals investigation project using Microsoft Sysinternals tools and Sysmon. The goal is to build practical skill in observing and explaining Windows behavior at the process, memory, registry, file system, security, and network layers.

All work is performed in a controlled lab environment. The focus is troubleshooting and system understanding, not malware research or offensive activity.

## What this project covers

1. Process behavior and parent child relationships
2. Application startup activity across files, registry, and DLL loading
3. Windows services, service identity, and access boundaries
4. Persistence mechanisms used in normal Windows operations
5. Privilege boundaries, UAC, and token behavior
6. Unexpected system activity investigations using evidence
7. Remote administration traces using PsExec in a lab context
8. Sysmon telemetry design and practical tradeoffs

## Primary tools

1. Process Explorer
2. Process Monitor
3. Autoruns
4. TCPView
5. PsExec
6. Sysmon

Native Windows utilities are used when they help confirm a finding, but Sysinternals remains the core tooling.

## Repository layout

The repo is organized like a lab binder. Each scenario stands on its own with a consistent structure and supporting evidence.

1. LabOverview
   1. LabEnvironment.md
   2. ToolingAndMethodology.md
   3. ChangeLog.md

2. Scenarios
   1. Scenario folders contain background, notes, analysis, takeaways, and evidence

3. Sysmon
   1. SysmonConfig.md explains logging choices
   2. Configs contains the versioned Sysmon configuration

4. References
   1. Notes on Sysinternals tools and Windows internals concepts written in plain language

## How to use this repo

If you are reading this project, start here:

1. LabOverview/LabEnvironment.md
2. LabOverview/ToolingAndMethodology.md
3. Scenarios/Scenario01_ApplicationStartup

Each scenario follows the same flow:

1. Background and question
2. Observation using Sysinternals
3. Analysis of findings
4. Practical takeaways for IT operations

## Lab constraints

This project is designed to fit a single student workstation running VMware Workstation Pro with conservative VM sizing. Evidence files are kept minimal and relevant. Large raw captures are excluded from version control when they are not useful to reviewers.

## License

This project is licensed under the MIT License. See LICENSE for details.

# windows-internals-lab

A structured Windows internals investigation project using Microsoft Sysinternals tools and Sysmon. The goal is to build practical skill in observing and explaining Windows behavior at the process, memory, registry, file system, security, and network layers.

## Background / Why I Built This

You can read about how Windows handles processes, tokens, and services all day. At some point you have to actually watch it happen. I built this lab to get comfortable with Sysinternals as a primary investigation toolkit and to understand what normal Windows behavior looks like before trying to identify what is abnormal.

Everything here is focused on system understanding and observation. The same skills that make you good at this make you better at spotting malicious activity because you know what legitimate behavior looks like first.

## What This Covers

1. Process behavior and parent-child relationships
2. Application startup activity across files, registry, and DLL loading
3. Windows services, service identity, and access boundaries
4. Persistence mechanisms used in normal Windows operations
5. Privilege boundaries, UAC, and token behavior
6. Unexpected system activity investigations using evidence
7. Remote administration traces using PsExec in a lab context
8. Sysmon telemetry design and practical tradeoffs

## Primary Tools

Process Explorer, Process Monitor, Autoruns, TCPView, PsExec, and Sysmon. Native Windows utilities are used when they help confirm a finding, but Sysinternals is the core tooling throughout.

## Repository Layout

```
LabOverview/
    LabEnvironment.md
    ToolingAndMethodology.md
    ChangeLog.md
Scenarios/
    each scenario folder contains background, notes, analysis, takeaways, and evidence
Sysmon/
    SysmonConfig.md explains logging choices
    Configs/ contains versioned Sysmon configurations
References/
    notes on Sysinternals tools and Windows internals concepts in plain language
```

## How to Use This Repo

Start here:

1. LabOverview/LabEnvironment.md
2. LabOverview/ToolingAndMethodology.md
3. Scenarios/Scenario01_ApplicationStartup

Each scenario follows the same flow: background and question, observation using Sysinternals, analysis of findings, and practical takeaways.

## Lab Constraints

Designed to fit a single student workstation running VMware Workstation Pro with conservative VM sizing. Evidence files are kept minimal and relevant. Large raw captures are excluded from version control when they are not useful to reviewers.

## Stack

Sysinternals Suite · Sysmon · Windows Event Viewer · VMware Workstation Pro

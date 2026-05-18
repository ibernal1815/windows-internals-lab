# Sysinternals Notes

This document summarizes the purpose of each Sysinternals tool used in the project and the types of questions it helps answer. These notes reflect practical usage rather than exhaustive feature lists.

## Process Explorer

Process Explorer provides a detailed view of running processes and their relationships.

Key uses in this project include:

- Identifying parent-child process chains
- Examining command-line arguments
- Inspecting integrity levels and security tokens
- Viewing loaded DLLs and handles

It is often the first tool used to establish context before deeper investigation.

## Process Monitor

Process Monitor captures detailed system activity across several subsystems.

In this project, it is primarily used to:

- Observe application startup behavior
- Identify file and registry access patterns
- Detect access denied conditions
- Understand search order and fallback behavior

Filtering is essential. Unfiltered output is intentionally avoided.

## Autoruns

Autoruns provides visibility into the many persistence mechanisms supported by Windows.

It is used to:

- Compare different startup mechanisms
- Identify why software launches automatically
- Understand how legitimate software maintains state across reboots

This tool reinforces that persistence is not inherently malicious.

## TCPView

TCPView maps network connections to processes in real time.

It is used to:

- Confirm which processes are responsible for network activity
- Distinguish local system communication from external connections
- Support investigations into unexpected network usage

## PsExec

PsExec enables remote process execution using administrative credentials.

In this lab, it is used to:

- Demonstrate legitimate administrative tooling
- Observe authentication and execution traces
- Correlate remote actions with logs and telemetry

## Sysmon

Sysmon records detailed system events to the Windows event log.

It is used to:

- Capture process creation events over time
- Record network connections and image loads
- Provide historical context that complements live tools

Sysmon configuration is treated as a design decision rather than a default.

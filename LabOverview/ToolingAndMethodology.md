# Tooling and Methodology

This project prioritizes understanding Windows behavior through direct observation. Tools are selected based on their ability to expose system internals clearly rather than their novelty or complexity.

## Core philosophy

The methodology follows a simple loop:

1. Ask a specific question about system behavior
2. Observe using the appropriate Sysinternals tool
3. Correlate findings across tools when possible
4. Explain why Windows behaved that way
5. Extract practical operational takeaways

Raw output alone is not considered evidence of understanding. Reasoning and interpretation are emphasized throughout the documentation.

## Primary tools

### Process Explorer

Used to examine running processes, parent child relationships, command lines, integrity levels, tokens, and loaded modules. This tool answers questions about *what is running* and *under what context*.

### Process Monitor

Used for real time and captured observation of file system, registry, process, and network activity. Filtering is applied deliberately to reduce noise and focus on the question being asked.

### Autoruns

Used to enumerate persistence mechanisms that Windows supports by design, including services, scheduled tasks, registry run keys, and startup folders.

### TCPView

Used to observe network connections associated with specific processes and to correlate network activity with process behavior.

### PsExec

Used in controlled scenarios to demonstrate legitimate remote execution and administrative behavior, along with the traces such actions leave behind.

### Sysmon

Used as a persistent telemetry source. Sysmon complements Process Monitor by recording key events over time rather than during a live capture session.

## Supporting tools

Native Windows tools such as Event Viewer, Services MMC, Task Scheduler, and command line utilities are used to validate or contextualize findings when appropriate.

## Evidence handling

Large raw captures are not treated as deliverables. Instead:

- Only relevant excerpts are retained
- Findings are described in writing
- Screenshots are used sparingly and only when they clarify a concept

This mirrors real world troubleshooting, where explanation and judgment matter more than volume of data.

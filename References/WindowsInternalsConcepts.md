# Windows Internals Concepts

This document captures key Windows internals concepts encountered during the project, written in practical terms and reinforced by direct observation.

## Process Creation

When an application starts, Windows performs several steps:

- A parent process initiates creation
- The executable image is mapped into memory
- Required DLLs are resolved and loaded
- Security context and integrity level are assigned

Understanding the parent process and command line is often enough to determine how and why a process started.

## Security Tokens and Integrity Levels

Every process runs with a security token that defines its identity and privileges.

Integrity levels control what a process can modify:

- Low integrity processes are heavily restricted
- Medium integrity is standard user context
- High integrity indicates elevated administrative context

UAC changes the token, not the user account.

## Services and Service Accounts

Windows services run in non-interactive sessions and often under special service accounts.

Common service identities include:

- LocalSystem
- NetworkService
- LocalService

Each has different access rights. Service failures are frequently permission-related rather than functional.

## Registry Behavior

The registry is queried frequently, often across multiple locations.

A missing key does not indicate an error. It usually reflects Windows checking multiple possible configuration paths before using defaults.

This explains why NAME NOT FOUND results are common in Process Monitor captures.

## DLL Loading and Search Order

When an application loads a DLL, Windows follows a defined search order.

This behavior explains:

- Why applications check multiple directories
- Why missing DLLs cause startup failures
- How compatibility layers and redirection work

## Persistence Mechanisms

Windows supports many persistence mechanisms by design:

- Services
- Scheduled tasks
- Run registry keys
- Startup folders

Understanding these mechanisms is essential for both troubleshooting and security awareness.

## Telemetry and Logging

No single tool provides complete visibility.

- Process Explorer shows current state
- Process Monitor shows live activity
- Sysmon provides historical telemetry

Effective analysis comes from correlating multiple views.

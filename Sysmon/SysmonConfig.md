# Sysmon Configuration

This document explains the logging decisions made for this lab and the reasoning behind them.

## Base Configuration

This lab uses the [SwiftOnSecurity sysmon-config](https://github.com/SwiftOnSecurity/sysmon-config) as a starting point. It is a well-maintained, community-vetted configuration that provides strong coverage of common attacker techniques while filtering out high-volume noise that would make Event Viewer unusable.

The goal here is not to capture everything. It is to capture the right things and understand why those events matter.

## What Gets Logged

### Process Creation (Event ID 1)

Every process creation event is logged with the full command line, parent process, and hashes. This is the most valuable event type for understanding what is running and how it got there. Command-line logging is enabled because the image name alone is often not enough context.

### Network Connections (Event ID 3)

Outbound network connections are logged with the initiating process, destination IP, and port. This makes it possible to correlate network activity with specific processes rather than relying on packet captures alone.

### Image Loads (Event ID 7)

DLL and driver loads are logged selectively. Full image load logging generates significant volume so the SwiftOnSecurity config filters common signed Microsoft DLLs. Unsigned or suspicious image loads remain visible.

### Process Access (Event ID 10)

Cross-process access events are logged to surface potential injection attempts and credential access patterns. LSASS access in particular is a key indicator this config is tuned to catch.

### Registry Events (Event IDs 12, 13, 14)

Registry key creation, modification, and deletion are logged for paths commonly associated with persistence. Run keys, services, and scheduled task paths are included. High-volume system registry churn is filtered out.

### File Creation (Event ID 11)

File creation events are logged for directories commonly used for staging and persistence, including temp folders, startup directories, and the user profile. System directories with high legitimate write volume are excluded.

### Pipe Events (Event IDs 17, 18)

Named pipe creation and connection events are logged. These surface lateral movement tools like PsExec and common C2 frameworks that rely on named pipes for communication.

## What Gets Excluded

High-volume legitimate activity is excluded to keep Event Viewer usable. This includes most Microsoft-signed process activity, routine svchost network connections, standard registry reads during normal operation, and Windows Update activity.

The full exclusion list is documented in the config file itself with inline comments explaining each decision.

## Viewing Events

All Sysmon events are written to the Windows event log under:

```
Applications and Services Logs > Microsoft > Windows > Sysmon > Operational
```

Open Event Viewer, navigate to that path, and filter by Event ID to focus on specific event types.

## References

[SwiftOnSecurity sysmon-config](https://github.com/SwiftOnSecurity/sysmon-config)
[Sysmon documentation](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)
[Sysmon event ID reference](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx)

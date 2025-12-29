# Network and Identity Configuration

## Virtual Networking
The lab utilizes **VMnet1** in a Host-Only configuration. I have explicitly disabled the VMware DHCP service to allow the Windows Server 2022 instance to act as the authoritative DHCP and DNS provider.

* **Subnet:** 192.168.10.0/24
* **DHCP Range:** 192.168.10.50 - 192.168.10.150

## Identity Management
The lab utilizes a tiered account structure to test permission-based troubleshooting scenarios in Sysinternals.

| Machine | Account Name | Role |
| :--- | :--- | :--- |
| **DC-01** | LAB\DomainAdmin | Full Domain Authority |
| **WS-01** | LAB\StandardUser | Limited user for testing permission denied errors |
| **WS-01** | .\LocalAdmin | Local emergency management |

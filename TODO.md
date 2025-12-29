# Project Roadmap & Progress

## Phase 1: Infrastructure (Complete)
- [x] Install VMware Workstation Pro.
- [x] Build "Golden Image" for Windows 10 Enterprise.
- [x] Configure Host-Only networking to isolate the lab.
- [x] Setup Linked Clones for CL-01 and CL-02 to save NVMe space.

## Phase 2: Domain Services (In Progress)
- [x] Promote DC-01 to a Domain Controller.
- [ ] Join Client machines to the domain.
- [ ] Create a "Standard User" and "Local Admin" for permission testing.
- [ ] Set up a Centralized File Share for log collection.

## Phase 3: Sysinternals Implementation
- [ ] Write a PowerShell script to auto-deploy the Sysinternals Suite.
- [ ] Configure Sysmon with a custom XML (SwiftOnSecurity base) for enhanced logging.
- [ ] Set up Event Forwarding from Clients to the DC.

## Phase 4: Practical Scenarios (The "War Games")
- [ ] **Scenario 01:** Simulate a broken application install and find the missing DLL using ProcMon.
- [ ] **Scenario 02:** Create a hidden "malware" persistence key and locate it using Autoruns.
- [ ] **Scenario 03:** Debug a "slow boot" issue using Windows Performance Toolkit and Thread analysis in Process Explorer.

## Phase 5: Documentation & Polish
- [ ] Finalize the network topology diagram.
- [ ] Export and sanitize Event Logs for the `evidence/` folder.
- [ ] Record a brief walkthrough of the lab in action.
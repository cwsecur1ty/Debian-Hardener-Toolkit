# Linux-Hardener-Toolkit
A toolkit for automating Linux security hardening and compliance auditing
# Structure Overview
```
linux-security-hardening-toolkit/
│
├── audits/
│   ├── audit_permissions.sh
│   ├── audit_users.sh
│   └── audit_network.sh
│
├── configs/
│   ├── harden_permissions.sh
│   ├── harden_users.sh
│   └── harden_network.sh
│
├── reports/
│   └── generate_report.py
│
├── tests/
│   ├── test_audit_permissions.sh
│   ├── test_harden_permissions.sh
│   └── test_generate_report.py
│
├── utils/
│   └── common_functions.sh
│
├── main.py
├── README.md
└── requirements.txt
```
# Summary of Each File
audits/
- audit_permissions.sh: Checks for world-writable files.
- audit_users.sh: Checks for user accounts with no password set.
- audit_network.sh: Checks for open ports and unnecessary services.
configs/
- harden_permissions.sh: Removes world-writable permissions from files.
- harden_users.sh: Enforces password policies and locks user accounts with no password.
- harden_network.sh: Disables unnecessary services and configures the firewall.
reports/
- generate_report.py: Generates a JSON report based on the audit results.
tests/
- test_audit_permissions.sh: Tests the audit_permissions.sh script.
- test_harden_permissions.sh: Tests the harden_permissions.sh script.
- test_generate_report.py: Tests the generate_report.py script.
utils/
- common_functions.sh: Contains reusable functions such as checking for root privileges, logging messages, and backing up files.
Root Directory
- main.py: The script orchestrates the audit, hardening, and report generation processes.
- README.md: Project description, installation instructions, and usage examples.
- requirements.txt: Lists Python dependencies if any.

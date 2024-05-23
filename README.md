# Linux-Hardener-Toolkit
A toolkit for automating Linux security hardening and compliance auditing
## Features
- System configuration auditing
- Automated security configuration changes
- Compliance reporting
## Installation
1. Clone the repository:
   
   ```bash
   git clone https://github.com/yourusername/LinuxSecToolkit.git
   cd LinuxSecToolkit
   ```
2. Ensure audit and hardening scripts are executable:
   ```bash
   chmod +x audits/*.sh
   chmod +x configs/*.sh
   chmod +x tests/*.sh
   chmod +x utils/common_functions.sh
   ```
# Running Tests
You can run test scripts to verify everything works as expected ->
```bash
bash tests/test_audit_permissions.sh
bash tests/test_harden_permissions.sh
python3 tests/test_generate_report.py
```
# Using the Toolkit
To use the toolkit, run main.py with any of these arguments:
```bash
python3 main.py --audit
python3 main.py --harden
python3 main.py --report
```
# Structure Overview
```
linux-security-hardening-toolkit/
│
├── audits/
│   ├── audit_permissions.sh
│   ├── audit_users.sh
│   ├── audit_network.sh
│   └── audit_updates.sh
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
### audits/
- audit_permissions.sh: Checks for world-writable files.
- audit_users.sh: Checks for user accounts with no password set.
- audit_network.sh: Checks for open ports and unnecessary services.
- audit_updates.sh: Checks for latest security patches.
### configs/
- harden_permissions.sh: Removes world-writable permissions from files.
- harden_users.sh: Enforces password policies and locks user accounts with no password.
- harden_network.sh: Disables unnecessary services and configures the firewall.
### reports/
- generate_report.py: Generates a JSON report based on the audit results.
### tests/
- test_audit_permissions.sh: Tests the audit_permissions.sh script.
- test_harden_permissions.sh: Tests the harden_permissions.sh script.
- test_generate_report.py: Tests the generate_report.py script.
### utils/
- common_functions.sh: Contains reusable functions such as checking for root privileges, logging messages, and backing up files.
### Root Directory
- main.py: The script orchestrates the audit, hardening, and report generation processes.
- README.md: Project description, installation instructions, and usage examples.
- requirements.txt: Lists Python dependencies if any.

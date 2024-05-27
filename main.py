import subprocess
import argparse # to handle command-line arguments
import os


def run_script(script_path): 
    # Executes a given Bash script and captures its output
    result = subprocess.run(['bash', script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
    return result.stdout, result.stderr



def audit_system():
    print("\n[NOTICE] Don't forget to make sure the audit scripts are executable. ('chmod +x audits/*.sh')")
    print("[*] Running system audits.\n")
    
    audit_scripts = [
        'audits/audit_permissions.sh',
        'audits/audit_users.sh',
        'audits/audit_network.sh',
        'audits/audit_updates.sh',
        'audits/audit_ssh_config.sh'  
    ]
    
    audit_results = {}
    for script in audit_scripts:
        print(f"[*] Running {script}.")
        stdout, stderr = run_script(script) # executes a given Bash script and captures its output
        audit_results[os.path.basename(script)] = {
            'output': stdout,
            'error': stderr
        }
    
    return audit_results

def harden_system():
    print("\n[NOTICE] Don't forget to make sure the hardening scripts are executable. ('chmod +x configs/*.sh')")
    print("[*] Applying security hardening.\n")
    
    harden_scripts = [
        'configs/harden_permissions.sh', # Searches for word-writable files and chmods them, sets /etc to 700
        'configs/harden_users.sh',       # Sets password policy, locks user accounts with no passwords.
        'configs/harden_network.sh',     # Disables telnet, configures Firewall using ufw to have an implicit deny on incoming traffic, allows all outgoing and allows ssh connections.   
        'configs/harden_ssh_config.sh',  # Hardens SSH Configuration, disables root login, amongst other things.
        'configs/harden_fail2ban.sh'     # Installs & Configures Fail2Ban
    ]
    
    harden_results = {}
    for script in harden_scripts:
        print(f"[*] Running {script}.")
        stdout, stderr = run_script(script) # executes a given Bash script and captures its output
        harden_results[os.path.basename(script)] = {
            'output': stdout,
            'error': stderr
        }
    
    return harden_results

def generate_report(audit_results):
    from reports import generate_report

    print("\n[!] Generating compliance report.")
    generate_report.generate_report(audit_results)
    print("[+] Audit report generated at 'reports/audit_report.json'")

def main():
    parser = argparse.ArgumentParser(description="Linux Security Hardening Toolkit")
    parser.add_argument('--audit', action='store_true', help='Run system audits')
    parser.add_argument('--harden', action='store_true', help='Apply security hardening')
    parser.add_argument('--report', action='store_true', help='Generate compliance report')

    args = parser.parse_args()
    
    if args.audit:
        audit_results = audit_system()
        print("Audit Results:", audit_results)
    
    if args.harden:
        harden_results = harden_system()
        print("Hardening Results:", harden_results)
    
    if args.report:
        # Assuming audit results are required for the report
        audit_results = audit_system()
        generate_report(audit_results)

if __name__ == "__main__":
    main()

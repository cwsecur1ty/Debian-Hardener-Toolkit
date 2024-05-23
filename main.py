import subprocess
import argparse # to handle command-line arguments
import os

def run_script(script_path): # executes a given Bash script and captures its output
    result = subprocess.run(['bash', script_path], capture_output=True, text=True)
    return result.stdout, result.stderr

def audit_system():
    print("\n[NOTICE] Don't forget to make sure the audit scripts are executable. ('chmod +x audits/*.sh')")
    print("[*] Running system audits.\n")
    
    audit_scripts = [
        'audits/audit_permissions.sh',
        'audits/audit_users.sh',
        'audits/audit_network.sh',
        'audits/audit_updates.sh'  
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
        'configs/harden_permissions.sh',
        'configs/harden_users.sh',
        'configs/harden_network.sh'
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

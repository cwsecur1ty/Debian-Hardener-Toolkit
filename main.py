import subprocess
import argparse
import os
import logging

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def run_script(script_path):
    """
    Executes a given Bash script and captures its output.
    Returns stdout and stderr as a tuple.
    """
    try:
        result = subprocess.run(['bash', script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        return result.stdout, result.stderr
    except Exception as e:
        logging.error(f"Failed to run script {script_path}: {e}")
        return "", str(e)

def audit_system():
    """
    Runs the system audit scripts and captures their outputs.
    Returns a dictionary with the audit results.
    """
    logging.info("Running system audits. Ensure audit scripts are executable ('chmod +x audits/*.sh').")

    audit_scripts = [
        'audits/audit_permissions.sh',
        'audits/audit_users.sh',
        'audits/audit_updates.sh',
        'audits/audit_ssh_config.sh'
    ]
    
    audit_results = {}
    for script in audit_scripts:
        logging.info(f"Running {script}.")
        stdout, stderr = run_script(script)
        audit_results[os.path.basename(script)] = {
            'output': stdout,
            'error': stderr
        }
    
    return audit_results

def print_audit_results(audit_results):
    """
    Prints the results of the audit scripts.
    """
    logging.info("Audit Results:")
    for script, results in audit_results.items():
        logging.info(f"Results for {script}:")
        logging.info(f"Output:\n{results['output']}")
        if results['error']:
            logging.error(f"Error:\n{results['error']}")

def harden_system():
    """
    Runs the system hardening scripts and captures their outputs.
    Returns a dictionary with the hardening results.
    """
    logging.info("Applying security hardening. Ensure hardening scripts are executable ('chmod +x configs/*.sh').")
    
    harden_scripts = [
        'configs/harden_permissions.sh',
        'configs/harden_users.sh',
        'configs/harden_ssh_config.sh',
        'configs/harden_fail2ban.sh'
    ]
    
    harden_results = {}
    for script in harden_scripts:
        logging.info(f"Running {script}.")
        stdout, stderr = run_script(script)
        harden_results[os.path.basename(script)] = {
            'output': stdout,
            'error': stderr
        }
    
    return harden_results

def print_harden_results(harden_results):
    """
    Prints the results of the hardening scripts.
    """
    logging.info("Hardening Results:")
    for script, results in harden_results.items():
        logging.info(f"Results for {script}:")
        logging.info(f"Output:\n{results['output']}")
        if results['error']:
            logging.error(f"Error:\n{results['error']}")

def generate_report(audit_results):
    """
    Generates a compliance report based on the audit results.
    """
    from reports import generate_report
    logging.info("Generating compliance report.")
    generate_report.generate_report(audit_results)
    logging.info("Audit report generated at 'reports/audit_report.json'")

def main():
    """
    Main function to parse command-line arguments and trigger the appropriate functions.
    """
    parser = argparse.ArgumentParser(description="Linux Security Hardening Toolkit")
    parser.add_argument('--audit', action='store_true', help='Run system audits')
    parser.add_argument('--harden', action='store_true', help='Apply security hardening')
    parser.add_argument('--report', action='store_true', help='Generate compliance report')

    args = parser.parse_args()
    
    if args.audit:
        audit_results = audit_system()
        print_audit_results(audit_results)
    
    if args.harden:
        harden_results = harden_system()
        print_harden_results(harden_results)
    
    if args.report:
        audit_results = audit_system()
        generate_report(audit_results)

if __name__ == "__main__":
    main()

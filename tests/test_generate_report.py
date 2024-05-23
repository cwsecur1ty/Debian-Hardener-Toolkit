import json
import os
import subprocess
from reports import generate_report

def test_generate_report():
    """Test the generate_report function."""
    # Define a mock audit result
    # This mock result simulates the output of the audit scripts
    mock_audit_results = {
        'audit_permissions.sh': {
            'output': 'World-writable files: /tmp/test_world_writable_file\n',
            'error': ''
        },
        'audit_users.sh': {
            'output': 'Users with no password set: testuser\n',
            'error': ''
        },
        'audit_network.sh': {
            'output': 'Open ports: 22/tcp\nTelnet service status: inactive\n',
            'error': ''
        }
    }

    # Generate the report using the mock audit results
    # This calls the generate_report function with the mock data
    generate_report.generate_report(mock_audit_results)

    # Check if the report file exists
    report_path = 'reports/compliance_report.json'
    if os.path.exists(report_path):
        with open(report_path, 'r') as report_file:
            report_data = json.load(report_file)
            # Verify that the report data matches the mock audit results
            # This ensures the report was generated correctly with the provided data
            assert report_data['audit_results'] == mock_audit_results
            print("PASS: generate_report.py generated the report correctly.")
    else:
        print("FAIL: generate_report.py did not generate the report.")

if __name__ == "__main__":
    test_generate_report()
    # If the script is executed directly, run the test

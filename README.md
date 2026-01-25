Sentinel-FIM: Cloud-Based File Integrity Monitoring System
Project Overview

Sentinel-FIM is a cloud-native cybersecurity solution designed to detect unauthorized file changes, integrity breaches, and potential ransomware activity in real time. Deployed on Microsoft Azure, it utilizes a Wazuh SIEM framework to monitor critical files and generate instant alerts upon any modification.
Tech Stack

    Cloud Platform: Microsoft Azure (Virtual Machines)

    SIEM Framework: Wazuh Manager (v4.7)

    Endpoint Agent: Wazuh Agent (v4.7)

    Operating System: Ubuntu Linux 20.04 LTS

    Security Modules: File Integrity Monitoring (FIM), Syscheck

Proof of Concept
<img width="1790" height="1015" alt="dashboard_proof" src="https://github.com/user-attachments/assets/29ab52ef-c0d8-4035-a612-5e2f0a3809e6" />


Demonstrates real-time detection of file creation, modification, and deletion events.
Architecture

The Sentinel-FIM architecture consists of two main components:

    SOC-Core (Manager): Central server responsible for log analysis and hosting the Kibana dashboard.

    Honey-Sensor (Honeypot): A deliberately vulnerable endpoint that reports all file activity and anomalies to the manager for investigation.

FIM Configuration

To enable real-time monitoring of sensitive directories, the following <syscheck> rule was added to the agent’s ossec.conf file:

xml
<directories check_all="yes" report_changes="yes" realtime="yes">/home/azureuser/secret_project</directories>

This configuration allows immediate detection and reporting of any file creation, modification, or deletion within the specified directory.

##  Attack Simulation (How it Works)

To verify the system, I performed a simulated "Insider Threat" attack on the **Honey-Sensor** endpoint. Here are the exact commands used to trigger the alerts shown in the dashboard:

### 1. The Setup
First, I created a "secret" directory and placed a dummy file inside it to represent sensitive data.

```bash
# Create the monitored directory
mkdir -p /home/azureuser/secret_project

# Create a dummy file ("Safe Data")
echo "Confidential Data" > /home/azureuser/secret_project/sensitive_file.txt

**Open Source Audit: Python**
Student: Sneha Rakundla
Course: Open Source Software (NGMC)
Software Audited: Python (PSF License)

Project Overview
This repository contains the technical components for the OSS Capstone Project. It includes a series of Bash scripts designed to audit the Python environment on a Linux system, demonstrating the transparency, security, and accessibility of open-source tools.

Included Scripts
The following scripts were developed to perform a deep-dive audit of the local environment:

1_system_identity.sh: Identifies the host operating system, kernel version, and associated OS licensing.
2_package_inspector.sh: Audits the presence of Python 3 and retrieves metadata regarding the specific build and versioning.
3_disk_auditor.sh: Analyzes the physical file footprint of Python within the /usr/lib directory to understand system-level integration.
4_log_analyzer.sh: Scans system logs (/var/log/dpkg.log) to track the history of Python-related installations and updates.
5_manifesto.sh: An interactive script that generates a personalized Free and Open Source Software (FOSS) manifesto.

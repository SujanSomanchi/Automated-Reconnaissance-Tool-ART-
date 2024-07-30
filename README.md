The Reconnaissance Automation Tool is a shell-based tool developed to automate the reconnaissance phase of cybersecurity assessments. By inputting a keyword, this performs an extensive information-gathering process on the target domain, compiling critical details about its infrastructure, services, and potential vulnerabilities. 
This tool employs several advanced techniques to achieve this: 
  1. Google Dorking: It uses specialized Google search queries to uncover 
  URLs, IP addresses, and other relevant information related to the target 
  domain. 
  2. Nmap Scanning: The tool conducts an all-port scan using Nmap to identify open ports on the target system. It follows up with an aggressive scan to provide detailed insights into the services running on these ports. 
  3. Firewall Detection: RAT identifies and analyzes firewall rules and configurations on the target system, which is crucial for understanding the security posture and potential limitations in scanning results.
The output from this tool is a comprehensive report that includes: 
• A list of URLs and related data obtained through Google Dorking. 
• A detailed enumeration of open ports and the services associated with them, gathered from Nmap scanning. 
• Information on detected firewall configurations and rules. 
• A summarized analysis of the target's infrastructure and potential 
vulnerabilities. 
By automating the reconnaissance phase, this tool significantly reduces the time and resources required for security professionals, allowing them to concentrate on more critical tasks like developing and implementing mitigation strategies. Its user-friendly command-line interface and customizable options make it an indispensable tool for penetration testers, security researchers, and incident responders, enabling them to efficiently gather essential information and identify potential security threats.
Process represented in a Diagram:
![image](https://github.com/user-attachments/assets/f87d6491-d416-410f-977b-8ea694e6c777)

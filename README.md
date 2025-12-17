*This project has been created as part of the 42 curriculum by stmaire.*

# Description

**Born2beroot** is a system administration project designed to introduce us to the rigorous rules of setting up a secure server. The goal is to create a virtual machine (VM) that mimics a robust server environment, implementing strict security policies, partitioning, and automated monitoring.

This project covers the basics of:
- Virtualization (VirtualBox).
- Operating System installation (Debian).
- Logical Volume Management (LVM).
- SSH service configuration.
- Firewall setup (UFW).
- Password policies and sudo configuration.
- Bash scripting for server monitoring.

# Instructions

Since this is a system administration project, there is no code to compile (no `make`). The project is evaluated based on the state of the Virtual Machine and its configuration files.

### 1. Prerequisites
- **VirtualBox** (or UTM) must be installed.
- The `signature.txt` file in this repository contains the SHA1 checksum of the virtual disk (`.vdi`).

### 2. How to verify the signature
To ensure the VM has not been modified since the repository submission:
1. Locate the virtual disk file on the computer.
2. Run the following command:
   ```bash
      shasum born2beroot.vdi
### 3. Usage
- Start the Virtual Machine.
- Log in using the non-root user (e.g., `stmaire`) or root.
- The monitoring script broadcasts system information every 10 minutes on all terminals.
- Connect via SSH on port 4242:
	```bash
	   ssh user@localhost -p 4242
# Resources

### Classic Resources
To successfully complete this system administration project, I relied on the following standard resources:

* **Debian Administrator's Handbook**
* **Linux `man` pages:** (`man hostname`, `man sshd_config`, `man pam.d`, `man crontab`, `man wall`).
* **UFW Documentation**

### AI Usage
In the context of this project, Artificial Intelligence (ChatGPT / Gemini) was used as a **learning assistant**, in compliance with the school's rules. It was not used to generate the final disk image.

AI was utilized for the following tasks:
1.  **Bash Scripting:** Helped debug syntax errors in the monitoring script (`monitoring.sh`), 
2.  **Technical Understanding:** Clarified system concepts, such as TTY, LVM or cron
4.  **Documentation:** Assisted in structuring and translating this `README.md` file to ensure clarity and professional formatting.

# Project Description 

### Operating System Choice: Debian vs Rocky Linux
For this project, I chose **Debian (Stable)** over Rocky Linux.

| Feature | Debian | Rocky Linux (RHEL based) |
| :--- | :--- | :--- |
| **Philosophy** | Community-driven, strictly open-source, prioritizes stability. | Enterprise-driven (Red Hat clone)|
| **Security Module** | AppArmor (Default) | SELinux (Default) |
| **Pros** | Huge package repository, legendary stability, extensive documentation. | Industry standard for corporate environments using RHEL, long lifecycle. |
| **Why Debian?** | I selected Debian for its renowned stability and its large community support. The `apt` package manager is widely used and well-documented, making it an ideal choice for learning system administration fundamentals without the complexity of enterprise-specific tools found in RHEL. |

### Technical Comparisons

#### AppArmor vs SELinux
Since I chose Debian, **AppArmor** is installed by default.
* **AppArmor (Application Armor):** A path-based MAC (Mandatory Access Control) system. It restricts programs' capabilities based on file paths. Profiles are generally easier to read and configure for beginners.
* **SELinux (Security-Enhanced Linux):** A label-based MAC system. Every file, process, and port has a specific security label. It offers very granular and powerful control but is notoriously complex to configure.

#### UFW vs Firewalld
I implemented **UFW** (Uncomplicated Firewall).
* **UFW:** Easy to use. It simplifies firewall management with straightforward syntax (e.g., `ufw allow 4242`). It is the standard on Debian/Ubuntu systems.
* **Firewalld:** A dynamic firewall manager that uses "zones" to define trust levels for network interfaces. It is more complex and flexible, typically the default on RHEL/Rocky systems.

#### VirtualBox vs UTM

* **VirtualBox (The Standard):**
    * **What is it?** The reference hypervisor developed by Oracle. It is the industry standard for virtualization on x86 architectures (standard PCs).
    * **Supported Platforms:** Windows, Linux, and Intel Mac users.
    * **Why this choice?** It is free, highly stable, and is the default software installed on the school's computers.

* **UTM (For Apple Silicon):**
    * **What is it?** A modern virtualization solution, designed specifically for the Apple ecosystem.
    * **Supported Platforms:** Essential for users with recent Macs.
    * **Key Difference:** Unlike VirtualBox, which struggles with the ARM architecture of newer Macs, UTM effectively emulates x86 architecture on these processors.

# Administration Memento

Here are the essential commands to manage this server.

### 1. User Management
* **Add a user:** `sudo adduser <username>`
* **Delete a user:** `sudo deluser <username>`
* **Check group membership:** `groups <username>`
* **Add user to sudo group:** `sudo usermod -aG sudo <username>`
* **Change password:** `passwd <username>`

### 2. Password Policy & Sudo
* **Check password rules:** `sudo nano /etc/pam.d/common-password`
* **Check password age rules:** `sudo nano /etc/login.defs`
* **Check user password info:** `sudo chage -l <username>`
* **Sudo configuration:** `sudo visudo` (check `secure_path`, `badpass_message`, etc.)

### 3. SSH Service
* **Check status:** `sudo service ssh status`
* **Configuration file:** `sudo nano /etc/ssh/sshd_config`
* **Restart service:** `sudo service ssh restart`

### 4. Firewall (UFW)
* **Check status (with numbers):** `sudo ufw status numbered`
* **Add a rule:** `sudo ufw allow <port>`
* **Delete a rule:** `sudo ufw delete <rule_number>`

### 5. Storage (LVM)
* **List physical volumes:** `sudo pvs`
* **List volume groups:** `sudo vgs`
* **List logical volumes:** `sudo lvs`
* **Display partition details:** `lsblk`

### 6. Monitoring (Cron)
* **Edit crontab:** `sudo crontab -u root -e`
* **Stop script execution:** Comment the line in crontab with `#`.
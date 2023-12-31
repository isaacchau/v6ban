# IPv6 Subnet Blocker

As IPv6 becomes more popular, port scanners are using different IPv6 addresses for each scan attempt. The traditional rate-limiting method for blocking source IP addresses will not work effectively in this scenario. Therefore, I have created this script to block IPv6 subnets based on the UFW log.

# Prerequisites

Before using this script, make sure you have the following installed and enabled:

- UFW log: Ensure that the UFW logging feature is enabled, and the log file is located at /var/log/ufw.log.
- ip6tables: This script utilizes ip6tables to block IPv6 subnets. Make sure it is installed on your system.
- ipset: The script requires ipset to manage IP sets. Ensure that it is installed and configured correctly.

# Usage

To use this script, follow these steps:

Clone this repository to your local machine.
Make the script executable by running the command: chmod +x v6ban.sh.
Set up a cron job to execute the script periodically. For example, you can add the following entry to root user's crontab file (crontab -e):

```
#Run the IPv6 Subnet Blocker script every hour
0 * * * * /path/to/v6ban.sh
```
This will run the script every hour. Adjust the timing according to your requirements.


Please note that this script relies on the UFW log to block IPv6 subnets. Make sure the UFW log file is being populated with the necessary information.

# Disclaimer
This script is provided as-is, without any warranty or guarantee. Use it at your own risk. I am not responsible for any damages or consequences that may arise from using this script.


If you encounter any issues or have suggestions for improvement, feel free to open an issue or submit a pull request on this repository.


Happy blocking!



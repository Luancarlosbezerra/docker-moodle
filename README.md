# docker-moodle
This repository provides a fully containerized Moodle 4.5 environment built on PHP 8.3 and Apache, designed for development, testing, and lightweight production setups. It includes automated cron execution and supports persistent Moodle data with PostgreSQL integration.

Key Features:<p>
	•	Moodle 4.5 cloned directly from the official GitHub repository (MOODLE_405_STABLE branch).<br>
	•	PHP 8.3 with Apache, ready to serve Moodle out-of-the-box.<br>
	•	Cron configured to run Moodle’s scheduled tasks every minute and log output to /var/www/html/moodle_cron.log.<br>
	•	Pre-installed tools: git, unzip, cron, bsd-mailx.<br>
	•	Proper permissions set for Moodle files and PHP configuration directories.<br>
	•	Docker Compose setup for easy deployment, with ports, volumes for persistent data (moodledata), and connection to an external 
	
PostgreSQL network.<p>
	•	Environment variables to quickly configure site name, admin credentials, and database connection.<br>
	•	Exposed port 80 for web access.<br>

Use Cases: <p>
	•	Rapid local Moodle deployment for development or testing.<br>
	•	Sandbox environment for plugin/theme testing.<br>
	•	Lightweight production or demo environments with automated cron tasks.<br>


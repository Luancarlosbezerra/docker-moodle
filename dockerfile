# Base image
FROM moodlehq/moodle-php-apache:8.3

# Moodle version and repo
ENV MOODLE_VERSION=4.5
ENV MOODLE_REPO=https://github.com/moodle/moodle.git
ENV MOODLE_BRANCH=MOODLE_405_STABLE
ENV WWWROOT=/var/www/html

# Switch to root to install dependencies
USER root

# Install git, unzip, cron, mailx
RUN apt-get update && apt-get install -y \
    git unzip cron bsd-mailx \
    && rm -rf /var/lib/apt/lists/*

# Clean wwwroot
RUN rm -rf ${WWWROOT}/*

# Clone Moodle
RUN git clone -b ${MOODLE_BRANCH} --depth 1 ${MOODLE_REPO} ${WWWROOT}

# Set permissions for Moodle files
RUN chown -R www-data:www-data ${WWWROOT} && \
    find ${WWWROOT} -type d -exec chmod 755 {} \; && \
    find ${WWWROOT} -type f -exec chmod 644 {} \;

# Create cron job for Moodle
RUN echo "* * * * * www-data /usr/local/bin/php ${WWWROOT}/admin/cli/cron.php >/var/www/html/moodle_cron.log 2>&1" > /etc/cron.d/moodle_cron && \
    chmod 0644 /etc/cron.d/moodle_cron && \
    crontab -u www-data /etc/cron.d/moodle_cron

# Fix PHP conf.d permissions
RUN mkdir -p /usr/local/etc/php/conf.d && \
    chown -R www-data:www-data /usr/local/etc/php/conf.d

# Create directory for cron PID to avoid permission denied
RUN mkdir -p /var/run/cron && chown www-data:www-data /var/run/cron
ENV CRON_PIDFILE=/var/run/cron/crond.pid

# Expose port
EXPOSE 80

# Start cron and Apache
CMD cron && apache2-foreground

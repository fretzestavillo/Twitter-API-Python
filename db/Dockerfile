# Use an official MySQL image as a parent image
FROM mysql:latest

# Set environment variables
ENV MYSQL_DATABASE=twitter \
    MYSQL_ROOT_PASSWORD=root

# Expose port 3306
EXPOSE 3306

# Copy a custom SQL script to set the root password (if needed)
COPY ./init.sql /docker-entrypoint-initdb.d/

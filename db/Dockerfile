# Use an official MySQL image as a parent image
FROM mysql:latest

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_RANDOM_ROOT_PASSWORD=true

# Copy a custom SQL script to set the root password (if needed)
# COPY ./init.sql /docker-entrypoint-initdb.d/

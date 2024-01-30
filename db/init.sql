-- Create the database
CREATE DATABASE IF NOT EXISTS twitter;

-- Switch to the database
USE twitter;

-- Create a sample table
CREATE TABLE IF NOT EXISTS tweets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    link VARCHAR(255),
    text TEXT,
    date DATETIME,
    No_of_Likes INT,
    No_of_tweets INT
);

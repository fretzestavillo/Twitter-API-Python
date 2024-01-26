# Your existing code (including the necessary imports and script logic)
import pandas as pd
import mysql.connector
from datetime import datetime
from ntscraper import Nitter

# Initialize Nitter scraper
scraper = Nitter()

    # Get tweets from the specified user
tweets = scraper.get_tweets('vicegandako', mode='user', number=5)



final_tweets = []

for tweet in tweets['tweets']:
    # Convert the date string to a MySQL-compatible format
    tweet_date = datetime.strptime(tweet['date'], '%b %d, %Y · %I:%M %p UTC')
    formatted_date = tweet_date.strftime('%Y-%m-%d %H:%M:%S')   


for tweet in tweets['tweets']:
    data = [tweet['link'], tweet['text'], formatted_date, tweet['stats']['likes'], tweet['stats']['comments']]
    final_tweets.append(data)


data = pd.DataFrame(final_tweets, columns=['link', 'text', 'date', 'No_of_Likes', 'No_of_tweets'])
print(data)

# Database connection parameters
host = 'localhost'
user = 'root'
password = '0904'
database = 'twitter'

# Connect to the MySQL database
connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

# Create a cursor
cursor = connection.cursor()

# Insert data into the 'tweets' table (assuming the table already exists)
for index, row in data.iterrows():
    cursor.execute("INSERT INTO tweets (link, text, date, No_of_Likes, No_of_tweets) VALUES (%s, %s, %s, %s, %s)",
    (row['link'], row['text'], row['date'], row['No_of_Likes'], row['No_of_tweets']))

# Commit changes and close the connection
connection.commit()
cursor.close()
connection.close()
print("Data has been successfully inserted into the 'tweets' table.")








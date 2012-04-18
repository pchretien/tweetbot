
import tweepy
import time
import serial
import random

consumer_key=""
consumer_secret=""
access_token=""
access_token_secret=""

ser = serial.Serial('COM7', 19200, timeout=0)

# Initialize the tweepy API
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

api.update_status('Start listening at ' + time.strftime("%Y-%m-%d %H:%M:%S"))
print "Start listening at " + time.strftime("%Y-%m-%d %H:%M:%S")
print

# This is where we should send the command to the robot ...
def process_text(author, text):
	print author
	print text
	print

	if text.lower().find("marois") > -1:
		ser.write(str(random.randint(1,4)))
		
	if text.lower().find("charest") > -1:
		ser.write('2')
		
	if text.lower().find("harper") > -1:
		ser.write('3')
		
	if text.lower().find("khadir") > -1:
		ser.write('4')
		
	if text.lower().find("legault") > -1:
		ser.write('5')
		
	if text.lower().find("python") > -1:
		ser.write('6')
	
	if text.find("#mpr-bye") > -1:
		quit = True
		
		
quit = False
lastStatusProcessed = None
lastMessageProcessed = None

while True:
	
	#print "Reading tweets ... " + time.strftime("%Y-%m-%d %H:%M:%S")	
	for status in tweepy.Cursor(api.friends_timeline, since_id=lastStatusProcessed).items(20):
		
		if lastStatusProcessed is None:
			lastStatusProcessed = status.id
			break
			
		if status.id > lastStatusProcessed:
			lastStatusProcessed = status.id
			
		process_text(status.author, status.text)
		
			
	#print "Reading private messages ... " + time.strftime("%Y-%m-%d %H:%M:%S")
	for msg in tweepy.Cursor(api.direct_messages, since_id=lastMessageProcessed).items(20):
		if lastMessageProcessed is None:
			lastMessageProcessed = msg.id
			break

		if msg.id > lastMessageProcessed:
			lastMessageProcessed = msg.id
			
		process_text(msg.sender.name, msg.text)
				
	if quit:
		break
		
	time.sleep(15)
	
api.update_status('Bye! ' + time.strftime("%Y-%m-%d %H:%M:%S"))
print "Bye!"



import requests
import json
import os
from retry import retry

def doPost(votingappUrl, payload):
    response = requests.post(url = votingappUrl, data = payload)

def doPut(votingappUrl, payload):
    response = requests.put(url = votingappUrl, json = payload)

def doDelete(votingappUrl):
    response = requests.delete(votingappUrl)
    return response.json()

#Try 3 times and with 5 seconds in between each one
@retry(tries=3, delay=5)
def doTests():
    expectedWinner = "dev"
    print("Test cases starting to be executed right now...")

    url = "http://" + os.environ['VOTINGAPP_HOST'] + "/vote"
    
    doPost(url, {'topics': ['dev', 'ops']})
    doPut(url, {'topic': 'dev'})
    

    print("Final JSON response: ")
    json = doDelete(url)
    print(json)

    if json['winner'] == expectedWinner:
        return True


doTests()
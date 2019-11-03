import requests
import json
from retrying import retry

def doPost(votingappUrl, payload):
    response = requests.post(url = votingappUrl, data = payload)

def doPut(votingappUrl, payload):
    response = requests.put(url = votingappUrl, json = payload)

def doDelete(votingappUrl):
    response = requests.delete(votingappUrl)
    return response.json()

@retry(stop_max_attempt_number=3, wait_fixed=5000)
def doRequests():
    url='http://localhost:8080/vote'
    doPost(url, {'topics': ['dev', 'ops']})
    doPut(url, {'topic': 'dev'})
    doDelete(url)


doRequests()

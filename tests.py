import requests
import json

def doPost(votingappUrl, payload):
    response = requests.post(url = votingappUrl, data = payload)

def doPut(votingappUrl, payload):
    response = requests.put(url = votingappUrl, json = payload)

def doDelete(votingappUrl):
    response = requests.delete(votingappUrl)
    return response.json()

url='http://localhost:8080/vote'

doPost(url, {'topics': ['dev', 'ops']})
doPut(url, {'topic': 'dev'})
doDelete(url)

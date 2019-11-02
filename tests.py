# importing the requests library
import requests

def doPost(votingappUrl, payload):
    response=requests.post(url = votingappUrl, data = payload)
    return response.status_code

def doPut(votingappUrl, payload):
    req=requests.put(url = votingappUrl, data = payload)
    return req.status_code

def doDelete(votingappUrl):
    req=requests.delete(votingappUrl)
    return req.json

url='http://localhost:8080/vote'

print(doPost(url, {'topics': ['dev', 'ops']}))
print(doPut(url, {'topic': 'dev'}))

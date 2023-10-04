#get link from file
import re
import json
import os
import subprocess
import requests
from bs4 import BeautifulSoup


import re
# as per recommendation from @freylis, compile once only
CLEANR = re.compile('<.*?>|&([a-z0-9]+|#[0-9]{1,6}|#x[0-9a-f]{1,6});')

def cleanhtml(raw_html):
  cleantext = re.sub(CLEANR, '', raw_html)
  return cleantext



file = open('../README.desktop', 'r')
file = file.readlines()
newFile = []
for i in file:
    newFile.append(i.split(" "))
links = []
for i in newFile:
    for j in i:
        if j.startswith('"https:') == True:
            links.append(j.strip())
readme = links[0].strip('"')
page = requests.get(readme).text
print(cleanhtml(page))


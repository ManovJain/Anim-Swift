from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests

url = "https://www.xfl.com/teams/las-vegas/roster"

page = requests.get(url)

soup = BeautifulSoup(page.content, 'html.parser')

positions = ['QB', 'RB', 'WR', 'TE']

for tag in soup.find_all(['tr']):  # Mention HTML tag names here.
    name = []
    for p in positions :
        if p in tag.text :
            list = tag.text.split(p)
            newlist = [word for line in list for word in line.split()]
            print(f"INSERT INTO PLAYER (first_name, last_name, team_city, team_name, position, total_points, team_id) VALUES ('{newlist[0]}', '{newlist[1]}', 'Vegas', 'Vipers', '{p}', 0, 0)")

    # for p in positions:
    #     if p in list:
    #         print(list)

    


    #  for p in positions:
    #      if p in tag.text.split():
    #         print(f"INSERT INTO PLAYER (first_name, last_name, team_city, team_name, position, total_points, team_id) VALUES ('{tag.text.split()[0]}', '{tag.text.split()[1]}', 'Arlington', 'Renegades', '{tag.text.split()[2]}', 0, 0)")
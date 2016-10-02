'''
Created on Aug 30, 2016

@author: john
'''

import numpy as np
import pandas as pd
import os

os.chdir('../')

users = pd.read_csv('users.txt', header=None)
users.columns = ['id', 'statuses', 'followers', 'friends']
usersmap = pd.read_csv('usersmap.txt', header=None)
usersmap.columns = ['id', 'twitter_id', 'screen_name']
homelocations = pd.read_csv('meanlocations.txt')
links = pd.read_csv('links.txt', header=None)
links.columns = ['source', 'target']

import folium
from folium import plugins

heatmap = folium.Map(location=[-2,-79], zoom_start=3)
hm = plugins.HeatMap(homelocations[['lat', 'lng']].as_matrix())
heatmap.add_children(hm)
heatmap.save('heatmapviz/heatmap.html')
heatmap
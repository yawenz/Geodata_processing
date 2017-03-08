#!/usr/bin/env python

# Get the address from Google using lat&lon
# Yawen Zhang
# March 7th, 2017

import csv
# from geopy.geocoders import GoogleV3
import geocoder
from sys import argv

# read the input file
input_file = argv[1]
# open the input data, start from 1
with open(input_file, 'rb') as f:
	input_data = list(csv.reader(f))
for i in input_data[1:]:
	# geolocator = GoogleV3(api_key = "AIzaSyDSp96cZEIZKWElXp1Fu1OTZ5UD5nKzAP8")
	# g = geolocator.reverse([float(i[2]), float(i[3])], language = 'zh-CN')
	# print g[0]
	g = geocoder.google([float(i[2]), float(i[3])], method = 'reverse', language = 'zh')
	print i[1], g.json['address']

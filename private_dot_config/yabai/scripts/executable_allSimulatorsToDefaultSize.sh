#!/bin/bash

# Wait a moment to ensure Yabai is fully up
sleep 1

# Query for all Simulator windows and resize them
yabai -m query --windows | jq -r '.[] | select(.app=="Simulator") | .id' | while read id; do
	yabai -m window $id --resize left:320:0
done

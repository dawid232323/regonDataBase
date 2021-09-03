#!/bin/bash 
cd "$*" #directory with pkd counties folder 
directories=(*/)
for dir in "${directories[@]}"
do
cd "$dir"
current_dir=$(pwd)
python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/Scrapping/F_api_raports.py "${dir:0:${#dir}-1}_common_F.csv" "$current_dir"
cd ..
done 
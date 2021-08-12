#!/bin/bash
cd "/Users/dawidpylak/Dysk Google/REGON/2_comp_general"
directories=(*/)
for dir in "${directories[@]}"
 do 
 cd "$dir"
 pwd | python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/file_converter.py 
 cd ".."
 done



#!/bin/bash
cd "/Users/dawidpylak/Dysk Google/REGON/2_comp_general"
directories=(*/)
for dir in "${directories[@]}"
 do 
 cd "$dir"
 pwd | python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/file_converter.py
 current_dir=$(pwd)
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py CP "${dir:0:${#dir}-1}_common_P.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py CF "${dir:0:${#dir}-1}_common_F.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py CLF "${dir:0:${#dir}-1}_common_LF.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py CLP "${dir:0:${#dir}-1}_common_LP.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py pkdP "${dir:0:${#dir}-1}_pkd_P.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py pkdLP "${dir:0:${#dir}-1}_pkd_LP.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py pkdF "${dir:0:${#dir}-1}_pkd_F.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py pkdLF "${dir:0:${#dir}-1}_pkd_LF.csv" "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py cdeigF F_ceidg.csv "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py agrF F_agriculture.csv "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py restF F_rest.csv "$current_dir"
 python3 /Users/dawidpylak/Documents/Projekty\ Xcode\ i\ Inne/regonDataBase/insert.py delF F_deleted.csv "$current_dir"
find . -type f -name '*[0-9]_*[a-z]_*[a-z]_*[A-Z].csv' -delete
 cd ".."
 done



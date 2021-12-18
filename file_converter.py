from insert import colors
import pandas as pd
import os, sys

"""

Programme that converts xlsx fles to csv

"""

class converter():
    def __init__(self, directory_path): # class that takes path to the dircetory with files to convert 
        self.file_list = os.listdir(directory_path) # list of the files in direcotry 
        os.chdir(directory_path)
        self.directory_path = directory_path 

    def convert(self): # function that actually converts all xlsx file in direcotry_path to csv
        for file_name in self.file_list:
            if file_name.endswith('.xlsx'):
                print('making ', file_name)
                try:
                    read_file = pd.read_excel(file_name) #pandas data frame from reading excel
                except ValueError:
                    print(f"{colors().FAIL} failed to read {file_name} {colors().ENDC}")
                    continue
                file_name = file_name.replace('.xlsx', '')
                name = self.directory_path + '/' + file_name + '.csv' #creating name for a new csv file 
                read_file.to_csv(name, index=None, header=False, sep=';') #exporting pandas data frame to csv file 


def main():
    directory = input() #script takes directory path from standard input that is handled in insert_trigger.sh script
    converter(directory).convert()

if __name__ == '__main__':
    main()
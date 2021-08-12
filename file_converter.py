import pandas as pd
import os, sys

class converter():
    def __init__(self, directory_path):
        self.file_list = os.listdir(directory_path)
        os.chdir(directory_path)
        print('file list is ', self.file_list)
        self.directory_path = directory_path

    def convert(self):
        for file_name in self.file_list:
            if file_name.endswith('.xlsx'):
                print('making ', file_name)
                try:
                    read_file = pd.read_excel(file_name)
                except ValueError:
                    continue
                file_name = file_name.replace('.xlsx', '')
                name = self.directory_path + '/' + file_name + '.csv'
                print(f'name is {name}')
                read_file.to_csv(name, index=None, header=True)


def main():
    directory = input()
    converter(directory).convert()

if __name__ == '__main__':
    main()
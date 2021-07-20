import psycopg2
import traceback
import csv
import time

class county_item():
    def __init__(self, table_row):
        self.id = table_row[0][0:4]
        self.name = table_row[2]

    def __str__(self):
        return "('" + self.id + "','" + self.name +"')"


class summary_item():
    def __init__(self, table_row):
        self.index = table_row[0]
        self.regon = table_row[1]
        self.type = table_row[2]
        self.name = table_row[3]
        self.state = table_row[4]
        self.county = table_row[5]
        self.municipality = table_row[6]
        self.postal_code = table_row[7]
        self.post = table_row[8]
        self.city = table_row[9]
        self.street = table_row[10]
        self.appartment = table_row[11]
        self.exit_regon = table_row[12]

    def __str__(self):
        return '("' + self.index+'","'+ self.regon + '","' + self.type + '","' + self.name + '","' + self.state + '","' + self.county + '","' + self.municipality + '","' + self.postal_code + '","' + self.post + '","' + self.city + '","' + self.street + '","' + self.appartment + '",' + self.exit_regon + ')'

class file_handler():
    def __init__(self, file_name):
      self.file = file_name
      self.exceptions_file = open('exceptions.txt', 'a')

    def read_rows(self):
        with open(self.file) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter = ';')
            for row in csv_reader:
                yield row
    def write_exceptions(self):
        pass

class data_base_connector():
    def __init__(self, filer):
        try:
            self.conn = psycopg2.connect(host = 'localhost', database = 'p1495_regon_base', user = 'p1495_regon_base', password= 'R!(gR(A2pEyOj(8N5iZN', port = 8543)
            self.cur = self.conn.cursor()
            print('Connected to DataBase')
        except Exception:
            traceback.print_exc()
        self.file_handler = filer
        
    def inserting_summary_data(self):
        for row in self.file_handler.read_rows():
            command = "INSERT INTO summary_data VALUES " + str(summary_item(row))
            print(command)
    
    def inserting_counties(self):
        for row in self.file_handler.read_rows():
            command = "INSERT INTO counties (siedz_powiat_symbol, siedz_powiat_nazwa) VALUES " + str(county_item(row))
            if row[0] != 'id':
                try:
                    self.cur.execute(command)
                    self.conn.commit()
                    print('done')
                    time.sleep(0.5)
                except Exception as ex:
                    print(ex)
                    self.conn.rollback()

def main():
    name = '/Users/dawidpylak/Documents/Projekty Xcode i Inne/Scrapping/county_list.csv'   #input('type file name')
    fHandler = file_handler(name)
    # fHandler.print_rows()
    db = data_base_connector(fHandler)
    db.inserting_counties()
    
    

if __name__ == '__main__':
    main()
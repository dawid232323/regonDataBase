import csv
from os import EX_CANTCREAT
import psycopg2
import insert
import traceback

connection = psycopg2.connect(host = 'localhost', database = 'p1495_regon_base', user = 'p1495_regon_base', password= 'R!(gR(A2pEyOj(8N5iZN', port = 8543)
cursor = connection.cursor()
print('connected')
file = open('tests/commonLP1.csv')
reader = csv.reader(file, delimiter=';')
title = next(reader)
i = 0
while i < 5:
    row = next(reader) 
    i +=1    
row = next(reader)
item = str(insert.local_P(row))
print(item)
item = item.replace("''", 'NULL')
command = "CALL insert_into_common_LP" + item
print(command)
# try:
#     cursor.execute(command)
#     connection.commit()
#     print('inserted')
# except Exception:
#     traceback.print_exc()

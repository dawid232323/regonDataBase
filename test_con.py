import csv
from os import EX_CANTCREAT
import psycopg2
import insert
import traceback
from time import sleep

#wanted error is psycopg2.OperationalError

file = open('test.csv', mode='a')
writer = csv.writer(file, delimiter=';')
row = ['raz', 'dwa', 'trzy']
writer.writerow(row)

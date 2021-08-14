import psycopg2
import traceback
import csv
import time
import sys
from os import chdir
from datetime import date
from abc import ABC, ABCMeta, abstractmethod

class common_item():
    def __init__(self, regon, nip, nip_status, regon_wpis, regon_zmiana, regon_skreslenie, podstawowa_forma_prawna, szczegolna_forma_prawna, forma_finansowania, forma_wlasnosci):
        self.regon = regon
        self.nip = nip
        self.status_nip = nip_status
        self.data_wpisu_do_regon = regon_wpis
        self.data_zaistnienia_zmiany = regon_zmiana
        self.data_skreslenia_z_regon = regon_skreslenie
        self.podstawowa_forma_prawna = podstawowa_forma_prawna
        self.szczegolna_forma_prawna = szczegolna_forma_prawna
        self.forma_finansowania = forma_finansowania
        self.forma_wlasnosci = forma_wlasnosci
        

class common_P_item(common_item): #version for files with index column 
    def __init__(self, table_row):
        super(common_P_item, self).__init__(regon=table_row[0], nip=table_row[1], nip_status=table_row[2], regon_wpis=table_row[8], regon_zmiana=table_row[12], regon_skreslenie=table_row[14], podstawowa_forma_prawna=table_row[40], szczegolna_forma_prawna=table_row[40], forma_finansowania=table_row[41], forma_wlasnosci=table_row[42])
        self.nazwa = table_row[3]
        self.skrocona_nazwa = table_row[4]
        self.numer_w_rejestrze_ewidencji = table_row[5]
        self.data_wpisu_do_rejestru_ewidencji = table_row[6]
        self.data_powstania = table_row[7]
        self.data_rozpoczecia_dzialanosci = table_row[8]
        self.data_zawieszenia_dzialanosci = table_row[10]
        self.data_wznowienia_dzialanosci = table_row[11]
        self.data_zakonczenia_dzialanosci = table_row[13]
        self.data_orzeczenia_upadlosci = table_row[15]
        self.data_zakonczenia_post_upadlosciowego = table_row[16]
        self.kraj_symbol = table_row[17]
        self.woj_symbol = table_row[18]
        self.pow_symbol = self.woj_symbol + table_row[19]
        self.gmin_symbol = table_row[20]
        self.gmin_nazwa = table_row[36]
        self.kod_pocztowy = table_row[21]
        self.miejscowosc_poczty_symbol = table_row[22]
        self.miejscowosc_poczty_nazwa = table_row[38]
        self.miejsc_symbol = table_row[23]
        self.miejsc_nazwa = table_row[37]
        self.ulica_symbol = table_row[24]
        self.ulica_nazwa = table_row[39]
        self.num_nieruchomosci = table_row[25]
        self.num_lokalu = table_row[26]
        self.niet_miejsce_lokalizacji = table_row[27]
        self.numer_telefonu = table_row[28]
        self.num_wew_tel = table_row[29]
        self.num_faksu = table_row[30]
        self.adres_email = table_row[31]
        self.strona_internetowa = table_row[32]
        self.organ_zalozycielski = table_row[44]
        self.organ_rejestrowy = table_row[45]
        self.rodzaj_rejestru_ewidencji = table_row[46]
        self.liczba_jednostek_lokalnych = table_row[54]
        self.forma_wlasnosci_nazwa = table_row[50]
        self.podstawowa_forma_prawna_nazwa = table_row[47]
        self.szczegolna_forma_prawna_nazwa = table_row[48]
        self.forma_finansowania_nazwa = table_row[49]
        self.organ_zalozycielski_nazwa = table_row[51]
        self.organ_rejestrowy_nazwa = table_row[52]
        self.rodzaj_rejestru_ewidencji_nazwa = table_row[53]
    
    def __str__(self):
        return "('"+ self.regon + "','" + self.nip + "','" + self.status_nip + "','" + self.nazwa + "','" + self.skrocona_nazwa + "','" + self.numer_w_rejestrze_ewidencji + "','" + self.data_wpisu_do_rejestru_ewidencji + "','" + self.data_powstania + "','" + self.data_rozpoczecia_dzialanosci + "','" + self.data_wpisu_do_regon + "','" + self.data_zawieszenia_dzialanosci + "','" + self.data_wznowienia_dzialanosci + "','" + self.data_zaistnienia_zmiany + "','" + self.data_zakonczenia_dzialanosci + "','" + self.data_skreslenia_z_regon + "','" + self.data_orzeczenia_upadlosci + "','" + self.data_zakonczenia_post_upadlosciowego + "','" + self.kraj_symbol + "','" + self.woj_symbol + "','" + self.pow_symbol + "','" + self.gmin_symbol + "','" + self.gmin_nazwa + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_poczty_nazwa + "','" + self.miejsc_symbol + "','" + self.miejsc_nazwa + "','" + self.ulica_symbol + "','" + self.ulica_nazwa + "','" + self.num_nieruchomosci + "','" + self.num_lokalu + "','" + self.niet_miejsce_lokalizacji + "','" + self.numer_telefonu + "','" + self.num_wew_tel + "','" + self.num_faksu + "','" + self.strona_internetowa + "','" + self.podstawowa_forma_prawna + "','" + self.podstawowa_forma_prawna_nazwa + "','" + self.szczegolna_forma_prawna + "','" + self.szczegolna_forma_prawna_nazwa + "','" + self.forma_finansowania + "','" + self.forma_finansowania_nazwa + "','" + self.forma_wlasnosci + "','" + self.forma_wlasnosci_nazwa + "','" + self.organ_zalozycielski + "','" + self.organ_zalozycielski_nazwa + "','" + self.organ_rejestrowy + "','" + self.organ_rejestrowy_nazwa + "','" + self.rodzaj_rejestru_ewidencji + "','" + self.rodzaj_rejestru_ewidencji_nazwa + "'," + self.liczba_jednostek_lokalnych + ",'" + str(date.today()) + "')"

class common_F(common_item):
    def __init__(self, table_row):
        super().__init__(regon=table_row[0], nip=table_row[1], nip_status=table_row[2], regon_wpis=table_row[6], regon_zmiana=table_row[7], regon_skreslenie=table_row[8], podstawowa_forma_prawna=table_row[9], szczegolna_forma_prawna=table_row[10], forma_finansowania=table_row[11], forma_wlasnosci=table_row[12])
        self.nazwisko = table_row[3]
        self.imie1 = table_row[4]
        self.imie2 = table_row[5]
        self.dzialalnosc_CEIDG = table_row[17]
        self.dzialalnosc_rolnicza = table_row[18]
        self.dzialalnosc_pozostala = table_row[19]
        self.dzialalnosc_skreslona_do_20141108 = table_row[20]
        self.liczba_jednostek_lokalnych = table_row[21]
        self.podstawowa_forma_prawna_nazwa = table_row[13]
        self.szczegolna_forma_prawna_nazwa = table_row[14]
        self.forma_finansowania_nazwa = table_row[15]
        self.forma_wlasnosci_nazwa = table_row[16]

    def __str__(self) -> str:
        if self.dzialalnosc_rolnicza == '1':
            self.dzialalnosc_rolnicza = '2'
        if self.dzialalnosc_skreslona_do_20141108 == '1':
            self.dzialalnosc_skreslona_do_20141108 = '4'
        if self.dzialalnosc_pozostala == '1':
            self.dzialalnosc_pozostala = '3'
        return "('" + self.regon + "','" + self.nip + "','" + self.status_nip + "','" + self.nazwisko + "','" + self.imie1 + "','" + self.imie2 + "','" + self.data_wpisu_do_regon + "','" + self.data_zaistnienia_zmiany + "','" + self.data_skreslenia_z_regon + "','" + self.podstawowa_forma_prawna + "','" + self.podstawowa_forma_prawna_nazwa + "','" + self.szczegolna_forma_prawna + "','" + self.szczegolna_forma_prawna_nazwa + "','" + self.forma_finansowania + "','" + self.forma_finansowania_nazwa + "','" + self.forma_wlasnosci + "','" + self.forma_wlasnosci_nazwa +  "'," + self.dzialalnosc_CEIDG + "," + self.dzialalnosc_rolnicza + "," + self.dzialalnosc_pozostala + "," + self.dzialalnosc_skreslona_do_20141108 + "," + self.liczba_jednostek_lokalnych + ",'" + str(date.today()) + "')"

class F_specified_item():
    def __init__(self, table_row) -> None:
        self.regon = table_row[0]
        self.nazwa = table_row[1]
        self.nazwa_skrocona = table_row[2]
        self.powstanie = table_row[3]
        self.rozpoczecie_dzialalnosci = table_row[4]
        self.regon_wpis = table_row[5]
        self.zawieszenie = table_row[6]
        self.wznowienie = table_row[7]
        self.zatstnienie_zmiany = table_row[8]
        self.zakonczenie_dzialalnosci = table_row[9]
        self.skreslenie_regon = table_row[10]
        self.orzeczenie_upadlosci = table_row[11]
        self.zakonczenie_postepowania_upadlosciowego = table_row[12]
        self.kraj_symbol = table_row[13]
        self.kraj_nazwa = table_row[29]
        self.wojewodztwo_symbol = table_row[14]
        self.wojewodztwo_nazwa = table_row[30]
        self.powiat_symbol = self.wojewodztwo_symbol + table_row[15]
        self.powiat_nazwa = table_row[31]
        self.gmina_symbol = table_row[16]
        self.gmina_nazwa = table_row[32]
        self.kod_pocztowy = table_row[17]
        self.miejscowosc_poczty_symbol = table_row[18]
        self.miejscowosc_poczty_nazwa = table_row[34]
        self.miejscowosc_symbol = table_row[19]
        self.miejscowosc_nazwa = table_row[33]
        self.ulica_symbol = table_row[20]
        self.numer_nieruchomosci = table_row[21]
        self.numer_lokalu = table_row[22]
        self.nietypowe_miejsce_lokalizacji = table_row[23]
        self.numer_telefonu = table_row[24]
        self.numer_wewnetrzny_telefonu = table_row[25]
        self.numer_faksu = table_row[26]
        self.adres_email = table_row[27]
        self.adres_strony_internetowej = table_row[28]
        
class F_ceidg(F_specified_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.wpis_rejestr_ewidencji = table_row[36]
        self.skreslenie_rejestr_ewidencji = table_row[37]
        self.numer_rejestr_ewidencji = table_row[38]
        self.organ_rejestrowy_symbol = table_row[39]
        self.organ_rejestrowy_nazwa = table_row[40]
        self.rodzaj_rejestru_symbol = table_row[41]
        self.rodzaj_rejestru_nazwa = table_row[42]
        self.nie_podjeto_dzialalnosci = table_row[43]
        self.ulica_nazwa = table_row[35]

    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "','" + self.nazwa_skrocona + "','" + self.powstanie + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie + "','" + self.wznowienie + "','" + self.zatstnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.orzeczenie_upadlosci + "','" + self.zakonczenie_postepowania_upadlosciowego + "','" + self.kraj_symbol + "','" +self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_symbol + "','" + self.ulica_symbol + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.numer_telefonu + "','" + self.numer_wewnetrzny_telefonu + "','" + self.numer_faksu + "','" + self.adres_strony_internetowej + "','" + self.wpis_rejestr_ewidencji + "','" + self.skreslenie_rejestr_ewidencji + "','" + self.numer_rejestr_ewidencji + "','" + self.organ_rejestrowy_symbol + "','" + self.rodzaj_rejestru_symbol + "','" + self.nie_podjeto_dzialalnosci + "','" + self.miejscowosc_nazwa + "','" + self.gmina_nazwa + "','" + self.miejscowosc_poczty_nazwa + "','" + self.ulica_nazwa + "','" + self.organ_rejestrowy_nazwa + "','" + self.rodzaj_rejestru_nazwa + "')"

class F_agriculture(F_specified_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.ulica_nazwa = table_row[35]

    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "','" + self.nazwa_skrocona + "','" + self.powstanie + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie + "','" + self.wznowienie + "','" + self.zatstnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.orzeczenie_upadlosci + "','" + self.zakonczenie_postepowania_upadlosciowego + "','" + self.kraj_symbol + "','" +self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_symbol + "','" + self.ulica_symbol + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.numer_telefonu + "','" + self.numer_wewnetrzny_telefonu + "','" + "','" + self.numer_faksu + "','" + self.adres_strony_internetowej + "','" + self.gmina_nazwa + "','" + self.miejscowosc_nazwa + "','" + self.miejscowosc_poczty_nazwa + "','" + self.ulica_nazwa + "')"

class F_rest(F_specified_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.skreslenie_rejestr_ewidencji = 'NULL'
        self.nie_podjeto_dzialalnosci = 'NULL'
        self.wpis_rejestr_ewidencji = table_row[36]
        self.numer_rejestr_ewidencji = table_row[37]
        self.organ_rejestrowy_symbol = table_row[38]
        self.organ_rejestrowy_nazwa = table_row[39]
        self.rodzaj_rejestru_symbol = table_row[40]
        self.rodzaj_rejestru_nazwa = table_row[41]
        self.ulica_nazwa = table_row[35]
        

    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "','" + self.nazwa_skrocona + "','" + self.powstanie + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie + "','" + self.wznowienie + "','" + self.zatstnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.orzeczenie_upadlosci + "','" + self.zakonczenie_postepowania_upadlosciowego + "','" + self.kraj_symbol + "','" +self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_symbol + "','" + self.ulica_symbol + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.numer_telefonu + "','" + self.numer_wewnetrzny_telefonu + "','" + self.numer_faksu + "','" + self.adres_strony_internetowej + "','" + self.wpis_rejestr_ewidencji + "'," + self.skreslenie_rejestr_ewidencji + ",'" + self.numer_rejestr_ewidencji + "','" + self.organ_rejestrowy_symbol + "','" + self.rodzaj_rejestru_symbol + "'," + self.nie_podjeto_dzialalnosci + ",'" + self.miejscowosc_nazwa + "','" + self.gmina_nazwa + "','" + self.miejscowosc_poczty_nazwa + "','" + self.ulica_nazwa + "','" + self.organ_rejestrowy_nazwa + "','" + self.rodzaj_rejestru_nazwa + "')"


class F_deleted(F_specified_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row) #chuj
        self.kraj_symbol = table_row[11]
        self.wojewodztwo_symbol = table_row[12]
        self.powiat_symbol = self.wojewodztwo_symbol + table_row[13]
        self.gmina_symbol = table_row[14]
        self.kod_pocztowy = table_row[15]
        self.miejscowosc_poczty_symbol = table_row[16]
        self.miejscowosc_symbol = table_row[17]
        self.ulica_symbol = table_row[18]
        self.numer_nieruchomosci = table_row[19]
        self.numer_lokalu = table_row[20]
        self.nietypowe_miejsce_lokalizacji = table_row[21]
        self.numer_telefonu = table_row[22]
        self.numer_wewnetrzny_telefonu = table_row[23]
        self.numer_faksu = table_row[24]
        self.adres_email = table_row[25]
        self.adres_strony_internetowej = table_row[26]
        self.adres_email_2 = table_row[27]
        self.kraj_nazwa = table_row[28]
        self.wojewodztwo_nazwa = table_row[29]
        self.powiat_nazwa = table_row[30]
        self.gmina_nazwa = table_row[31]
        self.miejscowosc_nazwa = table_row[32]
        self.miejscowosc_poczty_nazwa = table_row[33]
        self.ulica_nazwa = table_row[34]
    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "','" + self.nazwa_skrocona + "','" + self.powstanie + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie + "','" + self.wznowienie + "','" + self.zatstnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.kraj_symbol + "','" + self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.gmina_nazwa + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_poczty_nazwa + "','" + self.miejscowosc_symbol + "','" + self.miejscowosc_nazwa + "','" + self.ulica_symbol + "','" + self.ulica_nazwa + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.numer_telefonu + "','" + self.numer_wewnetrzny_telefonu + "','" + self.numer_faksu + "','" + self.adres_email + "','" + self.adres_strony_internetowej + "','" + self.adres_email_2 +  "')"

class local_unit():
    def __init__(self, table_row) -> None:
        self.regon = table_row[0]
        self.nazwa = table_row[1]
        self.data_powstania = table_row[4]
        self.rozpoczecie_dzialalnosci = table_row[5]
        self.regon_wpis = table_row[6]
        self.zawieszenie_dzialalnosci = table_row[7]
        self.wznowienie_dzialalnosci = table_row[8]
        self.zaistnienie_zmiany = table_row[9]
        self.zakonczenie_dzialalnosci = table_row[10]
        self.skreslenie_regon = table_row[11]
        self.kraj_symbol = table_row[12]
        self.wojewodztwo_symbol = table_row[13]
        self.powiat_symbol = self.wojewodztwo_symbol + table_row[14]
        self.gmina_symbol = table_row[15]
        self.kod_pocztowy = table_row[16]
        self.miejscowosc_poczty_symbol = table_row[17]
        self.miejscowosc_symbol = table_row[18]
        self.ulica_symbol = table_row[19]
        self.numer_nieruchomosci = table_row[20]
        self.numer_lokalu = table_row[21]
        self.nietypowe_miejsce_lokalizacji = table_row[22]
        self.kraj_nazwa = table_row[23]
        self.wojewodztwo_nazwa = table_row[24]
        self.powiat_nazwa = table_row[25]
        self.gmina_nazwa = table_row[26]
        self.miejscowosc_nazwa = table_row[27]
        self.miejscowosc_poczty_nazwa = table_row[28]
        self.ulica_nazwa = table_row[29]
        
class local_F(local_unit):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.silosID = table_row[2]
        self.silos_nazwa = table_row[3]
        self.forma_finansowania_nazwa = table_row[30]
        self.forma_finansowania_symbol = table_row[31]
        self.wpis_do_rejestru_ewidencji = table_row[32]
        self.numer_rejestr_ewidencji = table_row[33]
        self.organ_rejestrowy_symbol = table_row[34]
        self.organ_rejestrowy_nazwa = table_row[36]
        self.rodzaj_rejestru_symbol = table_row[35]
        self.rodzaj_rejestru_nazwa = table_row[37]
        self.nie_podjeto_dzialalnosci = table_row[38]

    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "'," + self.silosID + ",'" + self.silos_nazwa + "','" + self.data_powstania + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie_dzialalnosci + "','" + self.wznowienie_dzialalnosci + "','" + self.zaistnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.kraj_symbol + "','" + self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.gmina_nazwa + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_poczty_nazwa + "','" + self.miejscowosc_symbol + "','" + self.miejscowosc_nazwa + "','" + self.ulica_symbol + "','" + self.ulica_nazwa + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.forma_finansowania_symbol + "','" + self.forma_finansowania_nazwa + "','" + self.wpis_do_rejestru_ewidencji + "','" + self.numer_rejestr_ewidencji + "','" + self.organ_rejestrowy_symbol + "','" + self.organ_rejestrowy_nazwa + "','" + self.rodzaj_rejestru_symbol + "','" + self.rodzaj_rejestru_nazwa + "','" + self.nie_podjeto_dzialalnosci + "','" + str(date.today()) + "')"
    

class local_P(local_unit):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.numer_w_rejestrze_ewidencji = table_row[2]
        self.data_wpisu_rejestr_ewidencji = table_row[3]
        self.forma_finansowania_symbol = table_row[30]
        self.organ_rejestrowy_symbol = table_row[31]
        self.rodzaj_rejestru_ewidencji_symbol = table_row[32]
        self.forma_finansowania_nazwa = table_row[33]
        self.organ_rejestrowy_nazwa = table_row[34]
        self.rodzaj_rejestru_ewidencji_nazwa = table_row[35]

    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.nazwa + "','" + self.numer_w_rejestrze_ewidencji + "','" + self.data_wpisu_rejestr_ewidencji + "','" + self.data_powstania + "','" + self.rozpoczecie_dzialalnosci + "','" + self.regon_wpis + "','" + self.zawieszenie_dzialalnosci + "','" + self.wznowienie_dzialalnosci + "','" + self.zaistnienie_zmiany + "','" + self.zakonczenie_dzialalnosci + "','" + self.skreslenie_regon + "','" + self.kraj_symbol + "','" + self.wojewodztwo_symbol + "','" + self.powiat_symbol + "','" + self.gmina_symbol + "','" + self.gmina_nazwa + "','" + self.kod_pocztowy + "','" + self.miejscowosc_poczty_symbol + "','" + self.miejscowosc_poczty_nazwa + "','" + self.miejscowosc_symbol + "','" + self.miejscowosc_nazwa + "','" + self.ulica_symbol + "','" + self.ulica_nazwa + "','" + self.numer_nieruchomosci + "','" + self.numer_lokalu + "','" + self.nietypowe_miejsce_lokalizacji + "','" + self.forma_finansowania_symbol + "','" + self.forma_finansowania_nazwa + "','" + self.organ_rejestrowy_symbol + "','" + self.organ_rejestrowy_nazwa + "','" + self.rodzaj_rejestru_ewidencji_symbol + "','" + self.rodzaj_rejestru_ewidencji_nazwa + "','" + str(date.today()) + "')"

class two_column_item():
    def __init__(self, table_row):
        self.primary_key = table_row[0]
        self.name = table_row[1]

    def __str__(self):
        return "('" + self.primary_key + "','" + self.name + "')"

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

class pkd_item(metaclass=ABCMeta):
    @abstractmethod
    def __init__(self, table_row) -> None:
        self.regon = table_row[0]
        self.pkd_kod = table_row[1]
        self.pkd_nazwa = table_row[2]
        self.pkd_przewazajace = table_row[3]
        if self.pkd_przewazajace == '':
            self.pkd_przewazajace = '0'
    
    @abstractmethod
    def __str__(self) -> str:
        return "('" + self.regon + "','" + self.pkd_kod + "','" + self.pkd_nazwa + "'," + self.pkd_przewazajace

class pkd_F_item(pkd_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.silos_id = table_row[4]
        self.silos_symbol = table_row[5]
        self.data_skreslenia = table_row[6]

    def __str__(self) -> str:
        return super().__str__() + "," + self.silos_id + ",'" + self.silos_symbol + "','" + self.data_skreslenia + "')"

class pkd_LF_item(pkd_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)
        self.silos_Nazwa = table_row[4]

    def __str__(self) -> str:
        return super().__str__() + ",'" + self.silos_Nazwa + "')"

class pkd_LP_item(pkd_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)

    def __str__(self) -> str:
        return super().__str__() + ")"

class pkd_P_item(pkd_item):
    def __init__(self, table_row) -> None:
        super().__init__(table_row)

    def __str__(self) -> str:
        return super().__str__() + ")"

class file_handler():
    def __init__(self, file_name):
      self.file = file_name
      self.exceptions_file = open('exceptions.csv', 'a')
      self.writer = csv.writer(self.exceptions_file, delimiter = ';')
      self.writer.writerow(['Regon', 'Type of raport'])

    def read_rows(self):
        with open(self.file) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter = ';')
            for row in csv_reader:
                yield row
    def write_exceptions(self, mode, regon): #function that will save all records that failed to insert
        self.writer.writerow(regon, mode)

class data_base_connector():
    def __init__(self):
        try:
            self.conn = psycopg2.connect(host = 'localhost', database = 'p1495_regon_base', user = 'p1495_regon_base', password= 'R!(gR(A2pEyOj(8N5iZN', port = 8543)
            self.cur = self.conn.cursor()
            print('Connected to DataBase')
        except Exception:
            traceback.print_exc()
        
    def get_conn_details(self):
        return self.conn, self.cur

class data_inserter():
    def __init__(self, mode, file_name):
        self.connection, self.cursor = data_base_connector().get_conn_details()
        self.mode = mode
        self.data_types = {'CP':'insert_into_common_P', 'CF':'insert_into_common_F', 'CLP':'insert_into_common_LP', 
        'CLF':'insert_into_common_LF', 'cdeigF':'insert_Ceidg', 'agrF':'insert_rolnicza', 'restF':'insert_Pozostale',
        'delF':'insert_Skreslone', 'pkdP':'insert_into_pkd_P_ownership', 'pkdF':'insert_into_pkd_F_ownership', 'pkdLP': 'insert_into_pkd_LP_ownership', 'pkdLF': 'insert_into_pkd_LF_ownership'}
        self.file_handler = file_handler(file_name)

    def row_creator(self, table_row) -> str:
        if self.mode == 'CP':
            return str(common_P_item(table_row)).replace("''", 'NULL')
        elif self.mode == 'CF':
            return str(common_F(table_row)).replace("''", 'NULL')
        elif self.mode == 'CLF':
            return str(local_F(table_row)).replace("''", 'NULL')
        elif self.mode == 'CLP':
            return str(local_P(table_row)).replace("''", 'NULL')
        elif self.mode == 'cdeigF':
            return str(F_ceidg(table_row)).replace("''", 'NULL')
        elif self.mode == 'agrF':
            return str(F_agriculture(table_row)).replace("''", 'NULL')
        elif self.mode == 'restF':
            return str(F_rest(table_row)).replace("''", 'NULL')
        elif self.mode == 'delF':
            return str(F_deleted(table_row)).replace("''", 'NULL')
        elif self.mode == 'pkdP':
            return str(pkd_P_item(table_row)).replace("''", 'NULL')
        elif self.mode == 'pkdF':
            return str(pkd_F_item(table_row)).replace("''", 'NULL')
        elif self.mode == 'pkdLP':
            return str(pkd_LP_item(table_row)).replace("''", 'NULL')
        elif self.mode == 'pkdLF':
            return str(pkd_LF_item(table_row)).replace("''", 'NULL')

    def data_looper(self):
        title = next(self.file_handler.read_rows())
        for table_row in self.file_handler.read_rows():
            row = self.row_creator(table_row)
            command = 'CALL ' + self.data_types[self.mode] + row
            print(command)
            try:
                self.cursor.execute(command)
                self.connection.commit()
            except Exception:
                # self.file_handler.write_exceptions(self.mode, table_row[0])
                traceback.print_exc()
                self.connection.rollback()


def main():
    file_name = sys.argv[2]
    mode = sys.argv[1]
    print(f'mode is {mode}, file_name is {file_name}')
    chdir(sys.argv[3])
    db = data_inserter(mode, file_name)
    db.data_looper()
    

if __name__ == '__main__':
    main()
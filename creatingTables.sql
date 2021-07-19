CREATE TABLE states(
    siedz_wojewodztwa_symbol varchar(10) PRIMARY KEY,
    siedz_wojewodztwa_nazwa varchar(100)
);
CREATE TABLE countries(
    siedz_kraj_symbol varchar(10) PRIMARY KEY,
    siedz_kraj_nazwa varchar(100)
);
CREATE TABLE counties(
    siedz_powiat_symbol varchar(10) PRIMARY KEY,
    siedz_powiat_nazwa varchar(100)
);
CREATE TABLE municipalities(
    siedz_gmina_symbol varchar(10) PRIMARY KEY,
    siedz_gmina_nazwa varchar(100)
);
CREATE TABLE posts(
    siedz_miejscowosc_poczty_symbol varchar(10) PRIMARY KEY,
    siedz_miejscowosc_poczty_nazwa varchar(100)
);
CREATE TABLE towns(
    siedz_miejscowosc_symbol varchar(10) PRIMARY KEY,
    siedz_miejscowosc_nazwa varchar(100)
);
CREATE TABLE streets(
    siedz_ulica_symbol varchar(10) PRIMARY KEY,
    siedz_ulica_nazwa varchar(100)
);
CREATE TABLE basic_legal_form(
    podstawowa_forma_prawna_symbol varchar(10) PRIMARY KEY,
    podstawowa_forma_prawna_nazwa varchar(100)
);
CREATE TABLE specific_legal_form(
    szczegolna_forma_prawna_symbol varchar(10) PRIMARY KEY,
    szeczgolna_forma_prawna_nazwa varchar(100)
);
CREATE TABLE forms_of_financing(
    forma_finansowania_symbol varchar(10) PRIMARY KEY,
    forma_finansowania_nazwa varchar(100)
);
CREATE TABLE forms_of_ownership(
    forma_wlasnosci_symbol varchar(10) PRIMARY KEY,
    forma_wlasnosci_nazwa varchar(100)
);
CREATE TABLE founding_bodies(
    ogran_zalozycielski_symbol varchar(10) PRIMARY KEY,
    organ_zalozycielski_nazwa varchar(100)
);
CREATE TABLE type_of_register_of_records(
    rodzaj_rejestru_ewidencji_symbol varchar(10) PRIMARY KEY,
    rodzaj_rejestru_ewidencji_nazwa varchar(100)
);
CREATE TABLE registration_authorities(
    organ_rejestrowy_symbol varchar(10) PRIMARY KEY,
    organ_rejestrowy_nazwa varchar(100)
);

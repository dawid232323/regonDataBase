CREATE TABLE states(
    siedz_wojewodztwa_symbol varchar(10) PRIMARY KEY,
    siedz_wojewodztwa_nazwa varchar(100)
); --created
CREATE TABLE countries(
    siedz_kraj_symbol varchar(10) PRIMARY KEY,
    siedz_kraj_nazwa varchar(100)
); --created
DROP TABLE counties;
CREATE TABLE counties(
    siedz_powiat_symbol varchar(10) PRIMARY KEY,
    siedz_powiat_nazwa varchar(256)
); -- created
CREATE TABLE municipalities(
    siedz_gmina_symbol varchar(10) PRIMARY KEY,
    siedz_gmina_nazwa varchar(100)
); -- created
CREATE TABLE posts(
    siedz_miejscowosc_poczty_symbol varchar(10) PRIMARY KEY,
    siedz_miejscowosc_poczty_nazwa varchar(100)
); -- created
CREATE TABLE towns(
    siedz_miejscowosc_symbol varchar(10) PRIMARY KEY,
    siedz_miejscowosc_nazwa varchar(100)
); -- created
CREATE TABLE streets(
    siedz_ulica_symbol varchar(10) PRIMARY KEY,
    siedz_ulica_nazwa varchar(100)
); -- created
CREATE TABLE basic_legal_form(
    podstawowa_forma_prawna_symbol varchar(10) PRIMARY KEY,
    podstawowa_forma_prawna_nazwa varchar(256)
); -- created
CREATE TABLE specific_legal_form(
    szczegolna_forma_prawna_symbol varchar(10) PRIMARY KEY,
    szeczgolna_forma_prawna_nazwa varchar(256)
); -- created
CREATE TABLE forms_of_financing(
    forma_finansowania_symbol varchar(10) PRIMARY KEY,
    forma_finansowania_nazwa varchar(256)
); -- created
CREATE TABLE forms_of_ownership(
    forma_wlasnosci_symbol varchar(10) PRIMARY KEY,
    forma_wlasnosci_nazwa varchar(256)
); -- created
CREATE TABLE founding_bodies(
    ogran_zalozycielski_symbol varchar(10) PRIMARY KEY,
    organ_zalozycielski_nazwa varchar(256)
); -- created
CREATE TABLE type_of_register_of_records(
    rodzaj_rejestru_ewidencji_symbol varchar(10) PRIMARY KEY,
    rodzaj_rejestru_ewidencji_nazwa varchar(256)
); -- created
CREATE TABLE registration_authorities(
    organ_rejestrowy_symbol varchar(10) PRIMARY KEY,
    organ_rejestrowy_nazwa varchar(256)
); -- created
CREATE TABLE common_P(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    praw_regon varchar(14) NOT NULL CHECK ( length(praw_regon) > 8 ),
    praw_nip varchar(10),
    praw_statusNip varchar(10),
    praw_nazwa varchar(256),
    praw_nazwaSkrocona varchar(100),
    praw_numerWRejestrzeEwidencji varchar(15),
    praw_dataWpisuDoRejestruEwidencji DATE,
    praw_dataPowstamia DATE,
    praw_dataRozpoczeciaDzialanosci DATE,
    praw_dataWpisuDoRegon DATE,
    praw_dataZawieszeniaDzialanosci DATE,
    praw_dataWznowieniaDzialanosci DATE,
    praw_dataZaistnieniaZmiany DATE,
    praw_dataZakonczeniaDzialanosci DATE,
    praw_dataSkresleniaZRegon DATE,
    praw_dataOrzeczeniaOUpadlosci DATE,
    praw_dataZakonczeniaPostepowaniaUpadlosciowego DATE,
    praw_siedzibaKraj_Symbol varchar(10),
    CONSTRAINT fk_siedzibaKraj_Symbol FOREIGN KEY(praw_siedzibaKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    praw_siedzWojewodztwo_Symbol varchar(10),
    CONSTRAINT fk_siedzibaWojewodztwo_symbol FOREIGN KEY(praw_siedzWojewodztwo_Symbol) REFERENCES states(siedz_wojewodztwa_symbol),
    praw_siedzPowiat_Symbol varchar(10),
    CONSTRAINT fk_siedzPowiat_Symbol FOREIGN KEY (praw_siedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    praw_siedzGminaSymbol varchar(10),
    CONSTRAINT fk_praw_siedzGminaSymbol FOREIGN KEY (praw_siedzGminaSymbol) REFERENCES municipalities(siedz_gmina_symbol),
    praw_siedzKodPocztowy varchar(7),
    praw_siedzMiejscowoscPoczty_Symbol varchar(10),
    praw_siedzMiejscowosc_Symbol varchar(10),
    praw_siedzUlicaSymbol varchar(10),
    CONSTRAINT fk_siedzMiejscowoscPoczty_Symbol FOREIGN KEY (praw_siedzMiejscowoscPoczty_Symbol) REFERENCES posts(siedz_miejscowosc_poczty_symbol),
    CONSTRAINT fk_siedzMiejscowosc_Symbol FOREIGN KEY (praw_siedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_siedzUlica_Symbol FOREIGN KEY (praw_siedzUlicaSymbol) REFERENCES streets(siedz_ulica_symbol),
    praw_siedzNumerNieruchomosci varchar(15),
    praw_siedzNumerLokalu varchar(15),
    praw_siedzNietypoweMiejsceLokalizacji varchar(100),
    praw_numerTelefonu varchar(13),
    praw_numerWewnetrznyTelefoonu varchar(15),
    praw_numerFaksu varchar(20),
    praw_adresStronyInternetowej varchar(100),
    praw_podstawowaFormaPrawna_Symbol varchar(10),
    praw_szczegolnaFormaPrawna_Symbol varchar(10),
    praw_formaFinansowania_Symbol varchar(10),
    praw_formaWlasnosci_Symbol varchar(10),
    praw_organZalozycielski varchar(10),
    praw_organRejestrowy_Symbol varchar(10),
    praw_rodzajRejestruEwidencji_SYmbol varchar(10),
    praw_liczbaJednostekLokalnych INT,
    praw_dataWpisuDoBazyDanych DATE,
    CONSTRAINT fk_podstawowaFormaPrawna_Symbol FOREIGN KEY (praw_podstawowaFormaPrawna_Symbol) REFERENCES basic_legal_form(podstawowa_forma_prawna_symbol),
    CONSTRAINT fk_szczegolnaFormaPrawna_Symbol FOREIGN KEY (praw_szczegolnaFormaPrawna_Symbol) REFERENCES specific_legal_form(szczegolna_forma_prawna_symbol),
    CONSTRAINT fk_formaFinansowania_Symbol FOREIGN KEY (praw_formaFinansowania_Symbol) REFERENCES forms_of_financing(forma_finansowania_symbol),
    CONSTRAINT fk_formaWlasnosci_Symbol FOREIGN KEY (praw_formaWlasnosci_Symbol) REFERENCES forms_of_ownership(forma_wlasnosci_symbol),
    CONSTRAINT fk_organZalozycielski_Symbol FOREIGN KEY (praw_organZalozycielski) REFERENCES founding_bodies(ogran_zalozycielski_symbol),
    CONSTRAINT fk_organRejestrowy_Symbol FOREIGN KEY (praw_organRejestrowy_Symbol) REFERENCES registration_authorities(organ_rejestrowy_symbol),
    CONSTRAINT fk_rodzajRejestruEwidencji_Symbol FOREIGN KEY (praw_rodzajRejestruEwidencji_SYmbol) REFERENCES type_of_register_of_records(rodzaj_rejestru_ewidencji_symbol)
    --CONSTRAINT fk_regon FOREIGN KEY (praw_regon) REFERENCES summary_data(regon)
); --created


CREATE TABLE common_F(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fiz_regon varchar(9) NOT NULL CHECK ( length(fiz_regon) > 8 ),
    fiz_NIP varchar(10),
    fiz_statusNIP varchar(10),
    fiz_Nazwisko varchar(100),
    fiz_imie1 varchar(100),
    fiz_imie2 varchar(100),
    fiz_dataWpisuPodmiotuDoRegon DATE,
    fiz_dataZaistnieniaZmiany DATE,
    fiz_dataSkresleniaPodmiotuZRegon DATE,
    fiz_podstawowaFormaPrawna_Symbol varchar(10),
    fiz_szczegolnaFormaPrawna_Symbol varchar(10),
    fiz_formaFinansowania_Symbol varchar(10),
    fiz_formaWlasnosci_Symbol varchar(10),
    fiz_dzialanoscCeidg INT,
    fiz_dzialnoscRolnicza INT,
    fiz_dzialanoscPozostala INT,
    fiz_dzialanoscSkreslonaDo20141108 INT,
    fiz_liczbaJednLokalnych INT,
    fiz_dataWpisuDoBazyDanych DATE,
    CONSTRAINT fk_podstawowaFormaPrawna_Symbol FOREIGN KEY (fiz_podstawowaFormaPrawna_Symbol) REFERENCES basic_legal_form(podstawowa_forma_prawna_symbol),
    CONSTRAINT fk_szczegolnaFormaPrawnaSymbol FOREIGN KEY (fiz_szczegolnaFormaPrawna_Symbol) REFERENCES specific_legal_form(szczegolna_forma_prawna_symbol),
    CONSTRAINT fk_formaFinansowania_Symbol FOREIGN KEY (fiz_formaFinansowania_Symbol) REFERENCES forms_of_financing(forma_finansowania_symbol),
    CONSTRAINT fk_formaWlasnosci_Symbol FOREIGN KEY (fiz_formaWlasnosci_Symbol) REFERENCES forms_of_ownership(forma_wlasnosci_symbol),
    CONSTRAINT fk_dzialalnoscCeidg FOREIGN KEY (fiz_dzialanoscCeidg) REFERENCES silos(silosID),
    CONSTRAINT fk_dzialalnoscRolnicza FOREIGN KEY (fiz_dzialnoscRolnicza) REFERENCES silos(silosID),
    CONSTRAINT fk_dzialalnoscPozostala FOREIGN KEY (fiz_dzialanoscPozostala) REFERENCES silos(silosID),
    CONSTRAINT fk_dzialalnoscSkreslona Foreign Key (fiz_dzialanoscSkreslonaDo20141108) REFERENCES silos(silosID)
    --CONSTRAINT fk_regon FOREIGN KEY (fiz_regon) REFERENCES summary_data(regon)
); --created

ALTER TABLE common_F ALTER COLUMN fiz_regon TYPE varchar(9);

CREATE TABLE register_types(
    rodzajRejestru_Symbol varchar(10) PRIMARY KEY,
    rodzajRejestru_Nazwa varchar(256)
); -- created
ALTER TABLE summary_data ADD CONSTRAINT regon_len CHECK ( length(regon) > 8 );

CREATE TABLE silos(
    silosID INT PRIMARY KEY,
    silos_Nazwa varchar(256)
); -- created
DROP TABLE common_lf;
CREATE TABLE common_LF(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lokfiz_regon varchar(14) NOT NULL CHECK ( length(lokfiz_regon) > 8 ),
    lokfiz_parentRegon varchar(9),
    lokfiz_nazwa varchar(256),
    lokfiz_silosID INT,
    lokfiz_dataPowstania DATE,
    lokfiz_dataRozpoczeciaDzialalnosci DATE,
    lokfiz_dataWpisuDoRegon DATE,
    lokfiz_dataZawieszeniaDzialanosci DATE,
    lokfiz_dataWznowieniaDzialanosci DATE,
    lokfiz_dataZaistnieniaZmiany DATE,
    lokfizdataZakonczeniaDzialanosci DATE,
    lokfiz_dataSkresleniaZRegon DATE,
    lofkiz_siedzKraj_Symbol varchar(10),
    lokfiz_siedzWojewodztwo_Symbol varchar(10),
    lokfiz_siedzPowiat_Symbol varchar(10),
    lokfiz_siedzGmina_Symbol varchar(10),
    lokfiz_siedzKodPocztowy varchar(6),
    lokfiz_siedzMiejscowoscPoczty_Symbol varchar(10),
    lokfiz_siedzMiejscowosc_Symbol varchar(10),
    lokfiz_siedzUlica_Symbol varchar(10),
    lokfiz_siedzNumerNieruchomosci varchar(20),
    lokfiz_siedzNumerLokalu varchar(20),
    lokfiz_siedzNietypoweMiejsceLokalizacji varchar(100),
    lokfiz_formaFinansowania_Symbol varchar(10),
    lokfiz_dataWpisuDoRejestruEwidencji DATE,
    lokfiz_numerWRejestrzeEwidencji varchar(20),
    lokfiz_organRejestrowy_Symbol varchar(10),
    lokfiz_rodzajRejestru_Symbol varchar(10),
    lokfizC_niePodjetoDzialanosci varchar(10),
    lokfiz_dataWpisuDoBazyDanych DATE,
--     CONSTRAINT fk_lokfiz_parentRegon FOREIGN KEY (lokfiz_parentRegon) REFERENCES common_F(fiz_regon),
    CONSTRAINT fk_silosID FOREIGN KEY (lokfiz_silosID) REFERENCES silos(silosID),
    CONSTRAINT fk_lokfiz_siedzKraj_Symbol FOREIGN KEY (lofkiz_siedzKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    CONSTRAINT fk_lokfiz_siedzWojewodztwo FOREIGN KEY (lokfiz_siedzWojewodztwo_Symbol) REFERENCES states(siedz_wojewodztwa_symbol),
    CONSTRAINT fk_lokfiz_siedzPowiat FOREIGN KEY (lokfiz_siedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    CONSTRAINT fk_lokfiz_siedzGmina FOREIGN KEY (lokfiz_siedzGmina_Symbol) REFERENCES municipalities(siedz_gmina_symbol),
    CONSTRAINT fk_lokfiz_siedzMiejscowosc FOREIGN KEY (lokfiz_siedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_lokfiz_siedz_ulica FOREIGN KEY (lokfiz_siedzUlica_Symbol) REFERENCES streets(siedz_ulica_symbol),
    CONSTRAINT fk_lokfiz_formaFinansowania FOREIGN KEY (lokfiz_formaFinansowania_Symbol) REFERENCES forms_of_financing(forma_finansowania_symbol),
    CONSTRAINT fk_lokfiz_organRejestrowy FOREIGN KEY (lokfiz_organRejestrowy_Symbol) REFERENCES registration_authorities(organ_rejestrowy_symbol),
    CONSTRAINT fk_lokfiz_rodzajRejestru FOREIGN KEY (lokfiz_rodzajRejestru_Symbol) REFERENCES register_types(rodzajRejestru_Symbol)
); -- created

CREATE TABLE common_LP(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lokpraw_regon varchar(14) NOT NULL,
    lokpraw_parentRegon varchar(9) NOT NULL,
    lokpraw_nazwa varchar(256),
    lokpraw_numerWRejestrzeEwiddencji varchar(10),
    lokpraw_dataWpisuDoRejestruEwidencji DATE,
    lokpraw_dataPowstania DATE,
    lokpraw_dataRozpoczeciaDzialalnosci DATE,
    lokpraw_dataWpisuDoRegon DATE,
    lokpraw_dataZawieszeniaDzialanosci DATE,
    lokpraw_dataWznowieniaDzialanosci DATE,
    lokpraw_dataZaistnieniaZmiany DATE,
    lokpraw_dataZakonczeniaDzialanosci DATE,
    lokpraw_dataSkresleniaZRegon DATE,
    lokpraw_siedzKraj_Symbol varchar(10),
    lokpraw_siedzWojewodztwo_Symbol varchar(10),
    lokpraw_siedzPowiat_Symbol varchar(10),
    lokpraw_siedzGmina_Symbol varchar(10),
    lokpraw_siedzMiejscowoscPoczty_Symbol varchar(10),
    lokpraw_siedzMiejscowosc_Symbol varchar(10),
    lokpraw_siedzUlica_Symbol varchar(10),
    lokpraw_siedzKodPocztowy varchar(7),
    lokpraw_siedzNumerNieruchomosci varchar(10),
    lokpraw_siedzNumerLokalu varchar(10),
    lokpraw_siedzNietypoweMiejsceLokalizacji varchar(256),
    lokpraw_formaFinansowania_Symbol varchar(10),
    lokpraw_organRejestrowy_Symbol varchar(10),
    lokpraw_rodzajRejestruEwidencji_Symbol varchar(10),
    lokpraw_dataWpisuDoBazyDanych DATE,
--     CONSTRAINT fk_lokpraw_regon FOREIGN KEY (lokpraw_regon) REFERENCES summary_data(regon),
--     CONSTRAINT fk_lokpraw_parentRegon FOREIGN KEY (lokpraw_parentRegon) REFERENCES common_P(praw_regon),
    CONSTRAINT fk_lokpraw_siedzKraj_Symbol FOREIGN KEY (lokpraw_siedzKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    CONSTRAINT fk_lokpraw_siedzWojewodztwo_Symbol FOREIGN KEY (lokpraw_siedzWojewodztwo_Symbol) REFERENCES states(siedz_wojewodztwa_symbol),
    CONSTRAINT fk_lokpraw_siedzPowiat FOREIGN KEY (lokpraw_siedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    CONSTRAINT fk_lokpraw_siedzGmina FOREIGN KEY (lokpraw_siedzGmina_Symbol) REFERENCES municipalities(siedz_gmina_symbol),
    CONSTRAINT fk_lokpraw_siedzMiejscowosc FOREIGN KEY (lokpraw_siedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_lokpraw_ulica FOREIGN KEY (lokpraw_siedzUlica_Symbol) REFERENCES streets(siedz_ulica_symbol),
    CONSTRAINT fk_lokpraw_FormaFinansowania FOREIGN KEY (lokpraw_formaFinansowania_Symbol) REFERENCES forms_of_financing(forma_finansowania_symbol),
    CONSTRAINT fk_lokpraw_organRejestrowy FOREIGN KEY (lokpraw_organRejestrowy_Symbol) REFERENCES registration_authorities(organ_rejestrowy_symbol),
    CONSTRAINT fk_lokpraw_rodzajRejestruEwidencji FOREIGN KEY (lokpraw_rodzajRejestruEwidencji_Symbol) REFERENCES type_of_register_of_records(rodzaj_rejestru_ewidencji_symbol)
);

CREATE TABLE pkds(
    pkd_Kod varchar(10) PRIMARY KEY,
    pkd_Nazwa varchar(256)
); -- created

DROP TABLE pkd_f_ownership;
CREATE TABLE pkd_F_ownership(
    fiz_pkd_regon varchar(9) NOT NULL,
    fiz_pkd_Kod varchar(10) NOT NULL,
    fiz_pkd_Przewazajace INT,
    fiz_pkd_SilosID INT,
    fiz_pkd_dataSkreslenia DATE,
    CONSTRAINT pk_pkd_F_ovnership PRIMARY KEY (fiz_pkd_regon, fiz_pkd_Kod),
    CONSTRAINT fk_pkd_Kod FOREIGN KEY (fiz_pkd_Kod) REFERENCES pkds(pkd_Kod),
    CONSTRAINT fk_silos FOREIGN KEY (fiz_pkd_SilosID) REFERENCES silos(silosID)
); -- created

CREATE TABLE pkd_LF_ownership(
    lokfiz_pkd_regon varchar(14) NOT NULL,
    lokfiz_pkd_Kod varchar(10) NOT NULL,
    lokfiz_pkd_Przewazajace INT,
    lokfiz_Silos_Symbol varchar(10),
    CONSTRAINT pk_pkd_LF_ownership PRIMARY KEY (lokfiz_pkd_regon, lokfiz_pkd_Kod),
    CONSTRAINT fk_pkd_Kod FOREIGN KEY (lokfiz_pkd_Kod) REFERENCES pkds(pkd_Kod)
); -- created

ALTER TABLE pkd_LF_ownership ALTER COLUMN lokfiz_Silos_Symbol TYPE INT USING lokfiz_Silos_Symbol::integer;

CREATE TABLE pkd_LP_ownership(
    lokpraw_pkd_regon varchar(14) NOT NULL,
    lokpraw_pkdKod varchar(10) NOT NULL,
    lokpraw_pkdPrzewazajace INT,
    CONSTRAINT pk_pkd_LP_ownership PRIMARY KEY (lokpraw_pkd_regon, lokpraw_pkdKod),
    CONSTRAINT fk_lokpraw_pkdKod FOREIGN KEY (lokpraw_pkdKod) REFERENCES pkds(pkd_Kod)
); -- created

CREATE TABLE pkd_P_ownership(
    praw_pkd_regon varchar(9) NOT NULL,
    praw_pkdKod varchar(10) NOT NULL,
    praw_pkdPrzewazajace INT,
    CONSTRAINT pk_pkd_P_ownership PRIMARY KEY (praw_pkd_regon, praw_pkdKod),
    CONSTRAINT fk_praw_pkdKod FOREIGN KEY (praw_pkdKod) REFERENCES pkds(pkd_Kod)
); -- created

CREATE TABLE Fizyczna_Dzialalnosc_Ceidg_i_Pozostala(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fiz_regon varchar(9) NOT NULL,
    fiz_nazwa varchar(256),
    fiz_nazwaSkrocona varchar(100),
    fiz_dataPowstania DATE,
    fiz_dataRpozpoczeciaDzialanosci DATE,
    fiz_dataWpisuDzialalnosciDoRegon DATE,
    fiz_dataZawieszeniaDzialalnosci DATE,
    fiz_dataWznowieniaDzialalnosci DATE,
    fiz_dataZaistnieniaZmiany DATE,
    fiz_dataZakonczeniaDzialalnosci DATE,
    fiz_dataSkresleniaDzialalnosciZRegon DATE,
    fiz_dataOrzeczeniaOUpadlosci DATE,
    fiz_dataZakonczeniaPostepowaniaUpadlosciowego DATE,
    fiz_adSiedzKraj_Symbol varchar(10),
    fiz_adSiedzWojewodztwo_Symbol varchar(10),
    fiz_adSiedzPowiat_Symbol varchar(10),
    fiz_adSiedzGmina_Symbol varchar(10),
    fiz_adSiedzKodPocztowy varchar(7),
    fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10),
    fiz_adSiedzMiejscowosc_Symbol varchar(10),
    fiz_adSiedzUlica_Symbol varchar(10),
    fiz_adSiedzNumerNieruchomosci varchar(10),
    fiz_adSiedzNumerLokalu varchar(10),
    fiz_adSiedzNietypoweMiejsceLokalizacji varchar(100),
    fiz_numerTelefonu varchar(10),
    fiz_numerWewnetrznyTelefonu varchar(10),
    fiz_numerFaksu varchar(10),
    fiz_adresStronyInternetowej varchar(35),
    fizC_dataWpisuDoRejestruEwidencji DATE,
    fizC_dataSkresleniaZRejestruEwidencji DATE,
    fizC_numerWRejestrzeEwidencji varchar(20),
    fizC_OrganRejestrowy_Symbol varchar(10),
    fizC_RodzajRejestru_Symbol varchar(10),
    fizC_NiePodjetoDzialalnosci varchar(15),
    fiz_rodzajDzialalnosci varchar(100) CHECK ( fiz_rodzajDzialalnosci IN ('Ceidg', 'Pozosta??a') ),
    CONSTRAINT fk_ceidg_kraj FOREIGN KEY (fiz_adSiedzKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    CONSTRAINT fk_ceidg_powiat FOREIGN KEY (fiz_adSiedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    CONSTRAINT fk_ceidg_gmina FOREIGN KEY (fiz_adSiedzGmina_Symbol) REFERENCES municipalities(siedz_gmina_symbol),
    CONSTRAINT fk_ceidg_town FOREIGN KEY (fiz_adSiedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_ceidg_post FOREIGN KEY (fiz_adSiedzMiejscowoscPoczty_Symbol) REFERENCES posts(siedz_miejscowosc_poczty_symbol),
    CONSTRAINT fk_ceidg_street FOREIGN KEY (fiz_adSiedzUlica_Symbol) REFERENCES streets(siedz_ulica_symbol),
    CONSTRAINT fk_ceidg_register_authorities FOREIGN KEY (fizC_OrganRejestrowy_Symbol) REFERENCES registration_authorities(organ_rejestrowy_symbol),
    CONSTRAINT fk_registerType FOREIGN KEY (fizC_RodzajRejestru_Symbol) REFERENCES register_types(rodzajRejestru_Symbol)

); -- created

CREATE TABLE FizycznaDzialalnoscRolnicza(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fiz_regon varchar(9) NOT NULL,
    fiz_nazwa varchar(256),
    fiz_nazwa_skrocona varchar(100),
    fiz_dataPowstania DATE,
    fiz_dataRozpoczeciaDzialalnosci DATE,
    fiz_dataWpisuDzialalnosciDoRegon DATE,
    fiz_dataZawieszeniaDzialalnosci DATE,
    fiz_dataWznowieniaDzialalnosci DATE,
    fiz_dataZaistnieniaZmianyDzialalnosci DATE,
    fiz_dataZakonczeniaDzialalnosci DATE,
    fiz_dataSkresleniaDzialalanosciZRegon DATE,
    fiz_dataOrzeczeniaOUpadlosci DATE,
    fiz_dataZakonczeniaPostepowaniaUpadlosciowego DATE,
    fiz_adSiedzKraj_Symbol varchar(10),
    fiz_adSiedzWojewodztwo_Symbol varchar(10),
    fiz_adSiedzPowiat_Symbol varchar(10),
    fiz_adSiedzGmina_Symbol varchar(10),
    fiz_adSiedzKodPocztowy varchar(6),
    fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10),
    fiz_adSiedzMiejscowosc_Symbol varchar(10),
    fiz_adSiedzUlica_Symbol varchar(10),
    fiz_adSiedzNumerNieruchomosci varchar(10),
    fiz_adSiedzNumerLokalu varchar(10),
    fiz_adSiedzNietypoweMiejsceLokalizacji varchar(256),
    fiz_numerTelefonu varchar(10),
    fiz_numerWewnetrznyTelefonu varchar(10),
    fiz_numerFaksu varchar(10),
    fiz_adresEmail varchar(20),
    fiz_adresStronyinternetowej varchar(20),
    CONSTRAINT fk_agr_kraj FOREIGN KEY (fiz_adSiedzKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    CONSTRAINT fk_agr_powiat FOREIGN KEY (fiz_adSiedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    CONSTRAINT fk_agr_gmina FOREIGN KEY (fiz_adSiedzGmina_Symbol) REFERENCES municipalities(siedz_gmina_symbol),
    CONSTRAINT fk_agr_town FOREIGN KEY (fiz_adSiedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_agr_post FOREIGN KEY (fiz_adSiedzMiejscowoscPoczty_Symbol) REFERENCES posts(siedz_miejscowosc_poczty_symbol),
    CONSTRAINT fk_agr_street FOREIGN KEY (fiz_adSiedzUlica_Symbol) REFERENCES streets(siedz_ulica_symbol)

); -- created

CREATE TABLE Fizyczne_Sreslone(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fiz_regon varchar(9) NOT NULL,
    fiz_nazwa varchar(256),
    fiz_nazwaSkrocona varchar(100),
    fiz_dataPowstania DATE,
    fiz_dataRozpoczeciaDzialalnosci DATE,
    fiz_dataWpisuDzialalnosciDoRegon DATE,
    fiz_dataZawieszeniaDzialalnosci DATE,
    fiz_dataWznowieniaDzialalnosci DATE,
    fiz_dataZaistnieniaZmianyDzialalnosci DATE,
    fiz_dataZakonczeniaDzialalnosci DATE,
    fiz_dataSkresleniaDzialalnosciZRegon DATE,
    fiz_adSiedzKraj_Symbol varchar(10),
    fiz_adSiedzWojewodztwo_Symbol varchar(10),
    fiz_adSiedzPowiat_Symbol varchar(10),
    fiz_adSiedzGmina_Symbol varchar(10),
    fiz_adSiedzKodPocztowy varchar(6),
    fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10),
    fiz_adSiedzMiejscowosc_Symbol varchar(10),
    fiz_adSiedzUlica_Symbol varchar(10),
    fiz_adSiedzNumerNieruchomosci varchar(10),
    fiz_adSiedzNumerLokalu varchar(10),
    fiz_adSiedzNietypoweMiejsceLokalizacji varchar(256),
    fiz_numerTelefonu varchar(10),
    fiz_numerWewnetrznyTelefonu varchar(10),
    fiz_numerFaksu varchar(10),
    fiz_adresEmail varchar(20),
    fiz_adresStronyinternetowej varchar(20),
    fiz_adresEmail2 varchar(20),
    CONSTRAINT fk_del_kraj FOREIGN KEY (fiz_adSiedzKraj_Symbol) REFERENCES countries(siedz_kraj_symbol),
    CONSTRAINT fk_del_powiat FOREIGN KEY (fiz_adSiedzPowiat_Symbol) REFERENCES counties(siedz_powiat_symbol),
    CONSTRAINT fk_del_gmina FOREIGN KEY (fiz_adSiedzGmina_Symbol) REFERENCES municipalities(siedz_gmina_symbol),
    CONSTRAINT fk_del_town FOREIGN KEY (fiz_adSiedzMiejscowosc_Symbol) REFERENCES towns(siedz_miejscowosc_symbol),
    CONSTRAINT fk_del_post FOREIGN KEY (fiz_adSiedzMiejscowoscPoczty_Symbol) REFERENCES posts(siedz_miejscowosc_poczty_symbol),
    CONSTRAINT fk_del_street FOREIGN KEY (fiz_adSiedzUlica_Symbol) REFERENCES streets(siedz_ulica_symbol)

); -- created

ALTER TABLE common_f RENAME COLUMN id TO f_id;
ALTER TABLE fizyczna_dzialalnosc_ceidg_i_pozostala RENAME COLUMN id TO f_cdeig_rest_id;
ALTER TABLE fizycznadzialalnoscrolnicza RENAME COLUMN id TO f_agr_id;
ALTER TABLE fizyczne_sreslone RENAME COLUMN id to f_del_id;
ALTER TABLE common_p RENAME COLUMN id to p_id;
ALTER TABLE common_lp RENAME COLUMN id TO lp_id;
ALTER TABLE common_lf RENAME COLUMN id to lp_id;
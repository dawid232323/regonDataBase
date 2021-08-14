CREATE OR REPLACE FUNCTION get_parent_regon(long_regon varchar(14)) RETURNS varchar(9) AS $parent_regon$
    declare
        parent_regon varchar(9);
    BEGIN
        SELECT LEFT(long_regon, 9) INTO parent_regon;
        RETURN parent_regon;
    end;
    $parent_regon$ LANGUAGE plpgsql; -- created



CREATE OR REPLACE PROCEDURE insert_addresses(
municipality_symbol varchar(10), municipality_name varchar(256), town_symbol varchar(10),
town_name varchar(256), post_symbol varchar(10), post_name varchar(256), street_symbol varchar(10),
street_name varchar(256)
)LANGUAGE plpgsql AS $$
    BEGIN
        IF NOT EXISTS(SELECT * FROM municipalities WHERE siedz_gmina_symbol = municipality_symbol) AND
           municipality_symbol IS NOT NULL THEN
            INSERT INTO municipalities (siedz_gmina_symbol, siedz_gmina_nazwa) VALUES
            (municipality_symbol, municipality_name);
        end if;
        IF NOT EXISTS(SELECT * FROM towns WHERE siedz_miejscowosc_symbol = town_symbol) AND
           town_symbol IS NOT NULL THEN
            INSERT INTO towns (siedz_miejscowosc_symbol, siedz_miejscowosc_nazwa) VALUES
            (town_symbol, town_name);
        end if;
        IF NOT EXISTS(SELECT * FROM posts WHERE siedz_miejscowosc_poczty_symbol = post_symbol) AND
           post_symbol IS NOT NULL THEN
            INSERT INTO posts (siedz_miejscowosc_poczty_symbol, siedz_miejscowosc_poczty_nazwa) VALUES
            (post_symbol, post_name);
        end if;
        IF NOT EXISTS(SELECT * FROM streets WHERE siedz_ulica_symbol = street_symbol) AND
           street_symbol IS NOT NULL THEN
            INSERT INTO streets (siedz_ulica_symbol, siedz_ulica_nazwa) VALUES
            (street_symbol, street_name);
        end if;
    end;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_into_common_P(
    regon varchar(9), proc_nip varchar(10) DEFAULT NULL, proc_statusNip varchar(10) DEFAULT NULL, 
    proc_nazwa varchar(256) DEFAULT NULL,
    proc_nazwaSkrocona varchar(100) DEFAULT NULL,
     proc_numerWRejestrzeEwidencji varchar(15) DEFAULT NULL,
      proc_dataWpisuDoRejestruEwidencji DATE DEFAULT NULL,
    proc_dataPowstamia DATE DEFAULT NULL,
     proc_dataRozpoczeciaDzialanosci DATE DEFAULT NULL,
      proc_dataWpisuDoRegon DATE DEFAULT NULL,
    proc_dataZawieszeniaDzialanosci DATE DEFAULT NULL,
     proc_dataWznowieniaDzialanosci DATE DEFAULT NULL,
      proc_dataZaistnieniaZmiany DATE DEFAULT NULL,
    proc_dataZakonczeniaDzialanosci DATE DEFAULT NULL,
     proc_dataSkresleniaZRegon DATE DEFAULT NULL, proc_dataOrzeczeniaOUpadlosci DATE DEFAULT NULL,
    proc_dataZakonczeniaPostepowaniaUpadlosciowego DATE DEFAULT NULL, 
    proc_siedzibaKraj_Symbol varchar(10) DEFAULT NULL,
     proc_siedzWojewodztwo_Symbol varchar(10) DEFAULT NULL,
    proc_siedzPowiat_Symbol varchar(10) DEFAULT NULL,
     proc_siedzGminaSymbol varchar(10) DEFAULT NULL,
      proc_siedzGminaNazwa varchar(256) DEFAULT NULL,
    proc_siedzKodPocztowy varchar(7) DEFAULT NULL,
     proc_siedzMiejscowoscPoczty_Symbol varchar(10) DEFAULT NULL,
     proc_siedzMiejscowoscPoczty_Nazwa varchar(256) DEFAULT NULL, proc_siedzMiejscowosc_Symbol varchar(10) DEFAULT NULL,
    proc_siedzMiejscowosc_Nazwa varchar(256) DEFAULT NULL,
    proc_siedzUlicaSymbol varchar(10) DEFAULT NULL,
     proc_siedzUlicaNazwa varchar(256) DEFAULT NULL,
      proc_siedzNumerNieruchomosci varchar(15) DEFAULT NULL,
    proc_siedzNumerLokalu varchar(15) DEFAULT NULL,
     proc_siedzNietypoweMiejsceLokalizacji varchar(100) DEFAULT NULL,
    proc_numerTelefonu varchar(13) DEFAULT NULL,
     proc_numerWewnetrznyTelefoonu varchar(15) DEFAULT NULL,
    proc_numerFaksu varchar(20) DEFAULT NULL,
     proc_adresStronyInternetowej varchar(100) DEFAULT NULL,
    proc_podstawowaFormaPrawna_Symbol varchar(10) DEFAULT NULL,
     proc_podstawowa_forma_prawna_nazwa varchar(256) DEFAULT NULL,
    proc_szczegolnaFormaPrawna_Symbol varchar(10) DEFAULT NULL,
     szczegolnaFormaPrawna_nazwa varchar(256) DEFAULT NULL,
    proc_formaFinansowania_Symbol varchar(10) DEFAULT NULL,
     formaFinansowania_nazwa varchar(256) DEFAULT NULL,
    proc_formaWlasnosci_Symbol varchar(10) DEFAULT NULL,
     praw_formaWlasnosci_nazwa varchar(256) DEFAULT NULL,
    proc_organZalozycielski varchar(10) DEFAULT NULL,
     proc_organZalozycielski_nazwa varchar(256) DEFAULT NULL,
    proc_organRejestrowy_Symbol varchar(10) DEFAULT NULL,
     organRejestrowy_nazwa varchar(256) DEFAULT NULL,
    proc_rodzajRejestruEwidencji_SYmbol varchar(10) DEFAULT NULL,
     rodzajRejestruEwidencji_nazwa varchar(256) DEFAULT NULL,
    proc_liczbaJednostekLokalnych INT DEFAULT NULL, proc_dataWpisuDoBazyDanych DATE DEFAULT NULL
)LANGUAGE plpgsql
 as $$
begin
    CALL insert_addresses(proc_siedzGminaSymbol, proc_siedzGminaNazwa, proc_siedzMiejscowosc_Symbol,
        proc_siedzMiejscowosc_Nazwa, proc_siedzMiejscowoscPoczty_Symbol, proc_siedzMiejscowoscPoczty_Nazwa,
        proc_siedzUlicaSymbol, proc_siedzUlicaNazwa);

    if not exists(SELECT * FROM basic_legal_form where podstawowa_forma_prawna_symbol = proc_podstawowaFormaPrawna_Symbol) AND
       proc_podstawowaFormaPrawna_Symbol IS NOT NULL THEN
        INSERT INTO basic_legal_form (podstawowa_forma_prawna_symbol, podstawowa_forma_prawna_nazwa) VALUES (proc_podstawowaFormaPrawna_Symbol, proc_podstawowa_forma_prawna_nazwa);

    end if;
    if not exists(SELECT * FROM specific_legal_form WHERE szczegolna_forma_prawna_symbol = proc_szczegolnaFormaPrawna_Symbol)
        AND proc_szczegolnaFormaPrawna_Symbol IS NOT NULL THEN
        INSERT INTO specific_legal_form (szczegolna_forma_prawna_symbol, szeczgolna_forma_prawna_nazwa) VALUES
        (proc_szczegolnaFormaPrawna_Symbol, szczegolnaFormaPrawna_nazwa);
    end if;
    if not exists(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = proc_formaFinansowania_Symbol)
        AND proc_formaFinansowania_Symbol IS NOT NULL THEN
        INSERT INTO forms_of_financing(forma_finansowania_symbol, forma_finansowania_nazwa) VALUES (proc_formaFinansowania_Symbol, formaFinansowania_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM founding_bodies WHERE ogran_zalozycielski_symbol = proc_organZalozycielski)
        AND proc_organZalozycielski IS NOT NULL THEN
        INSERT INTO founding_bodies (ogran_zalozycielski_symbol, organ_zalozycielski_nazwa) VALUES (proc_organZalozycielski, proc_organZalozycielski_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM forms_of_ownership WHERE forma_wlasnosci_symbol = proc_formaWlasnosci_Symbol)
        AND proc_formaWlasnosci_Symbol IS NOT NULL THEN
        INSERT INTO forms_of_ownership (forma_wlasnosci_symbol, forma_wlasnosci_nazwa) VALUES (proc_formaWlasnosci_Symbol, praw_formaWlasnosci_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM type_of_register_of_records WHERE rodzaj_rejestru_ewidencji_symbol = proc_rodzajRejestruEwidencji_SYmbol)
        AND proc_rodzajRejestruEwidencji_SYmbol IS NOT NULL THEN
        INSERT INTO type_of_register_of_records (rodzaj_rejestru_ewidencji_symbol, rodzaj_rejestru_ewidencji_nazwa) VALUES
        (proc_rodzajRejestruEwidencji_SYmbol, rodzajRejestruEwidencji_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_organRejestrowy_Symbol)
        AND proc_organRejestrowy_Symbol IS NOT NULL THEN
        INSERT INTO registration_authorities (organ_rejestrowy_symbol, organ_rejestrowy_nazwa) VALUES (proc_organRejestrowy_Symbol, organRejestrowy_nazwa);
    end if;
    INSERT INTO common_P (praw_regon, praw_nip, praw_statusnip, praw_nazwa, praw_nazwaskrocona, praw_numerwrejestrzeewidencji,
                          praw_datawpisudorejestruewidencji, praw_datapowstamia, praw_datarozpoczeciadzialanosci, praw_datawpisudoregon,
                          praw_datazawieszeniadzialanosci, praw_datawznowieniadzialanosci, praw_datazaistnieniazmiany, praw_datazakonczeniadzialanosci,
                          praw_dataskresleniazregon, praw_dataorzeczeniaoupadlosci, praw_datazakonczeniapostepowaniaupadlosciowego,
                          praw_siedzibakraj_symbol, praw_siedzwojewodztwo_symbol, praw_siedzpowiat_symbol, praw_siedzgminasymbol,
                          praw_siedzkodpocztowy, praw_siedzmiejscowoscpoczty_symbol, praw_siedzmiejscowosc_symbol, praw_siedzulicasymbol,
                          praw_siedznumernieruchomosci, praw_siedznumerlokalu, praw_siedznietypowemiejscelokalizacji, praw_numertelefonu,
                          praw_numerwewnetrznytelefoonu, praw_numerfaksu, praw_adresstronyinternetowej, praw_podstawowaformaprawna_symbol,
                          praw_szczegolnaformaprawna_symbol, praw_formafinansowania_symbol, praw_formawlasnosci_symbol, praw_organzalozycielski,
                          praw_organrejestrowy_symbol, praw_rodzajrejestruewidencji_symbol, praw_liczbajednosteklokalnych, praw_dataWpisuDoBazyDanych)
                          VALUES (regon, proc_nip, proc_statusNip, proc_nazwa, proc_nazwaSkrocona, proc_numerWRejestrzeEwidencji,
                                  proc_dataWpisuDoRejestruEwidencji, proc_dataPowstamia, proc_dataRozpoczeciaDzialanosci, proc_dataWpisuDoRegon,
                                  proc_dataZawieszeniaDzialanosci, proc_dataWznowieniaDzialanosci, proc_dataZaistnieniaZmiany, proc_dataZakonczeniaDzialanosci,
                                  proc_dataSkresleniaZRegon, proc_dataOrzeczeniaOUpadlosci, proc_dataZakonczeniaPostepowaniaUpadlosciowego, proc_siedzibaKraj_Symbol,
                                  proc_siedzWojewodztwo_Symbol, proc_siedzPowiat_Symbol, proc_siedzGminaSymbol, proc_siedzKodPocztowy, proc_siedzMiejscowoscPoczty_Symbol,
                                  proc_siedzMiejscowosc_Symbol, proc_siedzUlicaSymbol, proc_siedzNumerNieruchomosci, proc_siedzNumerLokalu, proc_siedzNietypoweMiejsceLokalizacji,
                                  proc_numerTelefonu, proc_numerWewnetrznyTelefoonu, proc_numerFaksu, proc_adresStronyInternetowej, proc_podstawowaFormaPrawna_Symbol,
                                  proc_szczegolnaFormaPrawna_Symbol, proc_formaFinansowania_Symbol, proc_formaWlasnosci_Symbol, proc_organZalozycielski,
                                  proc_organRejestrowy_Symbol, proc_rodzajRejestruEwidencji_SYmbol, proc_liczbaJednostekLokalnych, proc_dataWpisuDoBazyDanych);

end;
    $$; -- created
CREATE OR REPLACE PROCEDURE insert_into_common_F(
fproc_regon varchar(9), fproc_nip varchar(10), fproc_statusNIP varchar(10), fproc_nazwisko varchar(100), fproc_imie1 varchar(100), fproc_imie2 varchar(10),
fproc_dataWpisuDoRegon DATE, fproc_dataZaistnieniaZmiany DATE, fproc_dataSkresleniaPodmiotuZRegon DATE, fproc_podstawowaFormaPrawna_Symbol varchar(10),
fproc_podstawowaFormaPrawna_Nazwa varchar(100), fproc_szczegolnaFormaPrawna_Symbol varchar(10), fproc_szczegolnaFormaPrawna_Nazwa varchar(100),
fproc_formaFinansowania_Symbol varchar(10), fproc_formaFinansowania_Nazwa varchar(100),fproc_formaWlasnosci_Symbol varchar(10), fproc_formaWlasnosci_Nazwa varchar(100), fproc_dzialanoscCEIDG INT, fproc_dzialanoscRolnicza INT,
fproc_dzialalnoscPozostala INT, fproc_dzialalnoscSkreslona INT, fproc_liczbaJednostekLokalnych INT, fproc_dataWpisuDoBazyDanych DATE
)LANGUAGE plpgsql as $$
    begin
        IF NOT EXISTS(SELECT * FROM basic_legal_form WHERE podstawowa_forma_prawna_symbol = fproc_podstawowaFormaPrawna_Symbol)
            AND fproc_podstawowaFormaPrawna_Symbol IS NOT NULL THEN
            INSERT INTO basic_legal_form (podstawowa_forma_prawna_symbol, podstawowa_forma_prawna_nazwa) VALUES
            (fproc_podstawowaFormaPrawna_Symbol, fproc_podstawowaFormaPrawna_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM specific_legal_form WHERE szczegolna_forma_prawna_symbol = fproc_szczegolnaFormaPrawna_Symbol)
            AND fproc_szczegolnaFormaPrawna_Symbol IS NOT NULL THEN
            INSERT INTO specific_legal_form (szczegolna_forma_prawna_symbol, szeczgolna_forma_prawna_nazwa) VALUES
            (fproc_szczegolnaFormaPrawna_Symbol, fproc_szczegolnaFormaPrawna_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = fproc_formaFinansowania_Symbol)
            AND fproc_formaFinansowania_Symbol IS NOT NULL THEN
            INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
            (fproc_formaFinansowania_Symbol, fproc_formaFinansowania_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM forms_of_ownership WHERE forma_wlasnosci_symbol = fproc_formaWlasnosci_Symbol)
            AND fproc_formaWlasnosci_Symbol IS NOT NULL THEN
            INSERT INTO forms_of_ownership (forma_wlasnosci_symbol, forma_wlasnosci_nazwa) VALUES
            (fproc_formaWlasnosci_Symbol, fproc_formaWlasnosci_Nazwa);
        end if;
        INSERT INTO common_F (fiz_regon, fiz_NIP, fiz_statusNIP, fiz_Nazwisko, fiz_imie1, fiz_imie2, fiz_dataWpisuPodmiotuDoRegon,
                              fiz_dataZaistnieniaZmiany, fiz_dataSkresleniaPodmiotuZRegon, fiz_podstawowaFormaPrawna_Symbol,
                              fiz_szczegolnaFormaPrawna_Symbol, fiz_formaFinansowania_Symbol, fiz_formaWlasnosci_Symbol,
                              fiz_dzialanoscCeidg, fiz_dzialnoscRolnicza, fiz_dzialanoscPozostala, fiz_dzialanoscSkreslonaDo20141108,
                              fiz_liczbaJednLokalnych, fiz_dataWpisuDoBazyDanych)
                            VALUES (fproc_regon, fproc_nip, fproc_statusNIP, fproc_nazwisko, fproc_imie1, fproc_imie2, fproc_dataWpisuDoRegon,
                                    fproc_dataZaistnieniaZmiany, fproc_dataSkresleniaPodmiotuZRegon, fproc_podstawowaFormaPrawna_Symbol,
                                    fproc_szczegolnaFormaPrawna_Symbol, fproc_formaFinansowania_Symbol, fproc_formaWlasnosci_Symbol,
                                    fproc_dzialanoscCEIDG, fproc_dzialanoscRolnicza, fproc_dzialalnoscPozostala, fproc_dzialalnoscSkreslona,
                                    fproc_liczbaJednostekLokalnych, fproc_dataWpisuDoBazyDanych);
    end;
    $$; -- created

DROP PROCEDURE insert_into_common_lp(proc_lokpraw_regon varchar, proc_lokpraw_nazwa varchar, proc_lokpraw_numerwrejestrzeewiddencji varchar, proc_lokpraw_datawpisudorejestruewidencji date, proc_lokpraw_datapowstania date, proc_lokpraw_datarozpoczeciadzialalnosci date, proc_lokpraw_datawpisudoregon date, proc_lokpraw_datazawieszeniadzialanosci date, proc_lokpraw_datawznowieniadzialanosci date, proc_lokpraw_datazaistnieniazmiany date, proc_lokpraw_datazakonczeniadzialanosci date, proc_lokpraw_dataskresleniazregon date, proc_lokpraw_siedzkraj_symbol varchar, proc_lokpraw_siedzwojewodztwo_symbol varchar, proc_lokpraw_siedzpowiat_symbol varchar, proc_lokpraw_siedzgmina_symbol varchar, proc_lokpraw_siedzgmina_nazwa varchar, proc_lokpraw_siedzmiejscowoscpoczty_symbol varchar, proc_lokpraw_siedzmiejscowoscpoczty_nazwa varchar, proc_lokpraw_siedzmiejscowosc_symbol varchar, proc_lokpraw_siedzmiejscowosc_nazwa varchar, proc_lokpraw_siedzulica_symbol varchar, proc_lokpraw_siedzulica_nazwa varchar, proc_lokpraw_siedzkodpocztowy varchar, proc_lokpraw_siedznumernieruchomosci varchar, proc_lokpraw_siedznumerlokalu varchar, proc_lokpraw_siedznietypowemiejscelokalizacji varchar, proc_lokpraw_formafinansowania_symbol varchar, proc_lokpraw_formafinansowania_nazwa varchar, proc_lokpraw_organrejestrowy_symbol varchar, proc_lokpraw_organrejestrowy_nazwa varchar, proc_lokpraw_rodzajrejestruewidencji_symbol varchar, proc_lokpraw_rodzajrejestruewidencji_nazwa varchar, proc_lokpraw_datawpisudobazydanych date);
CREATE OR REPLACE PROCEDURE insert_into_common_LP(proc_lokpraw_regon varchar(14), --proc_lokpraw_parentRegon varchar(9),
    proc_lokpraw_nazwa varchar(256), proc_lokpraw_numerWRejestrzeEwiddencji varchar(10), proc_lokpraw_dataWpisuDoRejestruEwidencji DATE,
    proc_lokpraw_dataPowstania DATE, proc_lokpraw_dataRozpoczeciaDzialalnosci DATE, proc_lokpraw_dataWpisuDoRegon DATE,
    proc_lokpraw_dataZawieszeniaDzialanosci DATE, proc_lokpraw_dataWznowieniaDzialanosci DATE, proc_lokpraw_dataZaistnieniaZmiany DATE,
    proc_lokpraw_dataZakonczeniaDzialanosci DATE, proc_lokpraw_dataSkresleniaZRegon DATE, proc_lokpraw_siedzKraj_Symbol varchar(10),
    proc_lokpraw_siedzWojewodztwo_Symbol varchar(10), proc_lokpraw_siedzPowiat_Symbol varchar(10), proc_lokpraw_siedzGmina_Symbol varchar(10),
    proc_lokpraw_siedzGmina_Nazwa varchar(256), proc_lokpraw_siedzKodPocztowy varchar(7), proc_lokpraw_siedzMiejscowoscPoczty_Symbol varchar(10), proc_lokpraw_siedzMiejscowoscPoczty_Nazwa varchar(256),
    proc_lokpraw_siedzMiejscowosc_Symbol varchar(10),
    proc_lokpraw_siedzMiejscowosc_Nazwa varchar(256), proc_lokpraw_siedzUlica_Symbol varchar(10), proc_lokpraw_siedzUlica_Nazwa varchar(256),
    proc_lokpraw_siedzNumerNieruchomosci varchar(10), proc_lokpraw_siedzNumerLokalu varchar(10),
    proc_lokpraw_siedzNietypoweMiejsceLokalizacji varchar(256), proc_lokpraw_formaFinansowania_Symbol varchar(10), proc_lokpraw_formaFinansowania_Nazwa varchar(256),
    proc_lokpraw_organRejestrowy_Symbol varchar(10), proc_lokpraw_organRejestrowy_Nazwa varchar(256), proc_lokpraw_rodzajRejestruEwidencji_Symbol varchar(10),
    proc_lokpraw_rodzajRejestruEwidencji_Nazwa varchar(256), proc_lokpraw_dataWpisuDoBazyDanych DATE) LANGUAGE plpgsql as $$
    DECLARE
        proc_lokpraw_parentRegon varchar(9);
    begin
       SELECT get_parent_regon(proc_lokpraw_regon) INTO proc_lokpraw_parentRegon;
       IF NOT EXISTS(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = proc_lokpraw_formaFinansowania_Symbol)
           AND proc_lokpraw_formaFinansowania_Symbol IS NOT NULL THEN
           INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
           (proc_lokpraw_formaFinansowania_Symbol, proc_lokpraw_formaFinansowania_Nazwa);
       end if;
       IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_lokpraw_organRejestrowy_Symbol)
           AND proc_lokpraw_organRejestrowy_Symbol IS NOT NULL THEN
           INSERT INTO registration_authorities (organ_rejestrowy_symbol, organ_rejestrowy_nazwa) VALUES
           (proc_lokpraw_organRejestrowy_Symbol, proc_lokpraw_organRejestrowy_Nazwa);
       end if;
       IF NOT EXISTS(SELECT * FROM type_of_register_of_records WHERE rodzaj_rejestru_ewidencji_symbol = proc_lokpraw_rodzajRejestruEwidencji_Symbol)
           AND proc_lokpraw_rodzajRejestruEwidencji_Symbol IS NOT NULL THEN
           INSERT INTO type_of_register_of_records (rodzaj_rejestru_ewidencji_symbol, rodzaj_rejestru_ewidencji_nazwa) VALUES
           (proc_lokpraw_rodzajRejestruEwidencji_Symbol, proc_lokpraw_rodzajRejestruEwidencji_Nazwa);
       end if;
       CALL insert_addresses(proc_lokpraw_siedzGmina_Symbol, proc_lokpraw_siedzGmina_Nazwa,
           proc_lokpraw_siedzMiejscowosc_Symbol, proc_lokpraw_siedzMiejscowosc_Nazwa,
           proc_lokpraw_siedzMiejscowoscPoczty_Symbol, proc_lokpraw_siedzMiejscowoscPoczty_Nazwa,
           proc_lokpraw_siedzUlica_Symbol, proc_lokpraw_siedzUlica_Nazwa);
        INSERT INTO common_LP (lokpraw_regon, lokpraw_parentRegon, lokpraw_nazwa, lokpraw_numerWRejestrzeEwiddencji,
                               lokpraw_dataWpisuDoRejestruEwidencji, lokpraw_dataPowstania, lokpraw_dataRozpoczeciaDzialalnosci,
                               lokpraw_dataWpisuDoRegon, lokpraw_dataZawieszeniaDzialanosci, lokpraw_dataWznowieniaDzialanosci,
                               lokpraw_dataZaistnieniaZmiany, lokpraw_dataZakonczeniaDzialanosci, lokpraw_dataSkresleniaZRegon,
                               lokpraw_siedzKraj_Symbol, lokpraw_siedzWojewodztwo_Symbol, lokpraw_siedzPowiat_Symbol,
                               lokpraw_siedzGmina_Symbol, lokpraw_siedzMiejscowoscPoczty_Symbol, lokpraw_siedzMiejscowosc_Symbol,
                               lokpraw_siedzUlica_Symbol, lokpraw_siedzKodPocztowy, lokpraw_siedzNumerNieruchomosci,
                               lokpraw_siedzNumerLokalu, lokpraw_siedzNietypoweMiejsceLokalizacji, lokpraw_formaFinansowania_Symbol,
                               lokpraw_organRejestrowy_Symbol, lokpraw_rodzajRejestruEwidencji_Symbol, lokpraw_dataWpisuDoBazyDanych) VALUES
        (proc_lokpraw_regon, proc_lokpraw_parentRegon, proc_lokpraw_nazwa, proc_lokpraw_numerWRejestrzeEwiddencji, proc_lokpraw_dataWpisuDoRejestruEwidencji,
         proc_lokpraw_dataPowstania, proc_lokpraw_dataRozpoczeciaDzialalnosci, proc_lokpraw_dataWpisuDoRegon, proc_lokpraw_dataZawieszeniaDzialanosci,
         proc_lokpraw_dataWznowieniaDzialanosci, proc_lokpraw_dataZaistnieniaZmiany, proc_lokpraw_dataZakonczeniaDzialanosci, proc_lokpraw_dataSkresleniaZRegon,
         proc_lokpraw_siedzKraj_Symbol, proc_lokpraw_siedzWojewodztwo_Symbol, proc_lokpraw_siedzPowiat_Symbol, proc_lokpraw_siedzGmina_Symbol,
         proc_lokpraw_siedzMiejscowoscPoczty_Symbol, proc_lokpraw_siedzMiejscowosc_Symbol, proc_lokpraw_siedzUlica_Symbol, proc_lokpraw_siedzKodPocztowy,
         proc_lokpraw_siedzNumerNieruchomosci, proc_lokpraw_siedzNumerLokalu, proc_lokpraw_siedzNietypoweMiejsceLokalizacji, proc_lokpraw_formaFinansowania_Symbol,
         proc_lokpraw_organRejestrowy_Symbol, proc_lokpraw_rodzajRejestruEwidencji_Symbol, proc_lokpraw_dataWpisuDoBazyDanych);

       end;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_into_common_LF(
    proc_lokfiz_regon varchar(14), proc_lokfiz_nazwa varchar(256), proc_lokfiz_silosID INT, proc_lokfiz_SilosNazwa varchar(100),
    proc_lokfiz_dataPowstania DATE, proc_dataRozpoczeciaDzialalnosci DATE, proc_lokfiz_dataWpisuDoRegon DATE, proc_lokfiz_dataZawieszeniaDzialanosci DATE,
    proc_lokfiz_dataWznowieniaDzialanosci DATE, proc_lokfiz_dataZaistnieniaZmiany DATE, proc_lokfizdataZakonczeniaDzialanosci DATE,
    proc_lokfiz_dataSkresleniaZRegon DATE, proc_lofkiz_siedzKraj_Symbol varchar(10), proc_lokfiz_siedzWojewodztwo_Symbol varchar(10),
    proc_lokfiz_siedzPowiat_Symbol varchar(10), proc_lokfiz_siedzGmina_Symbol varchar(10),
    proc_lokfiz_siedzGmina_Nazwa varchar(100) , proc_lokfiz_siedzKodPocztowy varchar(6),
    proc_lokfiz_siedzMiejscowoscPoczty_Symbol varchar(10), proc_lokfiz_siedzPoczty_Nazwa varchar(100),
    proc_lokfiz_siedzMiejscowosc_Symbol varchar(10),
    proc_lokfiz_siedzMiejscowosc_Nazwa varchar(100), proc_lokfiz_siedzUlica_Symbol varchar(10), proc_lokfizUlica_Nazwa varchar(100),
    proc_lokfiz_siedzNumerNieruchomosci varchar(20), proc_lokfiz_siedzNumerLokalu varchar(20), proc_lokfiz_siedzNietypoweMiejsceLokalizacji varchar(100),
    proc_lokfiz_formaFinansowania_Symbol varchar(10), proc_lokfiz_formaFinansowania_Nazwa varchar(256), proc_lokfiz_dataWpisuDoRejestruEwidencji DATE,
    proc_lokfiz_numerWRejestrzeEwidencji varchar(20), proc_lokfiz_organRejestrowy_Symbol varchar(10), proc_lokfiz_organRejestrowy_Nazwa varchar(256),
    proc_lokfiz_rodzajRejestru_Symbol varchar(10), proc_lokfiz_rodzajRejestru_Nazwa varchar(256), proc_lokfizC_niePodjetoDzialanosci varchar(10),
    proc_lokfiz_dataWpisuDoBazyDanych DATE
) LANGUAGE plpgsql AS $$
    DECLARE
        proc_lokfiz_parentRegon varchar(9);
    BEGIN
        SELECT get_parent_regon(proc_lokfiz_regon) INTO proc_lokfiz_parentRegon;
        IF NOT EXISTS(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = proc_lokfiz_formaFinansowania_Symbol)
            AND proc_lokfiz_formaFinansowania_Symbol IS NOT NULL THEN
            INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
            (proc_lokfiz_formaFinansowania_Symbol, proc_lokfiz_formaFinansowania_Symbol);
        end if;
        IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_lokfiz_organRejestrowy_Symbol)
            AND proc_lokfiz_organRejestrowy_Symbol IS NOT NULL THEN
            INSERT INTO registration_authorities (organ_rejestrowy_symbol, organ_rejestrowy_nazwa) VALUES
            (proc_lokfiz_organRejestrowy_Symbol, proc_lokfiz_organRejestrowy_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM register_types WHERE rodzajRejestru_Symbol = proc_lokfiz_rodzajRejestru_Symbol)
            AND proc_lokfiz_rodzajRejestru_Symbol IS NOT NULL THEN
            INSERT INTO register_types (rodzajRejestru_Symbol, rodzajRejestru_Nazwa) VALUES
            (proc_lokfiz_rodzajRejestru_Symbol, proc_lokfiz_rodzajRejestru_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = proc_lokfiz_formaFinansowania_Symbol) AND proc_lokfiz_formaFinansowania_Symbol IS NOT NULL THEN
            INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES (proc_lokfiz_formaFinansowania_Symbol, proc_lokfiz_formaFinansowania_Nazwa);
        end if;
        CALL insert_addresses(proc_lokfiz_siedzGmina_Symbol, proc_lokfiz_siedzGmina_Nazwa,
            proc_lokfiz_siedzMiejscowosc_Symbol, proc_lokfiz_siedzMiejscowosc_Nazwa,
            proc_lokfiz_siedzMiejscowoscPoczty_Symbol, proc_lokfiz_siedzPoczty_Nazwa,
            proc_lokfiz_siedzUlica_Symbol, proc_lokfizUlica_Nazwa);
        IF NOT EXISTS(SELECT * FROM silos WHERE silosid = proc_lokfiz_silosID) AND proc_lokfiz_silosID IS NOT NULL THEN
            INSERT INTO silos (silosid, silos_nazwa) VALUES (proc_lokfiz_silosID, proc_lokfiz_SilosNazwa);
        end if;
        INSERT INTO common_LF (lokfiz_regon, lokfiz_parentRegon, lokfiz_nazwa, lokfiz_silosID, lokfiz_dataPowstania, lokfiz_datarozpoczeciadzialalnosci,
                               lokfiz_dataWpisuDoRegon, lokfiz_dataZawieszeniaDzialanosci, lokfiz_dataWznowieniaDzialanosci,
                               lokfiz_dataZaistnieniaZmiany, lokfizdataZakonczeniaDzialanosci, lokfiz_dataSkresleniaZRegon,
                               lofkiz_siedzKraj_Symbol, lokfiz_siedzWojewodztwo_Symbol, lokfiz_siedzPowiat_Symbol,
                               lokfiz_siedzGmina_Symbol, lokfiz_siedzKodPocztowy, lokfiz_siedzMiejscowoscPoczty_Symbol,
                               lokfiz_siedzMiejscowosc_Symbol, lokfiz_siedzUlica_Symbol, lokfiz_siedzNumerNieruchomosci,
                               lokfiz_siedzNumerLokalu, lokfiz_siedzNietypoweMiejsceLokalizacji, lokfiz_formaFinansowania_Symbol,
                               lokfiz_dataWpisuDoRejestruEwidencji, lokfiz_numerWRejestrzeEwidencji, lokfiz_organRejestrowy_Symbol,
                               lokfiz_rodzajRejestru_Symbol, lokfizC_niePodjetoDzialanosci, lokfiz_dataWpisuDoBazyDanych) VALUES
                    (proc_lokfiz_regon, proc_lokfiz_parentRegon, proc_lokfiz_nazwa, proc_lokfiz_silosID, proc_lokfiz_dataPowstania, proc_dataRozpoczeciaDzialalnosci,
                     proc_lokfiz_dataWpisuDoRegon, proc_lokfiz_dataZawieszeniaDzialanosci, proc_lokfiz_dataWznowieniaDzialanosci,
                     proc_lokfiz_dataZaistnieniaZmiany, proc_lokfizdataZakonczeniaDzialanosci, proc_lokfiz_dataSkresleniaZRegon,
                     proc_lofkiz_siedzKraj_Symbol, proc_lokfiz_siedzWojewodztwo_Symbol, proc_lokfiz_siedzPowiat_Symbol, proc_lokfiz_siedzGmina_Symbol,
                     proc_lokfiz_siedzKodPocztowy, proc_lokfiz_siedzMiejscowoscPoczty_Symbol, proc_lokfiz_siedzMiejscowosc_Symbol,
                     proc_lokfiz_siedzUlica_Symbol, proc_lokfiz_siedzNumerNieruchomosci, proc_lokfiz_siedzNumerLokalu, proc_lokfiz_siedzNietypoweMiejsceLokalizacji,
                     proc_lokfiz_formaFinansowania_Symbol, proc_lokfiz_dataWpisuDoRejestruEwidencji, proc_lokfiz_numerWRejestrzeEwidencji,
                     proc_lokfiz_organRejestrowy_Symbol, proc_lokfiz_rodzajRejestru_Symbol, proc_lokfizC_niePodjetoDzialanosci, proc_lokfiz_dataWpisuDoBazyDanych);
        end;
    $$; -- created

CREATE PROCEDURE insert_into_forms_of_financing(symbol varchar(10), nazwa varchar(256))
LANGUAGE plpgsql AS $$
    BEGIN
        INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
        (symbol, nazwa);
    end;
    $$;

CREATE OR REPLACE PROCEDURE insert_into_pkd_F_ownership(proc_pkdF_regon varchar(9), proc_pkdF_kod varchar(10), proc_pkdF_pkdNazwa varchar(256),
proc_pkdF_Przewazajace INT, proc_pkdF_SilosID INT, proc_pkdF_SilosNazwa varchar(30), proc_pkdF_dataSkreslenia DATE) LANGUAGE plpgsql AS $$
    BEGIN
    IF NOT EXISTS(SELECT * FROM pkds p WHERE p.pkd_kod = proc_pkdF_kod) THEN
        INSERT INTO pkds (pkd_kod, pkd_nazwa) VALUES
        (proc_pkdF_kod, proc_pkdF_pkdNazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM silos WHERE silosid = proc_pkdF_SilosID) THEN
        INSERT INTO silos (silosid, silos_nazwa) VALUES
        (proc_pkdF_SilosID, proc_pkdF_SilosNazwa);
    end if;
    INSERT INTO pkd_f_ownership (fiz_pkd_regon, fiz_pkd_kod, fiz_pkd_przewazajace, fiz_pkd_silosid, fiz_pkd_dataskreslenia) VALUES
        (proc_pkdF_regon, proc_pkdF_kod, proc_pkdF_Przewazajace, proc_pkdF_SilosID, proc_pkdF_dataSkreslenia);
end;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_into_pkd_LF_ownership(
proc_pkd_LFRegon varchar(14), proc_pkd_Kod varchar(10), proc_pkd_Nazwa varchar(256),
proc_pkd_Przewazajace INT, proc_pkd_silosNazwa varchar(100)
) LANGUAGE plpgsql AS $$
    BEGIN
       IF NOT EXISTS(SELECT * FROM pkds WHERE pkd_kod = proc_pkd_Kod) THEN
           INSERT INTO pkds (pkd_kod, pkd_nazwa) VALUES
           (proc_pkd_Kod, proc_pkd_Nazwa);
       end if;
       INSERT INTO pkd_lf_ownership (lokfiz_pkd_regon, lokfiz_pkd_kod,
                                     lokfiz_pkd_przewazajace, lokfiz_silos_symbol) VALUES
        (proc_pkd_LFRegon, proc_pkd_Kod, proc_pkd_Przewazajace, proc_pkd_silosNazwa);
    end;
    $$; -- created

CREATE OR REPLACE PROCEDURE insert_into_pkd_LP_ownership(
proc_LP_regon varchar(14), proc_pkd_LP_kod varchar(10), proc_pkd_LP_Nazwa varchar(256),
proc_LP_pkdPrzewazajace INT
)LANGUAGE plpgsql AS $$
    BEGIN
        IF NOT EXISTS(SELECT * FROM pkds WHERE pkd_kod = proc_pkd_LP_kod) THEN
            INSERT INTO pkds (pkd_kod, pkd_nazwa) VALUES
            (proc_pkd_LP_kod, proc_pkd_LP_Nazwa);
        end if;
        INSERT INTO pkd_lp_ownership (lokpraw_pkd_regon, lokpraw_pkdkod, lokpraw_pkdprzewazajace) VALUES
        (proc_LP_regon, proc_pkd_LP_kod, proc_LP_pkdPrzewazajace);
    end;
    $$; -- created

CREATE OR REPLACE PROCEDURE insert_into_pkd_P_ownership(
proc_P_PkdRegon varchar(9), proc_P_pkdKod varchar(10), proc_P_pkdNazwa varchar(256),
proc_P_pkdPrzewazajace INT
) LANGUAGE plpgsql AS $$
    BEGIN
        IF NOT EXISTS(SELECT * FROM pkds WHERE pkd_kod = proc_P_pkdKod) THEN
            INSERT INTO pkds (pkd_kod, pkd_nazwa) VALUES
            (proc_P_pkdKod, proc_P_pkdNazwa);
        end if;
        INSERT INTO pkd_p_ownership (praw_pkd_regon, praw_pkdkod, praw_pkdprzewazajace) VALUES
        (proc_P_PkdRegon, proc_P_pkdKod, proc_P_pkdPrzewazajace);
    END;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_Ceidg(
proc_fiz_regon varchar(9),proc_fiz_nazwa varchar(256),
proc_fiz_nazwaSkrocona varchar(100), proc_fiz_dataPowstania DATE,
proc_fiz_dataRozpoczeciaDzialanosci DATE, proc_fiz_dataWpisuDzialalnosciDoRegon DATE,
proc_fiz_dataZawieszeniaDzialalnosci DATE, proc_fiz_dataWznowieniaDzialalnosci DATE,
proc_fiz_dataZaistnieniaZmiany DATE, proc_fiz_dataZakonczeniaDzialalnosci DATE,
proc_fiz_dataSkresleniaDzialalnosciZRegon DATE, proc_fiz_dataOrzeczeniaOUpadlosci DATE,
proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego DATE, proc_fiz_adSiedzKraj_Symbol varchar(10),
proc_fiz_adSiedzWojewodztwo_Symbol varchar(10), proc_fiz_adSiedzPowiat_Symbol varchar(10),
proc_fiz_adSiedzGmina_Symbol varchar(10), proc_fiz_adSiedzKodPocztowy varchar(7),
proc_fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10), proc_fiz_adSiedzMiejscowosc_Symbol varchar(10),
proc_fiz_adSiedzUlica_Symbol varchar(10),proc_fiz_adSiedzNumerNieruchomosci varchar(10),
proc_fiz_adSiedzNumerLokalu varchar(10), proc_fiz_adSiedzNietypoweMiejsceLokalizacji varchar(100),
proc_fiz_numerTelefonu varchar(10), proc_fiz_numerWewnetrznyTelefonu varchar(10),
proc_fiz_numerFaksu varchar(10), proc_fiz_adresStronyInternetowej varchar(35),
proc_fizC_dataWpisuDoRejestruEwidencji DATE, proc_fizC_dataSkresleniaZRejestruEwidencji DATE,
proc_fizC_numerWRejestrzeEwidencji varchar(20), proc_fizC_OrganRejestrowy_Symbol varchar(10),
proc_fizC_RodzajRejestru_Symbol varchar(10), proc_fizC_NiePodjetoDzialalnosci varchar(15),
proc_fiz_miejscowoscNazwa varchar(256),
proc_fiz_gminaNazwa varchar(256), proc_fiz_siedzPocztyNazwa varchar(256),
proc_fiz_ulicaNazwa varchar(256), proc_fiz_organRejestrowyNazwa varchar(256),
proc_fiz_rodzajRejestruNazwa varchar(256)
)LANGUAGE plpgsql AS $$
    BEGIN
        CALL insert_addresses(proc_fiz_adSiedzGmina_Symbol, proc_fiz_gminaNazwa,
            proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_miejscowoscNazwa,
            proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_siedzPocztyNazwa,
            proc_fiz_adSiedzUlica_Symbol, proc_fiz_ulicaNazwa);
        IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_fizC_OrganRejestrowy_Symbol) AND
           proc_fizC_OrganRejestrowy_Symbol IS NOT NULL THEN
            INSERT INTO registration_authorities (organ_rejestrowy_symbol, organ_rejestrowy_nazwa) VALUES
            (proc_fizC_OrganRejestrowy_Symbol, proc_fiz_organRejestrowyNazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM register_types WHERE rodzajrejestru_symbol = proc_fizC_RodzajRejestru_Symbol) AND
           proc_fizC_RodzajRejestru_Symbol IS NOT NULL THEN
            INSERT INTO register_types (rodzajrejestru_symbol, rodzajrejestru_nazwa) VALUES
            (proc_fizC_RodzajRejestru_Symbol, proc_fiz_rodzajRejestruNazwa);
        end if;
        INSERT INTO fizyczna_dzialalnosc_ceidg_i_pozostala (fiz_regon, fiz_nazwa, fiz_nazwaskrocona,
        fiz_datapowstania, fiz_datarpozpoczeciadzialanosci, fiz_datawpisudzialalnoscidoregon,
        fiz_datazawieszeniadzialalnosci, fiz_datawznowieniadzialalnosci, fiz_datazaistnieniazmiany,
        fiz_datazakonczeniadzialalnosci, fiz_dataskresleniadzialalnoscizregon, fiz_dataorzeczeniaoupadlosci,
        fiz_datazakonczeniapostepowaniaupadlosciowego, fiz_adsiedzkraj_symbol, fiz_adsiedzwojewodztwo_symbol,
        fiz_adsiedzpowiat_symbol, fiz_adsiedzgmina_symbol, fiz_adsiedzkodpocztowy,
        fiz_adsiedzmiejscowoscpoczty_symbol, fiz_adsiedzmiejscowosc_symbol, fiz_adsiedzulica_symbol,
        fiz_adsiedznumernieruchomosci, fiz_adsiedznumerlokalu, fiz_adsiedznietypowemiejscelokalizacji,
        fiz_numertelefonu, fiz_numerwewnetrznytelefonu, fiz_numerfaksu,
        fiz_adresstronyinternetowej, fizc_datawpisudorejestruewidencji, fizc_dataskresleniazrejestruewidencji,
        fizc_numerwrejestrzeewidencji, fizc_organrejestrowy_symbol, fizc_rodzajrejestru_symbol,
        fizc_niepodjetodzialalnosci, fiz_rodzajdzialalnosci) VALUES
        (proc_fiz_regon, proc_fiz_nazwa, proc_fiz_nazwaSkrocona, proc_fiz_dataPowstania,
         proc_fiz_dataRozpoczeciaDzialanosci, proc_fiz_dataWpisuDzialalnosciDoRegon,
         proc_fiz_dataZawieszeniaDzialalnosci, proc_fiz_dataWznowieniaDzialalnosci,
         proc_fiz_dataZaistnieniaZmiany,proc_fiz_dataZakonczeniaDzialalnosci, proc_fiz_dataSkresleniaDzialalnosciZRegon,
         proc_fiz_dataOrzeczeniaOUpadlosci, proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego,
         proc_fiz_adSiedzKraj_Symbol, proc_fiz_adSiedzWojewodztwo_Symbol, proc_fiz_adSiedzPowiat_Symbol,
         proc_fiz_adSiedzGmina_Symbol, proc_fiz_adSiedzKodPocztowy, proc_fiz_adSiedzMiejscowoscPoczty_Symbol,
         proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_adSiedzUlica_Symbol, proc_fiz_adSiedzNumerNieruchomosci,
         proc_fiz_adSiedzNumerLokalu, proc_fiz_adSiedzNietypoweMiejsceLokalizacji, proc_fiz_numerTelefonu,
         proc_fiz_numerWewnetrznyTelefonu, proc_fiz_numerFaksu, proc_fiz_adresStronyInternetowej,
         proc_fizC_dataWpisuDoRejestruEwidencji, proc_fizC_dataSkresleniaZRejestruEwidencji,
         proc_fizC_numerWRejestrzeEwidencji, proc_fizC_OrganRejestrowy_Symbol, proc_fizC_RodzajRejestru_Symbol,
         proc_fizC_NiePodjetoDzialalnosci, 'Ceidg');
    end;
$$; -- created
CREATE OR REPLACE PROCEDURE insert_Pozostale(
proc_fiz_regon varchar(9),proc_fiz_nazwa varchar(256),
proc_fiz_nazwaSkrocona varchar(100), proc_fiz_dataPowstania DATE,
proc_fiz_dataRozpoczeciaDzialanosci DATE, proc_fiz_dataWpisuDzialalnosciDoRegon DATE,
proc_fiz_dataZawieszeniaDzialalnosci DATE, proc_fiz_dataWznowieniaDzialalnosci DATE,
proc_fiz_dataZaistnieniaZmiany DATE, proc_fiz_dataZakonczeniaDzialalnosci DATE,
proc_fiz_dataSkresleniaDzialalnosciZRegon DATE, proc_fiz_dataOrzeczeniaOUpadlosci DATE,
proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego DATE, proc_fiz_adSiedzKraj_Symbol varchar(10),
proc_fiz_adSiedzWojewodztwo_Symbol varchar(10), proc_fiz_adSiedzPowiat_Symbol varchar(10),
proc_fiz_adSiedzGmina_Symbol varchar(10), proc_fiz_adSiedzKodPocztowy varchar(7),
proc_fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10), proc_fiz_adSiedzMiejscowosc_Symbol varchar(10),
proc_fiz_adSiedzUlica_Symbol varchar(10),proc_fiz_adSiedzNumerNieruchomosci varchar(10),
proc_fiz_adSiedzNumerLokalu varchar(10), proc_fiz_adSiedzNietypoweMiejsceLokalizacji varchar(100),
proc_fiz_numerTelefonu varchar(10), proc_fiz_numerWewnetrznyTelefonu varchar(10),
proc_fiz_numerFaksu varchar(10), proc_fiz_adresStronyInternetowej varchar(35),
proc_fizC_dataWpisuDoRejestruEwidencji DATE, proc_fiz_dataSkresleniaZRejestruEwidencji DATE,
proc_fizC_numerWRejestrzeEwidencji DATE, proc_fizC_OrganRejestrowy_Symbol varchar(10),
proc_fizC_RodzajRejestru_Symbol varchar(10), proc_fiz_niePodjetoDzialalnosci varchar(10), proc_fiz_miejscowoscNazwa varchar(256),
proc_fiz_gminaNazwa varchar(256), proc_fiz_siedzPocztyNazwa varchar(256),
proc_fiz_ulicaNazwa varchar(256), proc_fiz_organRejestrowyNazwa varchar(256),
proc_fiz_rodzajRejestruNazwa varchar(256)
)LANGUAGE plpgsql AS $$
    BEGIN
        CALL insert_addresses(proc_fiz_adSiedzGmina_Symbol, proc_fiz_gminaNazwa,
            proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_miejscowoscNazwa,
            proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_siedzPocztyNazwa,
            proc_fiz_adSiedzUlica_Symbol, proc_fiz_ulicaNazwa);
        IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_fizC_OrganRejestrowy_Symbol) AND
           proc_fizC_OrganRejestrowy_Symbol IS NOT NULL THEN
            INSERT INTO registration_authorities (organ_rejestrowy_symbol, organ_rejestrowy_nazwa) VALUES
            (proc_fizC_OrganRejestrowy_Symbol, proc_fiz_organRejestrowyNazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM register_types WHERE rodzajrejestru_symbol = proc_fizC_RodzajRejestru_Symbol) AND
           proc_fizC_RodzajRejestru_Symbol IS NOT NULL THEN
            INSERT INTO register_types (rodzajrejestru_symbol, rodzajrejestru_nazwa) VALUES
            (proc_fizC_RodzajRejestru_Symbol, proc_fiz_rodzajRejestruNazwa);
        end if;
        INSERT INTO fizyczna_dzialalnosc_ceidg_i_pozostala (fiz_regon, fiz_nazwa, fiz_nazwaskrocona,
        fiz_datapowstania, fiz_datarpozpoczeciadzialanosci, fiz_datawpisudzialalnoscidoregon,
        fiz_datazawieszeniadzialalnosci, fiz_datawznowieniadzialalnosci, fiz_datazaistnieniazmiany,
        fiz_datazakonczeniadzialalnosci, fiz_dataskresleniadzialalnoscizregon, fiz_dataorzeczeniaoupadlosci,
        fiz_datazakonczeniapostepowaniaupadlosciowego, fiz_adsiedzkraj_symbol, fiz_adsiedzwojewodztwo_symbol,
        fiz_adsiedzpowiat_symbol, fiz_adsiedzgmina_symbol, fiz_adsiedzkodpocztowy,
        fiz_adsiedzmiejscowoscpoczty_symbol, fiz_adsiedzmiejscowosc_symbol, fiz_adsiedzulica_symbol,
        fiz_adsiedznumernieruchomosci, fiz_adsiedznumerlokalu, fiz_adsiedznietypowemiejscelokalizacji,
        fiz_numertelefonu, fiz_numerwewnetrznytelefonu, fiz_numerfaksu,
        fiz_adresstronyinternetowej, fizc_datawpisudorejestruewidencji, fizc_dataskresleniazrejestruewidencji,
        fizc_numerwrejestrzeewidencji, fizc_organrejestrowy_symbol, fizc_rodzajrejestru_symbol,
        fizc_niepodjetodzialalnosci, fiz_rodzajdzialalnosci) VALUES
        (proc_fiz_regon, proc_fiz_nazwa, proc_fiz_nazwaSkrocona, proc_fiz_dataPowstania,
         proc_fiz_dataRozpoczeciaDzialanosci, proc_fiz_dataWpisuDzialalnosciDoRegon,
         proc_fiz_dataZawieszeniaDzialalnosci, proc_fiz_dataWznowieniaDzialalnosci,
         proc_fiz_dataZaistnieniaZmiany,proc_fiz_dataZakonczeniaDzialalnosci, proc_fiz_dataSkresleniaDzialalnosciZRegon,
         proc_fiz_dataOrzeczeniaOUpadlosci, proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego,
         proc_fiz_adSiedzKraj_Symbol, proc_fiz_adSiedzWojewodztwo_Symbol, proc_fiz_adSiedzPowiat_Symbol,
         proc_fiz_adSiedzGmina_Symbol, proc_fiz_adSiedzKodPocztowy, proc_fiz_adSiedzMiejscowoscPoczty_Symbol,
         proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_adSiedzUlica_Symbol, proc_fiz_adSiedzNumerNieruchomosci,
         proc_fiz_adSiedzNumerLokalu, proc_fiz_adSiedzNietypoweMiejsceLokalizacji, proc_fiz_numerTelefonu,
         proc_fiz_numerWewnetrznyTelefonu, proc_fiz_numerFaksu, proc_fiz_adresStronyInternetowej,
         proc_fizC_dataWpisuDoRejestruEwidencji, NULL,
         proc_fizC_numerWRejestrzeEwidencji, proc_fizC_OrganRejestrowy_Symbol, proc_fizC_RodzajRejestru_Symbol,
         NULL, 'Pozostała');
    end;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_rolnicza(
proc_fiz_regon varchar(9), proc_fiz_nazwa varchar(256), proc_fiz_nazwa_skrocona varchar(100),
proc_fiz_dataPowstania DATE, proc_fiz_dataRozpoczeciaDzialalnosci DATE, proc_fiz_dataWpisuDzialalnosciDoRegon DATE,
proc_fiz_dataZawieszeniaDzialalnosci DATE, proc_fiz_dataWznowieniaDzialalnosci DATE,
proc_fiz_dataZaistnieniaZmianyDzialalnosci DATE, proc_fiz_dataZakonczeniaDzialalnosci DATE,
proc_fiz_dataSkresleniaDzialalanosciZRegon DATE, proc_fiz_dataOrzeczeniaOUpadlosci DATE,
proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego DATE, proc_fiz_adSiedzKraj_Symbol varchar(10),
proc_fiz_adSiedzWojewodztwo_Symbol varchar(10), proc_fiz_adSiedzPowiat_Symbol varchar(10),
proc_fiz_adSiedzGmina_Symbol varchar(10), proc_fiz_adSiedzKodPocztowy varchar(6),
proc_fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10), proc_fiz_adSiedzMiejscowosc_Symbol varchar(10),
proc_fiz_adSiedzUlica_Symbol varchar(10), proc_fiz_adSiedzNumerNieruchomosci varchar(10),
proc_fiz_adSiedzNumerLokalu varchar(10), proc_fiz_adSiedzNietypoweMiejsceLokalizacji varchar(256),
proc_fiz_numerTelefonu varchar(10), proc_fiz_numerWewnetrznyTelefonu varchar(10),
proc_fiz_numerFaksu varchar(10), proc_fiz_adresEmail varchar(20),
proc_fiz_adresStronyinternetowej varchar(20), proc_fiz_gminaNazwa varchar(256),
proc_fiz_miejscowoscNazwa varchar(256), proc_fiz_miejscowoscPocztyNazwa varchar(256),
proc_fiz_ulicaNazwa varchar(256)
)LANGUAGE plpgsql AS $$
    BEGIN
        CALL insert_addresses(proc_fiz_adSiedzGmina_Symbol, proc_fiz_gminaNazwa,
            proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_miejscowoscNazwa,
            proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_miejscowoscPocztyNazwa,
            proc_fiz_adSiedzUlica_Symbol, proc_fiz_ulicaNazwa);
    INSERT INTO fizycznadzialalnoscrolnicza (fiz_regon, fiz_nazwa, fiz_nazwa_skrocona, fiz_datapowstania,
                                             fiz_datarozpoczeciadzialalnosci, fiz_datawpisudzialalnoscidoregon,
                                             fiz_datazawieszeniadzialalnosci, fiz_datawznowieniadzialalnosci,
                                             fiz_datazaistnieniazmianydzialalnosci, fiz_datazakonczeniadzialalnosci,
                                             fiz_dataskresleniadzialalanoscizregon, fiz_dataorzeczeniaoupadlosci,
                                             fiz_datazakonczeniapostepowaniaupadlosciowego, fiz_adsiedzkraj_symbol,
                                             fiz_adsiedzwojewodztwo_symbol, fiz_adsiedzpowiat_symbol,
                                             fiz_adsiedzgmina_symbol, fiz_adsiedzkodpocztowy, fiz_adsiedzmiejscowoscpoczty_symbol,
                                             fiz_adsiedzmiejscowosc_symbol, fiz_adsiedzulica_symbol, fiz_adsiedznumernieruchomosci,
                                             fiz_adsiedznumerlokalu, fiz_adsiedznietypowemiejscelokalizacji, fiz_numertelefonu,
                                             fiz_numerwewnetrznytelefonu, fiz_numerfaksu, fiz_adresemail, fiz_adresstronyinternetowej) VALUES
        (proc_fiz_regon, proc_fiz_nazwa, proc_fiz_nazwa_skrocona, proc_fiz_dataPowstania, proc_fiz_dataRozpoczeciaDzialalnosci,
         proc_fiz_dataWpisuDzialalnosciDoRegon, proc_fiz_dataZawieszeniaDzialalnosci, proc_fiz_dataWznowieniaDzialalnosci,
         proc_fiz_dataZaistnieniaZmianyDzialalnosci, proc_fiz_dataZakonczeniaDzialalnosci, proc_fiz_dataSkresleniaDzialalanosciZRegon,
         proc_fiz_dataOrzeczeniaOUpadlosci, proc_fiz_dataZakonczeniaPostepowaniaUpadlosciowego, proc_fiz_adSiedzKraj_Symbol,
         proc_fiz_adSiedzWojewodztwo_Symbol, proc_fiz_adSiedzPowiat_Symbol, proc_fiz_adSiedzGmina_Symbol, proc_fiz_adSiedzKodPocztowy,
         proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_adSiedzUlica_Symbol,
         proc_fiz_adSiedzNumerNieruchomosci, proc_fiz_adSiedzNumerLokalu, proc_fiz_adSiedzNietypoweMiejsceLokalizacji,
         proc_fiz_numerTelefonu, proc_fiz_numerWewnetrznyTelefonu, proc_fiz_numerFaksu, proc_fiz_adresEmail, proc_fiz_adresStronyinternetowej);
        end;
$$; -- created

CREATE OR REPLACE PROCEDURE insert_Skreslone(
    proc_fiz_regon varchar(9),
    proc_fiz_nazwa varchar(256),
    proc_fiz_nazwaSkrocona varchar(100),
    proc_fiz_dataPowstania DATE,
    proc_fiz_dataRozpoczeciaDzialalnosci DATE,
    proc_fiz_dataWpisuDzialalnosciDoRegon DATE,
    proc_fiz_dataZawieszeniaDzialalnosci DATE,
    proc_fiz_dataWznowieniaDzialalnosci DATE,
    proc_fiz_dataZaistnieniaZmianyDzialalnosci DATE,
    proc_fiz_dataZakonczeniaDzialalnosci DATE,
    proc_fiz_dataSkresleniaDzialalnosciZRegon DATE,
    proc_fiz_adSiedzKraj_Symbol varchar(10),
    proc_fiz_adSiedzWojewodztwo_Symbol varchar(10),
    proc_fiz_adSiedzPowiat_Symbol varchar(10),
    proc_fiz_adSiedzGmina_Symbol varchar(10), proc_fiz_gminaNazwa varchar(256),
    proc_fiz_adSiedzKodPocztowy varchar(6),
    proc_fiz_adSiedzMiejscowoscPoczty_Symbol varchar(10), proc_fiz_miejscowoscPocztyNazwa varchar(256),
    proc_fiz_adSiedzMiejscowosc_Symbol varchar(10), proc_fiz_miejscowoscNazwa varchar(256),
    proc_fiz_adSiedzUlica_Symbol varchar(10), proc_fiz_ulicaNazwa varchar(256),
    proc_fiz_adSiedzNumerNieruchomosci varchar(10),
    proc_fiz_adSiedzNumerLokalu varchar(10),
    proc_fiz_adSiedzNietypoweMiejsceLokalizacji varchar(256),
    proc_fiz_numerTelefonu varchar(10),
    proc_fiz_numerWewnetrznyTelefonu varchar(10),
    proc_fiz_numerFaksu varchar(10),
    proc_fiz_adresEmail varchar(20),
    proc_fiz_adresStronyinternetowej varchar(20),
    proc_fiz_adresEmail2 varchar(20)
)LANGUAGE plpgsql AS $$
    BEGIN
        CALL insert_addresses(proc_fiz_adSiedzGmina_Symbol, proc_fiz_gminaNazwa,
            proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_miejscowoscNazwa,
            proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_miejscowoscPocztyNazwa,
            proc_fiz_adSiedzUlica_Symbol, proc_fiz_ulicaNazwa);

        INSERT INTO fizyczne_sreslone (fiz_regon, fiz_nazwa, fiz_nazwaskrocona,
                                       fiz_datapowstania, fiz_datarozpoczeciadzialalnosci,
                                       fiz_datawpisudzialalnoscidoregon, fiz_datazawieszeniadzialalnosci,
                                       fiz_datawznowieniadzialalnosci, fiz_datazaistnieniazmianydzialalnosci,
                                       fiz_datazakonczeniadzialalnosci, fiz_dataskresleniadzialalnoscizregon,
                                       fiz_adsiedzkraj_symbol, fiz_adsiedzwojewodztwo_symbol, fiz_adsiedzpowiat_symbol,
                                       fiz_adsiedzgmina_symbol, fiz_adsiedzkodpocztowy, fiz_adsiedzmiejscowoscpoczty_symbol,
                                       fiz_adsiedzmiejscowosc_symbol, fiz_adsiedzulica_symbol, fiz_adsiedznumernieruchomosci,
                                       fiz_adsiedznumerlokalu, fiz_adsiedznietypowemiejscelokalizacji, fiz_numertelefonu,
                                       fiz_numerwewnetrznytelefonu, fiz_numerfaksu, fiz_adresemail, fiz_adresstronyinternetowej, fiz_adresEmail2) VALUES
        (proc_fiz_regon, proc_fiz_nazwa, proc_fiz_nazwaSkrocona, proc_fiz_dataPowstania, proc_fiz_dataRozpoczeciaDzialalnosci,
         proc_fiz_dataWpisuDzialalnosciDoRegon, proc_fiz_dataZawieszeniaDzialalnosci, proc_fiz_dataWznowieniaDzialalnosci,
         proc_fiz_dataZaistnieniaZmianyDzialalnosci, proc_fiz_dataZakonczeniaDzialalnosci, proc_fiz_dataSkresleniaDzialalnosciZRegon,
         proc_fiz_adSiedzKraj_Symbol, proc_fiz_adSiedzWojewodztwo_Symbol, proc_fiz_adSiedzPowiat_Symbol, proc_fiz_adSiedzGmina_Symbol,
         proc_fiz_adSiedzKodPocztowy, proc_fiz_adSiedzMiejscowoscPoczty_Symbol, proc_fiz_adSiedzMiejscowosc_Symbol, proc_fiz_adSiedzUlica_Symbol,
         proc_fiz_adSiedzNumerNieruchomosci, proc_fiz_adSiedzNumerLokalu, proc_fiz_adSiedzNietypoweMiejsceLokalizacji, proc_fiz_numerTelefonu,
         proc_fiz_numerWewnetrznyTelefonu, proc_fiz_numerFaksu, proc_fiz_adresEmail, proc_fiz_adresStronyinternetowej, proc_fiz_adresEmail2);
    end; -- created
$$;

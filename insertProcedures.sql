CREATE OR REPLACE FUNCTION get_parent_regon(long_regon varchar(14)) RETURNS varchar(9) AS $parent_regon$
    declare
        parent_regon varchar(9);
    BEGIN
        SELECT LEFT(long_regon, 9) INTO parent_regon;
        RETURN parent_regon;
    end;
    $parent_regon$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE insert_into_common_P(
    regon varchar(9), proc_nip varchar(10) DEFAULT NULL, proc_statusNip varchar(10) DEFAULT NULL, proc_nazwa varchar(256) DEFAULT NULL,
    proc_nazwaSkrocona varchar(100) DEFAULT NULL, proc_numerWRejestrzeEwidencji varchar(15) DEFAULT NULL, proc_dataWpisuDoRejestruEwidencji DATE DEFAULT NULL,
    proc_dataPowstamia DATE DEFAULT NULL, proc_dataRozpoczeciaDzialanosci DATE DEFAULT NULL, proc_dataWpisuDoRegon DATE DEFAULT NULL,
    proc_dataZawieszeniaDzialanosci DATE DEFAULT NULL, proc_dataWznowieniaDzialanosci DATE DEFAULT NULL, proc_dataZaistnieniaZmiany DATE DEFAULT NULL,
    proc_dataZakonczeniaDzialanosci DATE DEFAULT NULL, proc_dataSkresleniaZRegon DATE DEFAULT NULL, proc_dataOrzeczeniaOUpadlosci DATE DEFAULT NULL,
    proc_dataZakonczeniaPostepowaniaUpadlosciowego DATE DEFAULT NULL, proc_siedzibaKraj_Symbol varchar(10) DEFAULT NULL, proc_siedzWojewodztwo_Symbol varchar(10) DEFAULT NULL,
    proc_siedzPowiat_Symbol varchar(10) DEFAULT NULL, proc_siedzGminaSymbol varchar(10) DEFAULT NULL, proc_siedzGminaNazwa varchar(256) DEFAULT NULL,
    proc_siedzKodPocztowy varchar(7) DEFAULT NULL, proc_siedzMiejscowoscPoczty_Symbol varchar(10) DEFAULT NULL, proc_siedzMiejscowosc_Symbol varchar(10) DEFAULT NULL,
    proc_siedzUlicaSymbol varchar(10) DEFAULT NULL, proc_siedzUlicaNazwa varchar(256),proc_siedzNumerNieruchomosci varchar(15) DEFAULT NULL,
    proc_siedzNumerLokalu varchar(15) DEFAULT NULL, proc_siedzNietypoweMiejsceLokalizacji varchar(100) DEFAULT NULL,
    proc_numerTelefonu varchar(13) DEFAULT NULL, proc_numerWewnetrznyTelefoonu varchar(15) DEFAULT NULL,
    proc_numerFaksu varchar(20) DEFAULT NULL, proc_adresStronyInternetowej varchar(100) DEFAULT NULL,
    proc_podstawowaFormaPrawna_Symbol varchar(10) DEFAULT NULL, proc_podstawowa_forma_prawna_nazwa varchar(256) DEFAULT NULL,
    proc_szczegolnaFormaPrawna_Symbol varchar(10) DEFAULT NULL, szczegolnaFormaPrawna_nazwa varchar(256) DEFAULT NULL,
    proc_formaFinansowania_Symbol varchar(10) DEFAULT NULL, formaFinansowania_nazwa varchar(256) DEFAULT NULL,
    proc_formaWlasnosci_Symbol varchar(10) DEFAULT NULL, praw_formaWlasnosci_nazwa varchar(256) DEFAULT NULL,
    proc_organZalozycielski varchar(10) DEFAULT NULL, organZalozycielski_nazwa varchar(256) DEFAULT NULL,
    proc_organRejestrowy_Symbol varchar(10) DEFAULT NULL, organRejestrowy_nazwa varchar(256) DEFAULT NULL,
    proc_rodzajRejestruEwidencji_SYmbol varchar(10) DEFAULT NULL, rodzajRejestruEwidencji_nazwa varchar(256) DEFAULT NULL,
    proc_liczbaJednostekLokalnych INT DEFAULT NULL, proc_dataWpisuDoBazyDanych DATE DEFAULT NULL
)LANGUAGE plpgsql
 as $$
begin
    IF NOT EXISTS(SELECT * FROM municipalities WHERE siedz_gmina_symbol = proc_siedzGminaSymbol) AND proc_siedzGminaSymbol IS NOT NULL THEN
        INSERT INTO municipalities (siedz_gmina_symbol, siedz_gmina_nazwa) VALUES
        (proc_siedzGminaSymbol, proc_siedzGminaNazwa);
    end if;

    IF NOT EXISTS(SELECT * FROM streets WHERE siedz_ulica_symbol = proc_siedzUlicaSymbol) AND proc_siedzUlicaSymbol IS NOT NULL THEN
        INSERT INTO streets (siedz_ulica_symbol, siedz_ulica_nazwa) VALUES (proc_siedzUlicaSymbol, proc_siedzUlicaNazwa);
    end if;

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
        INSERT INTO founding_bodies (ogran_zalozycielski_symbol, organ_zalozycielski_nazwa) VALUES (proc_organRejestrowy_Symbol, organZalozycielski_nazwa);
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
    $$;

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
            AND fproc_podstawowaFormaPrawna_Symbol IS NOT NULL THEN
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
    $$;


CREATE OR REPLACE PROCEDURE insert_into_common_LP(proc_lokpraw_regon varchar(14), --proc_lokpraw_parentRegon varchar(9),
    proc_lokpraw_nazwa varchar(256), proc_lokpraw_numerWRejestrzeEwiddencji varchar(10), proc_lokpraw_dataWpisuDoRejestruEwidencji DATE,
    proc_lokpraw_dataPowstania DATE, proc_lokpraw_dataRozpoczeciaDzialalnosci DATE, proc_lokpraw_dataWpisuDoRegon DATE,
    proc_lokpraw_dataZawieszeniaDzialanosci DATE, proc_lokpraw_dataWznowieniaDzialanosci DATE, proc_lokpraw_dataZaistnieniaZmiany DATE,
    proc_lokpraw_dataZakonczeniaDzialanosci DATE, proc_lokpraw_dataSkresleniaZRegon DATE, proc_lokpraw_siedzKraj_Symbol varchar(10),
    proc_lokpraw_siedzWojewodztwo_Symbol varchar(10), proc_lokpraw_siedzPowiat_Symbol varchar(10), proc_lokpraw_siedzGmina_Symbol varchar(10),
    proc_lokpraw_siedzGmina_Nazwa varchar(256), proc_lokpraw_siedzMiejscowoscPoczty_Symbol varchar(10), proc_lokpraw_siedzMiejscowosc_Symbol varchar(10),
    proc_lokpraw_siedzMiejscowosc_Nazwa varchar(256), proc_lokpraw_siedzUlica_Symbol varchar(10), proc_lokpraw_siedzUlica_Nazwa varchar(256),
    proc_lokpraw_siedzKodPocztowy varchar(7), proc_lokpraw_siedzNumerNieruchomosci varchar(10), proc_lokpraw_siedzNumerLokalu varchar(10),
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
       IF NOT EXISTS(SELECT * FROM streets WHERE siedz_ulica_symbol = proc_lokpraw_siedzUlica_Symbol) AND proc_lokpraw_siedzUlica_Symbol IS NOT NULL THEN
           INSERT INTO streets (siedz_ulica_symbol, siedz_ulica_nazwa) VALUES (proc_lokpraw_siedzUlica_Symbol, proc_lokpraw_siedzUlica_Nazwa);
       end if;
       IF NOT EXISTS(SELECT * FROM municipalities WHERE siedz_gmina_symbol = proc_lokpraw_siedzGmina_Symbol) AND proc_lokpraw_siedzGmina_Symbol IS NOT NULL THEN
           INSERT INTO municipalities (siedz_gmina_symbol, siedz_gmina_nazwa) VALUES (proc_lokpraw_siedzGmina_Symbol, proc_lokpraw_siedzGmina_Nazwa);
       end if;
       IF NOT EXISTS(SELECT * FROM towns WHERE siedz_miejscowosc_symbol = proc_lokpraw_siedzMiejscowosc_Symbol) AND proc_lokpraw_siedzMiejscowosc_Symbol IS NOT NULL THEN
           INSERT INTO towns (siedz_miejscowosc_symbol, siedz_miejscowosc_nazwa) VALUES (proc_lokpraw_siedzMiejscowosc_Symbol, proc_lokpraw_siedzMiejscowosc_Nazwa);
       end if;
       IF NOT EXISTS(SELECT * FROM posts WHERE siedz_miejscowosc_poczty_symbol = proc_lokpraw_siedzMiejscowoscPoczty_Symbol) AND
          proc_lokpraw_siedzMiejscowoscPoczty_Symbol IS NOT NULL THEN
           INSERT INTO posts (siedz_miejscowosc_poczty_symbol, siedz_miejscowosc_poczty_nazwa) VALUES
           (proc_lokpraw_siedzMiejscowoscPoczty_Symbol, proc_lokpraw_siedzMiejscowosc_Nazwa);
       end if;
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
$$;


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
        IF NOT EXISTS(SELECT * FROM streets WHERE siedz_ulica_symbol = proc_lokfiz_siedzUlica_Symbol) AND proc_lokfiz_siedzUlica_Symbol IS NOT NULL THEN
            INSERT INTO streets (siedz_ulica_symbol, siedz_ulica_nazwa) VALUES
            (proc_lokfiz_siedzUlica_Symbol, proc_lokfizUlica_Nazwa);
        end if;
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
        IF NOT EXISTS(SELECT * FROM municipalities WHERE siedz_gmina_symbol = proc_lokfiz_siedzGmina_Symbol) AND proc_lokfiz_siedzGmina_Symbol IS NOT NULL THEN
            INSERT INTO municipalities (siedz_gmina_symbol, siedz_gmina_nazwa) VALUES
            (proc_lokfiz_siedzGmina_Symbol, proc_lokfiz_siedzGmina_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM towns WHERE siedz_miejscowosc_symbol = proc_lokfiz_siedzMiejscowosc_Symbol) AND proc_lokfiz_siedzMiejscowosc_Symbol IS NOT NULL THEN
            INSERT INTO towns (siedz_miejscowosc_symbol, siedz_miejscowosc_nazwa) VALUES
            (proc_lokfiz_siedzMiejscowosc_Symbol, proc_lokfiz_siedzMiejscowosc_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM posts WHERE siedz_miejscowosc_poczty_symbol = proc_lokfiz_siedzMiejscowoscPoczty_Symbol) AND proc_lokfiz_siedzMiejscowoscPoczty_Symbol IS NOT NULL THEN
            INSERT INTO posts (siedz_miejscowosc_poczty_symbol, siedz_miejscowosc_poczty_nazwa) VALUES
            (proc_lokfiz_siedzMiejscowoscPoczty_Symbol, proc_lokfiz_siedzPoczty_Nazwa);
        end if;
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
    $$;

CREATE PROCEDURE insert_into_forms_of_financing(symbol varchar(10), nazwa varchar(256))
LANGUAGE plpgsql AS $$
    BEGIN
        INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
        (symbol, nazwa);
    end;
    $$;

CREATE OR REPLACE PROCEDURE insert_into_pkd_F_ownership(proc_pkdF_regon varchar(9), proc_pkdF_kod varchar(10), proc_pkdF_pkdNazwa varchar(256),
proc_pkdF_Przewazajace INT, proc_pkdF_SilosID INT) LANGUAGE plpgsql AS $$
    BEGIN
    IF NOT EXISTS(SELECT * FROM pkds WHERE pkd_kod = proc_pkdF_kod) THEN
        INSERT INTO pkds (pkd_kod, pkd_nazwa) VALUES
        (proc_pkdF_kod, proc_pkdF_pkdNazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM silos WHERE silosid = proc_pkdF_SilosID) THEN
        INSERT INTO silos (silosid, silos_nazwa) VALUES
        (proc_pkdF_SilosID, proc_pkdF_pkdNazwa);
    end if;
    INSERT INTO pkd_f_ownership (fiz_pkd_regon, fiz_pkd_kod, fiz_pkd_przewazajace, fiz_pkd_silosid) VALUES
        (proc_pkdF_regon, proc_pkdF_kod, proc_pkdF_Przewazajace, proc_pkdF_SilosID);
end;
$$;
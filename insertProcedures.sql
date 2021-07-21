CREATE OR REPLACE PROCEDURE insert_into_common_P(
    regon varchar(9), proc_nip varchar(10), proc_statusNip varchar(10), proc_nazwa varchar(256),
    proc_nazwaSkrocona varchar(100), proc_numerWRejestrzeEwidencji varchar(15), proc_dataWpisuDoRejestruEwidencji DATE,
    proc_dataPowstamia DATE, proc_dataRozpoczeciaDzialanosci DATE, proc_dataWpisuDoRegon DATE,
    proc_dataZawieszeniaDzialanosci DATE, proc_dataWznowieniaDzialanosci DATE, proc_dataZaistnieniaZmiany DATE,
    proc_dataZakonczeniaDzialanosci DATE, proc_dataSkresleniaZRegon DATE, proc_dataOrzeczeniaOUpadlosci DATE,
    proc_dataZakonczeniaPostepowaniaUpadlosciowego DATE, proc_siedzibaKraj_Symbol varchar(10), proc_siedzWojewodztwo_Symbol varchar(10),
    proc_siedzPowiat_Symbol varchar(10), proc_siedzGminaSymbol varchar(10), proc_siedzKodPocztowy varchar(7),
    proc_siedzMiejscowoscPoczty_Symbol varchar(10), proc_siedzMiejscowosc_Symbol varchar(10),
    proc_siedzUlicaSymbol varchar(10), proc_siedzNumerNieruchomosci varchar(15),
    proc_siedzNumerLokalu varchar(15), proc_siedzNietypoweMiejsceLokalizacji varchar(100),
    proc_numerTelefonu varchar(13), proc_numerWewnetrznyTelefoonu varchar(15),
    proc_numerFaksu varchar(20), proc_adresStronyInternetowej varchar(100) ,
    proc_podstawowaFormaPrawna_Symbol varchar(10), proc_podstawowa_forma_prawna_nazwa varchar(256),
    proc_szczegolnaFormaPrawna_Symbol varchar(10), szczegolnaFormaPrawna_nazwa varchar(256),
    proc_formaFinansowania_Symbol varchar(10), formaFinansowania_nazwa varchar(256),
    proc_formaWlasnosci_Symbol varchar(10), praw_formaWlasnosci_nazwa varchar(256),
    proc_organZalozycielski varchar(10), organZalozycielski_nazwa varchar(256),
    proc_organRejestrowy_Symbol varchar(10), organRejestrowy_nazwa varchar(256),
    proc_rodzajRejestruEwidencji_SYmbol varchar(10), rodzajRejestruEwidencji_nazwa varchar(256),
    proc_liczbaJednostekLokalnych INT, proc_dataWpisuDoBazyDanych DATE
) as $$
begin
    if not exists(SELECT * FROM basic_legal_form where podstawowa_forma_prawna_symbol = proc_podstawowaFormaPrawna_Symbol) THEN
        INSERT INTO basic_legal_form (podstawowa_forma_prawna_symbol, podstawowa_forma_prawna_nazwa) VALUES (proc_podstawowaFormaPrawna_Symbol, proc_podstawowa_forma_prawna_nazwa);

    end if;
    if not exists(SELECT * FROM specific_legal_form WHERE szczegolna_forma_prawna_symbol = proc_szczegolnaFormaPrawna_Symbol) THEN
        INSERT INTO specific_legal_form (szczegolna_forma_prawna_symbol, szeczgolna_forma_prawna_nazwa) VALUES
        (proc_szczegolnaFormaPrawna_Symbol, szczegolnaFormaPrawna_nazwa);
    end if;
    if not exists(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = proc_formaFinansowania_Symbol) THEN
        INSERT INTO forms_of_financing(forma_finansowania_symbol, forma_finansowania_nazwa) VALUES (proc_formaFinansowania_Symbol, formaFinansowania_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM founding_bodies WHERE ogran_zalozycielski_symbol = proc_organZalozycielski) THEN
        INSERT INTO founding_bodies (ogran_zalozycielski_symbol, organ_zalozycielski_nazwa) VALUES (proc_organRejestrowy_Symbol, organZalozycielski_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM forms_of_ownership WHERE forma_wlasnosci_symbol = proc_formaWlasnosci_Symbol) THEN
        INSERT INTO forms_of_ownership (forma_wlasnosci_symbol, forma_wlasnosci_nazwa) VALUES (proc_formaWlasnosci_Symbol, praw_formaWlasnosci_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM type_of_register_of_records WHERE rodzaj_rejestru_ewidencji_symbol = proc_rodzajRejestruEwidencji_SYmbol) THEN
        INSERT INTO type_of_register_of_records (rodzaj_rejestru_ewidencji_symbol, rodzaj_rejestru_ewidencji_nazwa) VALUES
        (proc_rodzajRejestruEwidencji_SYmbol, rodzajRejestruEwidencji_nazwa);
    end if;
    IF NOT EXISTS(SELECT * FROM registration_authorities WHERE organ_rejestrowy_symbol = proc_organRejestrowy_Symbol) THEN
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

end;$$;

CREATE OR REPLACE PROCEDURE insert_into_common_F(
fproc_regon varchar(9), fproc_nip varchar(10), fproc_statusNIP varchar(10), fproc_nazwisko varchar(100), fproc_imie1 varchar(100), fproc_imie2 varchar(10),
fproc_dataWpisuDoRegon DATE, fproc_dataZaistnieniaZmiany DATE, fproc_dataSkresleniaPodmiotuZRegon DATE, fproc_podstawowaFormaPrawna_Symbol varchar(10),
fproc_podstawowaFormaPrawna_Nazwa varchar(100), fproc_szczegolnaFormaPrawna_Symbol varchar(10), fproc_szczegolnaFormaPrawna_Nazwa varchar(100),
fproc_formaFinansowania_Symbol varchar(10), fproc_formaFinansowania_Nazwa varchar(100), fproc_formaFinansowania_Nazwa varchar(100),
fproc_formaWlasnosci_Symbol varchar(10), fproc_formaWlasnosci_Nazwa varchar(100), fproc_dzialanoscCEIDG INT, fproc_dzialanoscRolnicza INT,
fproc_dzialalnoscPozostala INT, fproc_dzialalnoscSkreslona INT, fproc_liczbaJednostekLokalnych INT, fproc_dataWpisuDoBazyDanych DATE
) as $$
    begin
        IF NOT EXISTS(SELECT * FROM basic_legal_form WHERE podstawowa_forma_prawna_symbol = fproc_podstawowaFormaPrawna_Symbol) THEN
            INSERT INTO basic_legal_form (podstawowa_forma_prawna_symbol, podstawowa_forma_prawna_nazwa) VALUES
            (fproc_podstawowaFormaPrawna_Symbol, fproc_podstawowaFormaPrawna_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM specific_legal_form WHERE szczegolna_forma_prawna_symbol = fproc_szczegolnaFormaPrawna_Symbol) THEN
            INSERT INTO specific_legal_form (szczegolna_forma_prawna_symbol, szeczgolna_forma_prawna_nazwa) VALUES
            (fproc_szczegolnaFormaPrawna_Symbol, fproc_szczegolnaFormaPrawna_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM forms_of_financing WHERE forma_finansowania_symbol = fproc_formaFinansowania_Symbol) THEN
            INSERT INTO forms_of_financing (forma_finansowania_symbol, forma_finansowania_nazwa) VALUES
            (fproc_formaFinansowania_Symbol, fproc_formaFinansowania_Nazwa);
        end if;
        IF NOT EXISTS(SELECT * FROM forms_of_ownership WHERE forma_wlasnosci_symbol = fproc_formaWlasnosci_Symbol) THEN
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



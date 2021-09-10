DROP VIEW F_CDEIG_rest_view;
CREATE OR REPLACE VIEW F_CDEIG_rest_view AS -- joined common f with cdeig and rest with pkd (and states, counties etc.)
    SELECT cmf.f_id, cmf.fiz_regon, cmf.fiz_nip, cmf.fiz_statusnip,
           cmf.fiz_nazwisko, cmf.fiz_imie1, cmf.fiz_imie2, cmf.fiz_datawpisupodmiotudoregon, cmf.fiz_datazaistnieniazmiany,
           cmf.fiz_dataskresleniapodmiotuzregon, blf.podstawowa_forma_prawna_nazwa, slf.szeczgolna_forma_prawna_nazwa,
           fof.forma_finansowania_nazwa, forms_of_ownership.forma_wlasnosci_nazwa, CASE WHEN
              cmf.fiz_dzialanoscceidg = 1 THEN 'Cdeig' WHEN cmf.fiz_dzialnoscrolnicza = 2 THEN 'Rolnicza' WHEN cmf.fiz_dzialanoscpozostala = 3 THEN 'Inna' WHEN cmf.fiz_dzialanoscskreslonado20141108 = 4 THEN 'Skreślona'
                  END rodzajDzialalnosci, cmf.fiz_liczbajednlokalnych, cmf.fiz_datawpisudobazydanych, cd.fiz_nazwa AS cdeig_rest_nazwa, cd.fiz_nazwaskrocona AS cdeig_rest_skrocona_nazwa,
           cd.fiz_datapowstania AS cdeig_rest_dataPowstania, cd.fiz_datarpozpoczeciadzialanosci AS cdeig_rest_dataRozpoczeciaDzialalnosci,
           cd.fiz_datawpisudzialalnoscidoregon, cd.fiz_datazawieszeniadzialalnosci, cd.fiz_datawznowieniadzialalnosci, cd.fiz_datazaistnieniazmiany AS cdeig_rest_dataZaistnieniaZmiany,
           cd.fiz_datazakonczeniadzialalnosci, cd.fiz_dataskresleniadzialalnoscizregon, cd.fiz_dataorzeczeniaoupadlosci, cd.fiz_datazakonczeniapostepowaniaupadlosciowego, st.siedz_wojewodztwa_nazwa, c.siedz_powiat_nazwa,
           m.siedz_gmina_nazwa, cd.fiz_adsiedzkodpocztowy, p.siedz_miejscowosc_poczty_nazwa, t.siedz_miejscowosc_nazwa, s.siedz_ulica_nazwa, cd.fiz_adsiedznumernieruchomosci, cd.fiz_adsiedznumerlokalu, cd.fiz_adsiedznietypowemiejscelokalizacji,
           cd.fiz_numertelefonu, cd.fiz_numerwewnetrznytelefonu, cd.fiz_numerfaksu, cd.fiz_adresstronyinternetowej, cd.fizc_datawpisudorejestruewidencji, cd.fizc_dataskresleniazrejestruewidencji, cd.fizc_numerwrejestrzeewidencji,
           ra.organ_rejestrowy_nazwa, CASE
               WHEN cd.fizc_niepodjetodzialalnosci = 'false' THEN false END niePodjetoDzialalnosci, pkdf.fiz_pkd_kod, p2.pkd_nazwa
           FROM common_f cmf JOIN fizyczna_dzialalnosc_ceidg_i_pozostala cd on cmf.fiz_regon = cd.fiz_regon JOIN states st ON cd.fiz_adsiedzwojewodztwo_symbol = st.siedz_wojewodztwa_symbol JOIN
               counties c on cd.fiz_adsiedzpowiat_symbol = c.siedz_powiat_symbol JOIN municipalities m on cd.fiz_adsiedzgmina_symbol = m.siedz_gmina_symbol JOIN
               posts p on cd.fiz_adsiedzmiejscowoscpoczty_symbol = p.siedz_miejscowosc_poczty_symbol JOIN towns t on cd.fiz_adsiedzmiejscowosc_symbol = t.siedz_miejscowosc_symbol JOIN
               streets s on cd.fiz_adsiedzulica_symbol = s.siedz_ulica_symbol JOIN registration_authorities ra on cd.fizc_organrejestrowy_symbol = ra.organ_rejestrowy_symbol JOIN register_types rt ON rt.rodzajrejestru_symbol = cd.fizc_rodzajrejestru_symbol JOIN
               basic_legal_form blf on cmf.fiz_podstawowaformaprawna_symbol = blf.podstawowa_forma_prawna_symbol JOIN specific_legal_form slf on cmf.fiz_szczegolnaformaprawna_symbol = slf.szczegolna_forma_prawna_symbol JOIN
               forms_of_financing fof ON fof.forma_finansowania_symbol = cmf.fiz_formafinansowania_symbol JOIN forms_of_ownership ON cmf.fiz_formawlasnosci_symbol = forms_of_ownership.forma_wlasnosci_symbol JOIN
               pkd_f_ownership pkdf ON pkdf.fiz_pkd_regon = cmf.fiz_regon JOIN pkds p2 on pkdf.fiz_pkd_kod = p2.pkd_kod;


CREATE OR REPLACE VIEW F_agriculture_view AS -- joined common f with f_agriculture, pkd, states, counties etc.
    SELECT cmf.f_id, cmf.fiz_regon, cmf.fiz_nip, cmf.fiz_statusnip,
        cmf.fiz_nazwisko, cmf.fiz_imie1, cmf.fiz_imie2, cmf.fiz_datawpisupodmiotudoregon, cmf.fiz_datazaistnieniazmiany,
        cmf.fiz_dataskresleniapodmiotuzregon, blf.podstawowa_forma_prawna_nazwa, slf.szeczgolna_forma_prawna_nazwa,
        fof.forma_finansowania_nazwa, foo.forma_wlasnosci_nazwa, s.silos_nazwa,
        cmf.fiz_liczbajednlokalnych, cmf.fiz_datawpisudobazydanych, f.fiz_nazwa, f.fiz_nazwa_skrocona,
        f.fiz_datapowstania, f.fiz_datarozpoczeciadzialalnosci, f.fiz_datawpisudzialalnoscidoregon, f.fiz_datazawieszeniadzialalnosci, f.fiz_datawznowieniadzialalnosci,
        f.fiz_datazaistnieniazmianydzialalnosci, f.fiz_datazakonczeniadzialalnosci, f.fiz_dataskresleniadzialalanoscizregon, f.fiz_dataorzeczeniaoupadlosci,
        f.fiz_datazakonczeniapostepowaniaupadlosciowego, c.siedz_kraj_nazwa, st.siedz_wojewodztwa_nazwa, c2.siedz_powiat_nazwa, m.siedz_gmina_nazwa, f.fiz_adsiedzkodpocztowy,
        p.siedz_miejscowosc_poczty_nazwa, t.siedz_miejscowosc_nazwa, s2.siedz_ulica_nazwa, f.fiz_adsiedznumernieruchomosci, f.fiz_adsiedznumerlokalu,
        f.fiz_adsiedznietypowemiejscelokalizacji, f.fiz_numertelefonu, f.fiz_numerwewnetrznytelefonu, f.fiz_numerfaksu, f.fiz_adresemail, f.fiz_adresstronyinternetowej, pkds.pkd_nazwa,
        CASE WHEN pkdF.fiz_pkd_przewazajace = 1 THEN True WHEN pkdF.fiz_pkd_przewazajace = 0 THEN False END pkd_przewazajace
        FROM common_f cmf JOIN
        fizycznadzialalnoscrolnicza f on cmf.fiz_regon = f.fiz_regon JOIN silos s on cmf.fiz_dzialanoscceidg = s.silosid JOIN countries c on f.fiz_adsiedzkraj_symbol = c.siedz_kraj_symbol
        JOIN states st ON st.siedz_wojewodztwa_symbol = f.fiz_adsiedzwojewodztwo_symbol JOIN counties c2 on f.fiz_adsiedzpowiat_symbol = c2.siedz_powiat_symbol
        JOIN municipalities m on f.fiz_adsiedzgmina_symbol = m.siedz_gmina_symbol JOIN posts p ON f.fiz_adsiedzmiejscowoscpoczty_symbol = p.siedz_miejscowosc_poczty_symbol
        JOIN towns t on f.fiz_adsiedzmiejscowosc_symbol = t.siedz_miejscowosc_symbol JOIN streets s2 on f.fiz_adsiedzulica_symbol = s2.siedz_ulica_symbol
        LEFT OUTER JOIN basic_legal_form blf on cmf.fiz_podstawowaformaprawna_symbol = blf.podstawowa_forma_prawna_symbol LEFT OUTER JOIN specific_legal_form slf on cmf.fiz_szczegolnaformaprawna_symbol = slf.szczegolna_forma_prawna_symbol
        LEFT OUTER JOIN forms_of_financing fof on cmf.fiz_formafinansowania_symbol = fof.forma_finansowania_symbol LEFT OUTER JOIN forms_of_ownership foo on cmf.fiz_formawlasnosci_symbol = foo.forma_wlasnosci_symbol
        JOIN pkd_f_ownership pkdF ON cmf.fiz_regon = pkdF.fiz_pkd_regon JOIN pkds ON pkdF.fiz_pkd_kod = pkds.pkd_kod;

CREATE OR REPLACE VIEW F_deleted_View AS
    SELECT cmf.f_id, cmf.fiz_regon, cmf.fiz_nip, cmf.fiz_statusnip,
        cmf.fiz_nazwisko, cmf.fiz_imie1, cmf.fiz_imie2, cmf.fiz_datawpisupodmiotudoregon, cmf.fiz_datazaistnieniazmiany,
        cmf.fiz_dataskresleniapodmiotuzregon, blf.podstawowa_forma_prawna_nazwa, slf.szeczgolna_forma_prawna_nazwa,
        fof.forma_finansowania_nazwa, foo.forma_wlasnosci_nazwa, s2.silos_nazwa, cmf.fiz_liczbajednlokalnych, cmf.fiz_datawpisudobazydanych,
        fs.fiz_nazwa, fs.fiz_nazwaskrocona, fs.fiz_datapowstania, fs.fiz_datarozpoczeciadzialalnosci,
        fs.fiz_datawpisudzialalnoscidoregon, fs.fiz_datazawieszeniadzialalnosci, fs.fiz_datawznowieniadzialalnosci, fs.fiz_datazaistnieniazmianydzialalnosci,
        fs.fiz_datazakonczeniadzialalnosci, fs.fiz_dataskresleniadzialalnoscizregon, c.siedz_kraj_nazwa, st.siedz_wojewodztwa_nazwa,
        c2.siedz_powiat_nazwa, m.siedz_gmina_nazwa, fs.fiz_adsiedzkodpocztowy, p.siedz_miejscowosc_poczty_nazwa, s.siedz_ulica_nazwa,
        fs.fiz_adsiedznumernieruchomosci, fs.fiz_adsiedznumerlokalu, fs.fiz_adsiedznietypowemiejscelokalizacji, fs.fiz_numertelefonu, fs.fiz_numerwewnetrznytelefonu,
        fs.fiz_numerfaksu, fs.fiz_adresstronyinternetowej, fs.fiz_adresemail2, pkds.pkd_nazwa, CASE WHEN pkdF.fiz_pkd_przewazajace = 1 THEN True
        WHEN pkdF.fiz_pkd_przewazajace = 0 THEN FALSE END pkd_przewazajace
        FROM common_f cmf JOIN fizyczne_sreslone fs ON cmf.fiz_regon = fs.fiz_regon JOIN countries c on fs.fiz_adsiedzkraj_symbol = c.siedz_kraj_symbol
        JOIN states st ON st.siedz_wojewodztwa_symbol = fs.fiz_adsiedzwojewodztwo_symbol JOIN counties c2 on fs.fiz_adsiedzpowiat_symbol = c2.siedz_powiat_symbol
        JOIN municipalities m on fs.fiz_adsiedzgmina_symbol = m.siedz_gmina_symbol JOIN posts p on fs.fiz_adsiedzmiejscowoscpoczty_symbol = p.siedz_miejscowosc_poczty_symbol
        JOIN streets s on fs.fiz_adsiedzulica_symbol = s.siedz_ulica_symbol LEFT OUTER JOIN basic_legal_form blf on cmf.fiz_podstawowaformaprawna_symbol = blf.podstawowa_forma_prawna_symbol
        LEFT OUTER JOIN specific_legal_form slf on cmf.fiz_szczegolnaformaprawna_symbol = slf.szczegolna_forma_prawna_symbol LEFT OUTER JOIN forms_of_financing fof on cmf.fiz_formafinansowania_symbol = fof.forma_finansowania_symbol
        LEFT OUTER JOIN forms_of_ownership foo on cmf.fiz_formawlasnosci_symbol = foo.forma_wlasnosci_symbol JOIN silos s2 on cmf.fiz_dzialanoscceidg = s2.silosid
        JOIN pkd_f_ownership pkdF ON pkdF.fiz_pkd_regon  = fs.fiz_regon JOIN pkds on pkdF.fiz_pkd_kod = pkds.pkd_kod;

CREATE OR REPLACE VIEW common_P_view AS
    SELECT praw_regon, praw_nip, praw_statusnip, praw_nazwa, praw_nazwaskrocona, praw_numerwrejestrzeewidencji, praw_datawpisudorejestruewidencji,
           praw_datapowstamia, praw_datarozpoczeciadzialanosci, praw_datawpisudoregon, praw_datazawieszeniadzialanosci, praw_datazaistnieniazmiany,
           praw_datazakonczeniadzialanosci, praw_dataskresleniazregon, praw_dataorzeczeniaoupadlosci, praw_datazakonczeniapostepowaniaupadlosciowego,
           c.siedz_kraj_nazwa, c2.siedz_powiat_nazwa, m.siedz_gmina_nazwa, praw_siedzkodpocztowy, p.siedz_miejscowosc_poczty_nazwa, t.siedz_miejscowosc_nazwa,
           s.siedz_ulica_nazwa, praw_siedznumernieruchomosci, praw_siedznumerlokalu, praw_siedznietypowemiejscelokalizacji, praw_numertelefonu, praw_numerwewnetrznytelefoonu,
           praw_numerfaksu, praw_adresstronyinternetowej, blf.podstawowa_forma_prawna_nazwa, slf.szeczgolna_forma_prawna_nazwa, fof.forma_finansowania_nazwa, foo.forma_wlasnosci_nazwa,
           fb.organ_zalozycielski_nazwa, ra.organ_rejestrowy_nazwa, toror.rodzaj_rejestru_ewidencji_nazwa, praw_liczbajednosteklokalnych, praw_datawpisudobazydanych,
           p2.pkd_nazwa, CASE WHEN pkdP.praw_pkdprzewazajace = 1 THEN True WHEN pkdP.praw_pkdprzewazajace = 0 THEN FALSE END pkd_przewazajace
    FROM common_p cp JOIN countries c on cp.praw_siedzibakraj_symbol = c.siedz_kraj_symbol JOIN counties c2 on cp.praw_siedzpowiat_symbol = c2.siedz_powiat_symbol
    JOIN municipalities m on cp.praw_siedzgminasymbol = m.siedz_gmina_symbol JOIN posts p on cp.praw_siedzmiejscowoscpoczty_symbol = p.siedz_miejscowosc_poczty_symbol
    JOIN towns t on cp.praw_siedzmiejscowosc_symbol = t.siedz_miejscowosc_symbol  JOIN streets s on cp.praw_siedzulicasymbol = s.siedz_ulica_symbol
    LEFT OUTER JOIN basic_legal_form blf on cp.praw_podstawowaformaprawna_symbol = blf.podstawowa_forma_prawna_symbol LEFT OUTER JOIN specific_legal_form slf on cp.praw_szczegolnaformaprawna_symbol = slf.szczegolna_forma_prawna_symbol
    LEFT OUTER JOIN forms_of_financing fof on cp.praw_formafinansowania_symbol = fof.forma_finansowania_symbol LEFT OUTER JOIN forms_of_ownership foo on cp.praw_formawlasnosci_symbol = foo.forma_wlasnosci_symbol
    LEFT OUTER JOIN founding_bodies fb on cp.praw_organzalozycielski = fb.ogran_zalozycielski_symbol LEFT OUTER JOIN registration_authorities ra on cp.praw_organrejestrowy_symbol = ra.organ_rejestrowy_symbol
    LEFT OUTER JOIN type_of_register_of_records toror on cp.praw_rodzajrejestruewidencji_symbol = toror.rodzaj_rejestru_ewidencji_symbol LEFT OUTER JOIN pkd_p_ownership pkdP ON pkdP.praw_pkd_regon = cp.praw_regon
    JOIN pkds p2 on pkdP.praw_pkdkod = p2.pkd_kod;

CREATE OR REPLACE VIEW local_P_view AS -- common lp with pkds joined
    SELECT lokpraw_regon, lokpraw_parentregon, lokpraw_nazwa, lokpraw_numerwrejestrzeewiddencji, lokpraw_datawpisudorejestruewidencji,
           lokpraw_datapowstania, lokpraw_datarozpoczeciadzialalnosci, lokpraw_datawpisudoregon, lokpraw_datazawieszeniadzialanosci, lokpraw_datawznowieniadzialanosci,
           lokpraw_datazaistnieniazmiany, lokpraw_datazakonczeniadzialanosci, lokpraw_dataskresleniazregon, c.siedz_kraj_nazwa, s.siedz_wojewodztwa_nazwa,
           c2.siedz_powiat_nazwa, m.siedz_gmina_nazwa, p.siedz_miejscowosc_poczty_nazwa, t.siedz_miejscowosc_nazwa, s2.siedz_ulica_nazwa, lokpraw_siedzkodpocztowy,
           lokpraw_siedznumernieruchomosci, lokpraw_siedznumerlokalu, lokpraw_siedznietypowemiejscelokalizacji, fof.forma_finansowania_nazwa, ra.organ_rejestrowy_nazwa,
           toror.rodzaj_rejestru_ewidencji_nazwa, lokpraw_datawpisudobazydanych, p2.pkd_nazwa, CASE WHEN pkdLP.lokpraw_pkdprzewazajace = 1 THEN
           TRUE WHEN pkdLP.lokpraw_pkdprzewazajace  = 0 THEN FALSE END pkd_przewazajace
        FROM common_lp JOIN countries c on common_lp.lokpraw_siedzkraj_symbol = c.siedz_kraj_symbol JOIN states s on common_lp.lokpraw_siedzwojewodztwo_symbol = s.siedz_wojewodztwa_symbol
        JOIN counties c2 on common_lp.lokpraw_siedzpowiat_symbol = c2.siedz_powiat_symbol JOIN municipalities m on common_lp.lokpraw_siedzgmina_symbol = m.siedz_gmina_symbol
        JOIN posts p ON p.siedz_miejscowosc_poczty_symbol = lokpraw_siedzmiejscowoscpoczty_symbol JOIN towns t on common_lp.lokpraw_siedzmiejscowosc_symbol = t.siedz_miejscowosc_symbol
        JOIN streets s2 on common_lp.lokpraw_siedzulica_symbol = s2.siedz_ulica_symbol LEFT OUTER JOIN forms_of_financing fof on common_lp.lokpraw_formafinansowania_symbol = fof.forma_finansowania_symbol
        LEFT OUTER JOIN registration_authorities ra on common_lp.lokpraw_organrejestrowy_symbol = ra.organ_rejestrowy_symbol LEFT OUTER JOIN type_of_register_of_records toror on common_lp.lokpraw_rodzajrejestruewidencji_symbol = toror.rodzaj_rejestru_ewidencji_symbol
        JOIN pkd_lp_ownership pkdLP ON pkdLP.lokpraw_pkd_regon = lokpraw_regon JOIN pkds p2 on pkdLP.lokpraw_pkdkod = p2.pkd_kod;

--TODO create common_lf joined with pkds view fix common_f deleted


SELECT * FROM fizyczna_dzialalnosc_ceidg_i_pozostala;
SELECT count(*) FROM fizycznadzialalnoscrolnicza;
SELECT count(*) FROM common_p;
SELECT * FROM pkd_f_ownership;
SELECT * FROM fizyczne_sreslone;
SELECT * FROM pkd_p_ownership;
SELECT count(*) FROM common_P_view;
SELECT count(*) FROM common_p JOIN pkd_p_ownership ON common_p.praw_regon = pkd_p_ownership.praw_pkd_regon;
SELECT common_P.* FROM common_p LEFT OUTER JOIN common_P_view ON common_P_view.praw_regon = common_p.praw_regon WHERE common_P_view.praw_regon IS NULL;
SELECT * FROM common_lp;
SELECT * FROM F_CDEIG_rest_view WHERE rodzajDzialalnosci != 'Cdeig';


DROP VIEW F_CDEIG_rest_view;
CREATE OR REPLACE VIEW F_CDEIG_rest_view AS
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

CREATE OR REPLACE VIEW F_agriculture_view AS
    SELECT * FROM fizycznadzialalnoscrolnicza;

SELECT * FROM fizyczna_dzialalnosc_ceidg_i_pozostala;
SELECT * FROM fizycznadzialalnoscrolnicza;

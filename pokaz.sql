CALL insert_into_common_P('022276481'::varchar(9),'8992748325'::varchar(10),NULL,'WSPÓLNOTA MIESZKANIOWA WROCŁAW UL.3-GO MAJA 7'::varchar(256),'WSP.MIESZK,WROCŁAW',NULL,
    '2013-09-04','2013-09-04','2013-09-04',
    '2013-10-30',NULL,NULL,
    '2013-10-30',NULL,NULL,
    NULL,NULL,
    'PL','02','0264','39',
    '52119','0986544','0986544','11937','7',NULL,
    NULL,'601754696',NULL,
    NULL,
    NULL,
    '2','JEDNOSTKA ORGANIZACYJNA NIEMAJĄCA OSOBOWOŚCI PRAWNEJ',
    '085','WSPÓLNOTY MIESZKANIOWE','1',
    'JEDNOSTKA SAMOFINANSUJĄCA NIE BĘDĄCA JEDNOSTKĄ BUDŻETOWĄ LUB SAMORZĄDOWYM ZAKŁADEM BUDŻETOWYM',
    '133','WŁASNOŚĆ MIESZANA MIĘDZY SEKTORAMI Z PRZEWAGĄ WŁASNOŚCI SEKTORA PUBLICZNEGO, W TYM Z PRZEWAGĄ WŁASNOŚCI JEDNOSTEK SAMORZĄDU TERYTORIALNEGO LUB SAMORZĄDOWYCH OSÓB PRAWNYCH',
    NULL,NULL,NULL,NULL,'000',
    'PODMIOTY UTWORZONE Z MOCY USTAWY',
    0);
INSERT INTO municipalities (siedz_gmina_symbol, siedz_gmina_nazwa) VALUES ('039', 'Wrocław-Krzyki');
INSERT INTO posts (siedz_miejscowosc_poczty_symbol, siedz_miejscowosc_poczty_nazwa) VALUES
            ('0986544', 'Wrocław');
INSERT INTO towns (siedz_miejscowosc_symbol, siedz_miejscowosc_nazwa) VALUES
('0986544', 'Wrocław');
INSERT INTO streets (siedz_ulica_symbol, siedz_ulica_nazwa) VALUES
('11937', 'ul. 3 Maja');

CALL insert_into_forms_of_financing('2' ,NULL);
SELECT * FROM counties WHERE siedz_powiat_nazwa = 'Wrocław';
SELECT * FROM municipalities;

SELECT * FROM common_p;
SELECT * FROM forms_of_financing;
SELECT * FROM specific_legal_form;
INSERT INTO common_p (praw_regon, praw_szczegolnaformaprawna_symbol) VALUES ('123456789', '085');
SELECT praw_regon, slf.szeczgolna_forma_prawna_nazwa FROM common_p JOIN specific_legal_form slf on common_p.praw_szczegolnaformaprawna_symbol = slf.szczegolna_forma_prawna_symbol

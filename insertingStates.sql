INSERT INTO states VALUES ('02', 'DOLNOŚLĄSKIE'), ('04', 'KUJAWSKO-POMORSKIE'), ('06', 'LUBELSKIE'), ('08', 'LUBUSKIE'),
                          ('10', 'ŁÓDZKIE'), ('12', 'MAŁOPOLSKIE'), ('14', 'MAZOWIECKIE'), ('16', 'OPOLSKIE'), ('18', 'PODKARPACKIE'),
                          ('20', 'PODLASKIE'), ('22', 'POMORSKIE'), ('24', 'ŚLĄSKIE'), ('26', 'ŚWIĘTOKRZYSKIE'), ('28', 'WARMIŃSKO-MAZURSKIE'),
                          ('30', 'WIELKOPOLSKIE'), ('32', 'ZACHODNIOPOMORSKIE');
SELECT * FROM states;
INSERT INTO countries VALUES ('PL', 'Polska');
SELECT * FROM counties WHERE siedz_powiat_symbol = '0663';
CALL insert_into_common_F('430629067','7121042892',NULL,
    'DZIĘCIOŁ','TOMASZ','WALDEMAR',NULL,
    '2016-11-09',NULL,
    '9','OSOBA FIZYCZNA PROWADZĄCA DZIAŁALNOŚĆ GOSPODARCZĄ',
    '099', 'OSOBY FIZYCZNE PROWADZĄCE DZIAŁALNOŚĆ GOSPODARCZĄ',
    '1', 'JEDNOSTKA SAMOFINANSUJĄCA NIE BĘDĄCA JEDNOSTKĄ BUDŻETOWĄ LUB SAMORZĄDOWYM ZAKŁADEM BUDŻETOWYM',
    '214','WŁASNOŚĆ KRAJOWYCH OSÓB FIZYCZNYCH',1,1,
    0,0,1, '2021-01-08');
SELECT * FROM common_f;
CALL insert_into_common_f('432676289','7122355475',NULL,
'KURYŚ','KATARZYNA','JADWIGA','2020-06-29',
'2020-05-20',NULL,'9', 'OSOBA FIZYCZNA PROWADZĄCA DZIAŁALNOŚĆ GOSPODARCZĄ',
'099','OSOBY FIZYCZNE PROWADZĄCE DZIAŁALNOŚĆ GOSPODARCZĄ',
'1', 'JEDNOSTKA SAMOFINANSUJĄCA NIE BĘDĄCA JEDNOSTKĄ BUDŻETOWĄ LUB SAMORZĄDOWYM ZAKŁADEM BUDŻETOWYM',
'214',
'WŁASNOŚĆ KRAJOWYCH OSÓB FIZYCZNYCH',1,1,
0,0,0, '2021-01-08');
SELECT * FROM basic_legal_form;
SELECT * FROM forms_of_financing;
DELETE FROM forms_of_financing WHERE forma_finansowania_nazwa IS NULL;
SELECT F.fiz_nazwisko AS Nazwisko, F.fiz_imie1 AS "Pierwsze Imie", Fi.forma_finansowania_nazwa AS finansowanie FROM common_f F JOIN forms_of_financing Fi
    ON F.fiz_formafinansowania_symbol = Fi.forma_finansowania_symbol;

CALL insert_into_common_f('432741420', '7122097079', NULL,
    'SOLECKI', 'MATEUSZ', NULL, '2009-08-04',
    NULL, NULL, '9',
    'OSOBA FIZYCZNA PROWADZĄCA DZIAŁALNOŚĆ GOSPODARCZĄ', '099',
    'OSOBY FIZYCZNE PROWADZĄCE DZIAŁALNOŚĆ GOSPODARCZĄ', NULL, NULL,
    '214', 'WŁASNOŚĆ KRAJOWYCH OSÓB FIZYCZNYCH', 0, 0,
    0, 0, 2, '2021-01-08');

CALL insert_into_common_LF('43274142000068','SOLECKI MATEUSZ MS BIKE',
    1,'CEIDG', '2016-09-02', '2016-09-01', '2016-09-02', NULL, NULL, '2016-12-19',NULL,NULL,
    'PL', '06','0663',
    '011', 'Lublin', '20814',
    '0954700', 'Lublin', '0954700', 'Lublin',
    '50827', 'al.generała Władysława Sikorskiego','1','lok. 5',NULL,
'0', 'JEDNOSTKA LOKALNA NIE BILANSUJĄCA SAMODZIELNIE',NULL,NULL,NULL,NULL,'099', 'PODMIOTY NIE PODLEGAJĄCE WPISOM DO REJESTRU LUB EWIDENCJI','false', '2021-01-08');
SELECT LF.lokfiz_nazwa, F.fiz_imie1, F.fiz_nazwisko FROM common_lf LF JOIN common_F F on F.fiz_regon = LF.lokfiz_parentregon);

CALL insert_into_common_LP('43112929500030','MAX S.C. JADWIGA SMYK, MAREK SMYK',NULL,NULL,
'2004-04-14','2004-04-14',NULL,NULL,NULL,
    '2016-12-19',NULL,NULL,'PL','06','0663',
    '011','Lublin','0954700','0954700','Lublin','50827',
    'al. generała Władysława Sikorskiego','20814', '3',NULL,NULL,'0',
    'JEDNOSTKA LOKALNA NIE BILANSUJĄCA SAMODZIELNIE',NULL,NULL,'099',
'PODMIOTY NIE PODLEGAJĄCE WPISOM DO REJESTRU LUB EWIDENCJI', '2021-01-08');
SELECT * FROM common_lp;

CALL insert_into_pkd_f_ownership('432741420', '4791Z', 'SPRZEDAŻ DETALICZNA PROWADZONA PRZEZ DOMY SPRZEDAŻY WYSYŁKOWEJ LUB INTERNET',
    1, 1);
CALL insert_into_pkd_f_ownership('432741420', '9609Z', 'POZOSTAŁA DZIAŁALNOŚĆ USŁUGOWA, GDZIE INDZIEJ NIESKLASYFIKOWANA',
    0, 1);
SELECT * FROM pkd_f_ownership;
SELECT F.fiz_imie1, F.fiz_nazwisko, pkds.pkd_nazwa, CASE
WHEN pkdF.fiz_pkd_przewazajace = 0 THEN 'Nie przeważa'
WHEN pkdF.fiz_pkd_przewazajace = 1 THEN 'Przeważające'
END Przewazajace
FROM common_f F JOIN pkd_f_ownership pkdF ON
    F.fiz_regon = pkdF.fiz_pkd_regon JOIN pkds ON pkdF.fiz_pkd_kod = pkds.pkd_kod;

SELECT F.fiz_imie1, F.fiz_nazwisko, LF.lokfiz_parentregon, LF.lokfiz_regon, LF.lokfiz_nazwa, rt.rodzajrejestru_nazwa  FROM common_f F JOIN
    common_lf LF ON LF.lokfiz_parentregon = F.fiz_regon JOIN register_types rt on LF.lokfiz_rodzajrejestru_symbol = rt.rodzajrejestru_symbol;
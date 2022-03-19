------------ PROJEKT NA ZALICZENIE -----------
---------- PATRYCJA BATOR ----------

CREATE DATABASE MIESZKANIOWKA 

---------- DODAWANIE TABEL ----------
----------
CREATE TABLE GlownyKontrahent
(
IDGlownyKontrahent int primary key identity (000001,1)
, Imie nvarchar(20) not null
, Nazwisko nvarchar (20) not null
, Pesel char (11) unique 
, NrKomorkowy char(9) null
)
----------
CREATE TABLE LokalMieszkalny
(
IDLokal int primary key identity (000001,1)
, Ulica nvarchar(60) not null
, NrBudynku nvarchar (5) not null
, NrLokalu nvarchar (5) null
, KodPocztowy nvarchar(6) not null
, Miasto nvarchar(30)
, Województwo nvarchar(15) default ('slaskie')
)
----------
CREATE TABLE UzytkowanieLokalu
(
IDUzytkowanieLokalu int primary key identity (000001,1)
, IDGlownyKontrahent int not null foreign key references GlownyKontrahent(IDGlownyKontrahent) check (IDGlownyKontrahent>0)
, IDLokal int not null foreign key references LokalMieszkalny(IDLokal) check (IDLokal>0)
, TypUzytkowania nvarchar(50) default ('umownie')
, Dokument nvarchar(30) null
, DataDokumentu date null
, DataZamieszkaniaOd smalldatetime not null
, DataZamieszkaniaDo smalldatetime null
)
----------
CREATE TABLE WspolKontrahent
(
IDWspolKontrahent int primary key identity (000001,1)
, Imie nvarchar(20) not null
, Nazwisko nvarchar (20) not null
, Pesel char (11) unique 
, NrKomorkowy char(9) null
, StopienPokrewienstwa nvarchar(30) null
, IDUzytkowanieLokalu int not null foreign key references UzytkowanieLokalu(IDUzytkowanieLokalu) check (IDUzytkowanieLokalu>0)
)
----------
CREATE TABLE Faktury
(
IDFaktury int primary key identity (000001,1)
, IDUzytkowanieLokalu int not null foreign key references UzytkowanieLokalu(IDUzytkowanieLokalu) check (IDUzytkowanieLokalu>0)
, NrFaktury char(16) not null unique
, DataFaktury smalldatetime not null
, TerminZaplaty smalldatetime not null
, WartoscFaktury smallmoney check (WartoscFaktury>0.00)
)
----------
CREATE TABLE SadRejonowy
(IDSadRejonowy int primary key identity (000001,1)
, Nazwa varchar(60)
, Adres nvarchar(60) not null
, KodPocztowy nvarchar(6) not null
, Miasto nvarchar(30)
, Województwo nvarchar(15) default ('slaskie')
, NIP char(13) not null unique 
, NrTelefonu nvarchar(10) null
, email ntext NULL
)
----------
CREATE TABLE NakazZaplaty
(
IDNakazZaplaty int primary key identity (000001,1)
, Sygnatura varchar(20) not null
, IDSadRejonowy int not null foreign key references SadRejonowy (IDSadRejonowy) check (IDSadRejonowy>0)
, DataNakazu smalldatetime not null
, NaleznoscGlowna smallmoney not null check (NaleznoscGlowna>0.00)
, Odsetki bit not null default ('1')
, KosztyPostepowania smallmoney not null check (KosztyPostepowania>0.00)
)
----------
CREATE TABLE KlauzulaWykonalnosci
(
IDKlauzula int primary key identity (000001,1)
, IDNakazZaplaty int not null foreign key references NakazZaplaty (IDNakazZaplaty) check (IDNakazZaplaty>0)
, DataKlauzuli smalldatetime not null
)
----------
CREATE TABLE Komornik
(
IDKomornik int primary key identity (000001,1)
, Imie nvarchar(20) not null
, Nazwisko nvarchar (20) not null
, Nazwa nvarchar(50) not null
, IDSadRejonowy int not null foreign key references SadRejonowy (IDSadRejonowy) check (IDSadRejonowy>0)
, Adres nvarchar(60) not null
, KodPocztowy nvarchar(6) not null
, Miasto nvarchar(30)
, Województwo nvarchar(15) default ('slaskie')
, NIP char(13) not null unique 
, NrTelefonu nvarchar(10) null
, email ntext NULL
)

CREATE TABLE EgzekucjaKomornicza
(
IDEgzekucja int primary key identity (000001,1)
, IDKlauzula int not null foreign key references KlauzulaWykonalnosci (IDKlauzula) check (IDKlauzula>0)
, IDKomornik int not null foreign key references Komornik (IDKomornik) check (IDKomornik>0)
, SygnaturaKomornicza varchar(20) not null
, DataEgzekucji smalldatetime not null
, DataUmorzenia smalldatetime null
)

CREATE TABLE FakturyZasadzone
(
IDFakturyZasadzone int primary key identity (000001,1)
, IDFaktury int not null foreign key references Faktury (IDFaktury) check (IDFaktury>0)
, IDNakazZaplaty int not null foreign key references NakazZaplaty (IDNakazZaplaty) check (IDNakazZaplaty>0)
)

-------------- DODAWANIE DANYCH ----------

INSERT INTO GlownyKontrahent
(
[Imie],
[Nazwisko],
[Pesel],
[NrKomorkowy]
)
VALUES ('Slawomir', 'Cielek', '00241514131', '752512694')
INSERT INTO GlownyKontrahent VALUES ('Patrycja', 'Bator', '97121719647', '752512694')
INSERT INTO GlownyKontrahent VALUES ('Sandra', 'Kosno', '45012268161', '651752649')
INSERT INTO GlownyKontrahent VALUES ('Grazyna', 'Nowaczyk', '69011704477', '522785645')
INSERT INTO GlownyKontrahent VALUES ('Janusz', 'Zielinski', '69121313893', '728973860')
INSERT INTO GlownyKontrahent VALUES ('Anna', 'Nowak', '67030421582', '291721911')
INSERT INTO GlownyKontrahent VALUES ('Maria', 'Wójcik', '48070598443', '980511243')
INSERT INTO GlownyKontrahent VALUES ('Katarzyna', 'Szymañska', '60040719986', '511381451')
INSERT INTO GlownyKontrahent VALUES ('Ewa', 'Koz³owska', '70123076187', '511121007')
INSERT INTO GlownyKontrahent VALUES ('Zofia', 'Krawczyk', '51090823426', '511031300')
INSERT INTO GlownyKontrahent VALUES ('Danuta', 'Paw³owska', '50010113542', '511524030')
INSERT INTO GlownyKontrahent VALUES ('Jan', 'Król', '85071758913', '512801219')
INSERT INTO GlownyKontrahent VALUES ('Grzegorz', 'Pawlak', '45072416997', '512753523')
INSERT INTO GlownyKontrahent VALUES ('Zbigniew', 'Górski', '00281346217', '512452955')
INSERT INTO GlownyKontrahent VALUES ('Kazimierz', 'Stêpieñ', '62122237773', Null)
INSERT INTO GlownyKontrahent VALUES ('Wojciech', 'Rutkowski', '65801069419', Null)
INSERT INTO GlownyKontrahent VALUES ('Dawid', 'Michalak', '60110582696', Null)
INSERT INTO GlownyKontrahent VALUES ('Sebastian', 'Sikora', '65012421874', Null)
INSERT INTO GlownyKontrahent VALUES ('Mieczyslaw', 'Ostrowski', '79021417739', '512927061')
INSERT INTO GlownyKontrahent VALUES ('Daniel', 'Zalewski', '98041819275', Null)
----------
INSERT INTO LokalMieszkalny
(
[Ulica],
[NrBudynku],
[NrLokalu],
[KodPocztowy],
[Miasto],
[Województwo]
)
VALUES ('Bytomska', '98', '22', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '100', '2', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '5', '5', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Dworcowa', '30', '1', '44-100', 'Knurów', default)
INSERT INTO LokalMieszkalny VALUES ('Parkowa', '2A2', '4', '44-230', 'Czerwionka-Leszczyny', default)
INSERT INTO LokalMieszkalny VALUES ('Parkowa', '2A2', '4', '44-230', 'Czerwionka-Leszczyny', default)
INSERT INTO LokalMieszkalny VALUES ('Pocztowa', '25', '3', '40-002', 'Katowice', default)
INSERT INTO LokalMieszkalny VALUES ('Pocztowa', '25', '4', '40-002', 'Katowice', default)
INSERT INTO LokalMieszkalny VALUES ('Pocztowa', '25', '5', '40-002', 'Katowice', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '11', '1', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '11', '2', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '11', '3', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '11', '4', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Rybnicka', '11', '5', '44-144', 'Kuznia Nieborowska', default)
INSERT INTO LokalMieszkalny VALUES ('Dworcowa', '30', '3', '44-100', 'Knurów', default)
INSERT INTO LokalMieszkalny VALUES ('Dworcowa', '30', '5', '44-100', 'Knurów', default)
INSERT INTO LokalMieszkalny VALUES ('Dworcowa', '30', '7', '44-100', 'Knurów', default)
INSERT INTO LokalMieszkalny VALUES ('Dworcowa', '30', '9', '44-100', 'Knurów', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '100', '12', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '100', '24', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '100', '26', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '98', '3', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Bytomska', '98', '6', '41-800', 'Zabrze', default)
INSERT INTO LokalMieszkalny VALUES ('Ho¿a', '5', null, '44-218', 'Rybnik', default)
INSERT INTO LokalMieszkalny VALUES ('Ho¿a', '7', null, '44-218', 'Rybnik', default)
----------
INSERT INTO UzytkowanieLokalu
(
[IDGlownyKontrahent]
,[IDLokal]
,[TypUzytkowania]
,[Dokument]
,[DataDokumentu]
,[DataZamieszkaniaOd]
,[DataZamieszkaniaDo]
)
VALUES ('1', '25', default , 'AM/10/1578/2011', '2011-01-01', '2011-01-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('2', '24', default, 'AM/12/1579/2020', '2020-12-01','2020-12-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('3', '23', default, 'AM/09/2158/2019', '2019-09-01','2019-09-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('4', '22', default, 'AM/01/0011/2021', '2021-01-01','2021-01-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('5', '21', default, 'AM/01/0056/2009', '2009-01-01','2009-01-01', '2011-01-01')
INSERT INTO UzytkowanieLokalu VALUES ('5', '21', 'BEZUMOWNIE', 'BRAK', NULL,'2011-01-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('6', '20', default, 'AM/06/5644/2001', '2001-06-01','2001-06-01', '2009-01-01')
INSERT INTO UzytkowanieLokalu VALUES ('6', '20', 'BEZUMOWNIE', 'BRAK', NULL,'2009-01-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('7', '19', default, 'AM/11/2588/2013', '2013-11-01','2013-11-01','2015-12-31')
INSERT INTO UzytkowanieLokalu VALUES ('8', '18', default, 'AM/02/0041/2014', '2014-01-01','2014-01-01', '2016-06-30')
INSERT INTO UzytkowanieLokalu VALUES ('9', '17', default, 'AM/12/1579/2021', '2021-12-01','2021-12-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('10', '16', default, 'AM/09/1185/2015', '2015-09-01','2015-09-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('11', '15', default, 'AM/06/1578/2014', '2014-06-01','2014-06-01','2015-12-31')
INSERT INTO UzytkowanieLokalu VALUES ('12', '14', default, 'AM/09/1185/2016', '2016-09-01','2016-09-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('13', '12', default, 'AM/09/1185/2017', '2017-09-01','2017-09-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('14', '11', default, 'AM/06/1578/2016', '2016-06-01','2016-06-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('15', '10', default, 'AM/06/1578/2020', '2020-06-01','2020-06-01','2021-06-30')
INSERT INTO UzytkowanieLokalu VALUES ('17', '9', default, 'AM/01/1185/2016', '2016-01-01','2016-01-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('18', '8', default, 'AM/03/1578/2018', '2018-03-01','2018-03-01', '2021-03-31')
INSERT INTO UzytkowanieLokalu VALUES ('19', '5', default, 'AM/08/1185/2020', '2020-08-01','2020-08-01', NULL)
INSERT INTO UzytkowanieLokalu VALUES ('20', '1', default, 'AM/04/1578/2017', '2017-04-01','2017-04-01','2021-07-30')
----------
INSERT INTO WspolKontrahent
(
[Imie]
, [Nazwisko]
, [Pesel]
, [NrKomorkowy]
, [StopienPokrewienstwa]
, [IDUzytkowanieLokalu]
)
VALUES ('Borys', 'Kosno', '15290886555', null, 'syn', '3')
INSERT INTO WspolKontrahent VALUES ('£ukasz', 'Kosno', '98041819275', null, 'm¹¿', '3')
INSERT INTO WspolKontrahent VALUES ('Zdzis³aw', 'Zieliñski', '45061578865', null, 'ojciec', '6')
INSERT INTO WspolKontrahent VALUES ('Pawe³', 'Nowaczyk', '93060875562', null, 'syn', '4')
INSERT INTO WspolKontrahent VALUES ('Rafa³', 'Nowaczyk', '95060875562', null, 'syn', '4')
INSERT INTO WspolKontrahent VALUES ('Zbigniew', 'Nowaczyk', '81060875562', null, 'm¹¿', '4')
INSERT INTO WspolKontrahent VALUES ('Maja', 'Górska', '14230454324', null, 'córka', '16')
INSERT INTO WspolKontrahent VALUES ('Jadwiga', 'Górska', '93033045432', null, '¿ona', '16')
INSERT INTO WspolKontrahent VALUES ('Klaudia', 'Szymañska', '93033045532', null, 'córka', '10')
INSERT INTO WspolKontrahent VALUES ('Ewelina', 'Szymañska', '21061607752', null, 'wnuczka', '10')
----------
INSERT INTO Faktury
(
[IDUzytkowanieLokalu]
, [NrFaktury]
, [DataFaktury]
, [TerminZaplaty]
, [WartoscFaktury]
)
VALUES ('1','SUC/2011/01/0001', '2011-01-01', '2011-01-20', '450.59')
INSERT INTO Faktury VALUES ('1','SUC/2011/02/0001', '2011-02-01', '2011-02-20', '450.59')
INSERT INTO Faktury VALUES ('1','SUC/2011/03/0001', '2011-03-01', '2011-03-20', '450.59')
INSERT INTO Faktury VALUES ('1','SUC/2011/04/0001', '2011-04-01', '2011-04-20', '450.59')
INSERT INTO Faktury VALUES ('1','SUC/2011/05/0001', '2011-05-01', '2011-05-20', '450.59')
INSERT INTO Faktury VALUES ('1','SUC/2011/06/0001', '2011-06-01', '2011-06-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/07/0001', '2011-07-01', '2011-07-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/08/0001', '2011-08-01', '2011-08-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/09/0001', '2011-09-01', '2011-09-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/10/0001', '2011-10-01', '2011-10-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/11/0001', '2011-11-01', '2011-11-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2011/12/0001', '2011-12-01', '2011-12-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/01/0001', '2012-01-01', '2012-01-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/02/0001', '2012-02-01', '2012-02-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/03/0001', '2012-03-01', '2012-03-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/04/0001', '2012-04-01', '2012-04-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/05/0001', '2012-05-01', '2012-05-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/06/0001', '2012-06-01', '2012-06-20', '454.61')
INSERT INTO Faktury VALUES ('1','SUC/2012/07/0001', '2012-07-01', '2012-07-20', '478.11')
INSERT INTO Faktury VALUES ('1','SUC/2012/08/0001', '2012-08-01', '2012-08-20', '478.11')
INSERT INTO Faktury VALUES ('1','SUC/2012/09/0001', '2012-09-01', '2012-09-20', '478.11')
INSERT INTO Faktury VALUES ('1','SUC/2012/10/0001', '2012-10-01', '2012-10-20', '478.11')
INSERT INTO Faktury VALUES ('1','SUC/2012/11/0001', '2012-11-01', '2012-11-20', '478.11')
INSERT INTO Faktury VALUES ('1','SUC/2012/12/0001', '2012-12-01', '2012-12-20', '478.11')
---
INSERT INTO Faktury
(
[IDUzytkowanieLokalu]
, [NrFaktury]
, [DataFaktury]
, [TerminZaplaty]
, [WartoscFaktury]
)
VALUES ('6','SUC/2011/01/0002', '2011-01-01', '2011-01-20', '450.59')
INSERT INTO Faktury VALUES ('6','SUC/2011/02/0002', '2011-02-01', '2011-02-20', '450.59')
INSERT INTO Faktury VALUES ('6','SUC/2011/03/0002', '2011-03-01', '2011-03-20', '450.59')
INSERT INTO Faktury VALUES ('6','SUC/2011/04/0002', '2011-04-01', '2011-04-20', '450.59')
INSERT INTO Faktury VALUES ('6','SUC/2011/05/0002', '2011-05-01', '2011-05-20', '450.59')
INSERT INTO Faktury VALUES ('6','SUC/2011/06/0002', '2011-06-01', '2011-06-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/07/0002', '2011-07-01', '2011-07-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/08/0002', '2011-08-01', '2011-08-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/09/0002', '2011-09-01', '2011-09-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/10/0002', '2011-10-01', '2011-10-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/11/0002', '2011-11-01', '2011-11-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2011/12/0002', '2011-12-01', '2011-12-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/01/0002', '2012-01-01', '2012-01-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/02/0002', '2012-02-01', '2012-02-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/03/0002', '2012-03-01', '2012-03-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/04/0002', '2012-04-01', '2012-04-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/05/0002', '2012-05-01', '2012-05-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/06/0002', '2012-06-01', '2012-06-20', '454.61')
INSERT INTO Faktury VALUES ('6','SUC/2012/07/0002', '2012-07-01', '2012-07-20', '478.11')
INSERT INTO Faktury VALUES ('6','SUC/2012/08/0002', '2012-08-01', '2012-08-20', '478.11')
INSERT INTO Faktury VALUES ('6','SUC/2012/09/0002', '2012-09-01', '2012-09-20', '478.11')
INSERT INTO Faktury VALUES ('6','SUC/2012/10/0002', '2012-10-01', '2012-10-20', '478.11')
INSERT INTO Faktury VALUES ('6','SUC/2012/11/0002', '2012-11-01', '2012-11-20', '478.11')
INSERT INTO Faktury VALUES ('6','SUC/2012/12/0002', '2012-12-01', '2012-12-20', '478.11')
---
INSERT INTO Faktury VALUES ('7','SUC/2008/01/0001', '2008-01-01', '2008-01-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/02/0001', '2008-02-01', '2008-02-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/03/0001', '2008-03-01', '2008-03-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/04/0001', '2008-04-01', '2008-04-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/05/0001', '2008-05-01', '2008-05-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/06/0001', '2008-06-01', '2008-06-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/07/0001', '2008-07-01', '2008-07-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/08/0001', '2008-08-01', '2008-08-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/09/0001', '2008-09-01', '2008-09-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/10/0001', '2008-10-01', '2008-10-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/11/0001', '2008-11-01', '2008-11-20', '258.75')
INSERT INTO Faktury VALUES ('7','SUC/2008/12/0001', '2008-12-01', '2008-12-20', '258.75')
---
INSERT INTO Faktury VALUES ('8','SUC/2009/01/0001', '2009-01-01', '2009-01-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/02/0001', '2009-02-01', '2009-02-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/03/0001', '2009-03-01', '2009-03-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/04/0001', '2009-04-01', '2009-04-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/05/0001', '2009-05-01', '2009-05-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/06/0001', '2009-06-01', '2009-06-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/07/0001', '2009-07-01', '2009-07-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/08/0001', '2009-08-01', '2009-08-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/09/0001', '2009-09-01', '2009-09-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/10/0001', '2009-10-01', '2009-10-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/11/0001', '2009-11-01', '2009-11-20', '258.75')
INSERT INTO Faktury VALUES ('8','SUC/2009/12/0001', '2009-12-01', '2009-12-20', '258.75')
---
INSERT INTO Faktury VALUES ('5','SUC/2009/01/0002', '2009-01-01', '2009-01-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/02/0002', '2009-02-01', '2009-02-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/03/0002', '2009-03-01', '2009-03-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/04/0002', '2009-04-01', '2009-04-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/05/0002', '2009-05-01', '2009-05-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/06/0002', '2009-06-01', '2009-06-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/07/0002', '2009-07-01', '2009-07-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/08/0002', '2009-08-01', '2009-08-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/09/0002', '2009-09-01', '2009-09-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/10/0002', '2009-10-01', '2009-10-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/11/0002', '2009-11-01', '2009-11-20', '258.75')
INSERT INTO Faktury VALUES ('5','SUC/2009/12/0002', '2009-12-01', '2009-12-20', '258.75')
---
INSERT INTO Faktury VALUES ('9','SUC/2013/11/0001', '2013-11-01', '2013-11-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2013/12/0001', '2013-12-01', '2013-12-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/01/0001', '2014-01-01', '2014-01-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/02/0001', '2014-02-01', '2014-02-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/03/0001', '2014-03-01', '2014-03-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/04/0001', '2014-04-01', '2014-04-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/05/0001', '2014-05-01', '2014-05-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/06/0001', '2014-06-01', '2014-06-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/07/0001', '2014-07-01', '2014-07-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/08/0001', '2014-08-01', '2014-08-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/09/0001', '2014-09-01', '2014-09-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/10/0001', '2014-10-01', '2014-10-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/11/0001', '2014-11-01', '2014-11-20', '548.99')
INSERT INTO Faktury VALUES ('9','SUC/2014/12/0001', '2014-12-01', '2014-12-20', '548.99')
---
INSERT INTO Faktury VALUES ('10','SUC/2014/01/0002', '2014-01-01', '2014-01-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/02/0002', '2014-02-01', '2014-02-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/03/0002', '2014-03-01', '2014-03-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/04/0002', '2014-04-01', '2014-04-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/05/0002', '2014-05-01', '2014-05-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/06/0002', '2014-06-01', '2014-06-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/07/0002', '2014-07-01', '2014-07-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/08/0002', '2014-08-01', '2014-08-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/09/0002', '2014-09-01', '2014-09-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/10/0002', '2014-10-01', '2014-10-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/11/0002', '2014-11-01', '2014-11-20', '548.99')
INSERT INTO Faktury VALUES ('10','SUC/2014/12/0002', '2014-12-01', '2014-12-20', '548.99')
---
INSERT INTO Faktury VALUES ('13','SUC/2014/06/0003', '2014-06-01', '2014-06-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/07/0003', '2014-07-01', '2014-07-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/08/0003', '2014-08-01', '2014-08-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/09/0003', '2014-09-01', '2014-09-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/10/0003', '2014-10-01', '2014-10-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/11/0003', '2014-11-01', '2014-11-20', '548.99')
INSERT INTO Faktury VALUES ('13','SUC/2014/12/0003', '2014-12-01', '2014-12-20', '548.99')
---
INSERT INTO Faktury VALUES ('12','SUC/2015/09/0003', '2015-09-01', '2015-09-20', '548.99')
INSERT INTO Faktury VALUES ('12','SUC/2015/10/0003', '2015-10-01', '2015-10-20', '548.99')
INSERT INTO Faktury VALUES ('12','SUC/2015/11/0003', '2015-11-01', '2015-11-20', '548.99')
INSERT INTO Faktury VALUES ('12','SUC/2015/12/0003', '2015-12-01', '2015-12-20', '548.99')
---
INSERT INTO Faktury VALUES ('18','SUC/2016/01/0001', '2016-01-01', '2016-01-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/02/0001', '2016-02-01', '2016-02-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/03/0001', '2016-03-01', '2016-03-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/04/0001', '2016-04-01', '2016-04-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/05/0001', '2016-05-01', '2016-05-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/06/0001', '2016-06-01', '2016-06-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/07/0001', '2016-07-01', '2016-07-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/08/0001', '2016-08-01', '2016-08-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/09/0001', '2016-09-01', '2016-09-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/10/0001', '2016-10-01', '2016-10-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/11/0001', '2016-11-01', '2016-11-20', '611.78')
INSERT INTO Faktury VALUES ('18','SUC/2016/12/0001', '2016-12-01', '2016-12-20', '611.78')
---
INSERT INTO Faktury VALUES ('16','SUC/2016/06/0002', '2016-06-01', '2016-06-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/07/0002', '2016-07-01', '2016-07-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/08/0002', '2016-08-01', '2016-08-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/09/0002', '2016-09-01', '2016-09-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/10/0002', '2016-10-01', '2016-10-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/11/0002', '2016-11-01', '2016-11-20', '611.78')
INSERT INTO Faktury VALUES ('16','SUC/2016/12/0002', '2016-12-01', '2016-12-20', '611.78')
--- 
INSERT INTO Faktury VALUES ('14','SUC/2016/09/0003', '2016-09-01', '2016-09-20', '611.78')
INSERT INTO Faktury VALUES ('14','SUC/2016/10/0003', '2016-10-01', '2016-10-20', '611.78')
INSERT INTO Faktury VALUES ('14','SUC/2016/11/0003', '2016-11-01', '2016-11-20', '611.78')
INSERT INTO Faktury VALUES ('14','SUC/2016/12/0003', '2016-12-01', '2016-12-20', '611.78')
--- 
INSERT INTO Faktury VALUES ('21','SUC/2017/04/0001', '2017-04-01', '2017-04-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/05/0001', '2017-05-01', '2017-05-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/06/0001', '2017-06-01', '2017-06-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/07/0001', '2017-07-01', '2017-07-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/08/0001', '2017-08-01', '2017-08-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/09/0001', '2017-09-01', '2017-09-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/10/0001', '2017-10-01', '2017-10-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/11/0001', '2017-11-01', '2017-11-20', '611.78')
INSERT INTO Faktury VALUES ('21','SUC/2017/12/0001', '2017-12-01', '2017-12-20', '611.78')
---
INSERT INTO Faktury VALUES ('15','SUC/2017/09/0002', '2017-09-01', '2017-09-20', '611.78')
INSERT INTO Faktury VALUES ('15','SUC/2017/10/0002', '2017-10-01', '2017-10-20', '611.78')
INSERT INTO Faktury VALUES ('15','SUC/2017/11/0002', '2017-11-01', '2017-11-20', '611.78')
INSERT INTO Faktury VALUES ('15','SUC/2017/12/0002', '2017-12-01', '2017-12-20', '611.78')
---
INSERT INTO Faktury VALUES ('19','SUC/2018/03/0001', '2018-03-01', '2018-03-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/04/0001', '2018-04-01', '2018-04-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/05/0001', '2018-05-01', '2018-05-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/06/0001', '2018-06-01', '2018-06-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/07/0001', '2018-07-01', '2018-07-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/08/0001', '2018-08-01', '2018-08-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/09/0001', '2018-09-01', '2018-09-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/10/0001', '2018-10-01', '2018-10-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/11/0001', '2018-11-01', '2018-11-20', '728.98')
INSERT INTO Faktury VALUES ('19','SUC/2018/12/0001', '2018-12-01', '2018-12-20', '728.98')
---
INSERT INTO Faktury VALUES ('3','SUC/2019/09/0001', '2019-09-01', '2019-09-20', '728.98')
INSERT INTO Faktury VALUES ('3','SUC/2019/10/0001', '2019-10-01', '2019-10-20', '728.98')
INSERT INTO Faktury VALUES ('3','SUC/2019/11/0001', '2019-11-01', '2019-11-20', '728.98')
INSERT INTO Faktury VALUES ('3','SUC/2019/12/0001', '2019-12-01', '2019-12-20', '728.98')
---
INSERT INTO Faktury VALUES ('17','SUC/2020/06/0001', '2020-06-01', '2020-06-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/07/0001', '2020-07-01', '2020-07-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/08/0001', '2020-08-01', '2020-08-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/09/0001', '2020-09-01', '2020-09-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/10/0001', '2020-10-01', '2020-10-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/11/0001', '2020-11-01', '2020-11-20', '815.74')
INSERT INTO Faktury VALUES ('17','SUC/2020/12/0001', '2020-12-01', '2020-12-20', '815.74')
---
INSERT INTO Faktury VALUES ('20','SUC/2020/08/0002', '2020-08-01', '2020-08-20', '815.74')
INSERT INTO Faktury VALUES ('20','SUC/2020/09/0002', '2020-09-01', '2020-09-20', '815.74')
INSERT INTO Faktury VALUES ('20','SUC/2020/10/0002', '2020-10-01', '2020-10-20', '815.74')
INSERT INTO Faktury VALUES ('20','SUC/2020/11/0002', '2020-11-01', '2020-11-20', '815.74')
INSERT INTO Faktury VALUES ('20','SUC/2020/12/0002', '2020-12-01', '2020-12-20', '815.74')
--- 
INSERT INTO Faktury VALUES ('2','SUC/2020/12/0003', '2020-12-01', '2020-12-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/01/0001', '2021-01-01', '2021-01-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/02/0001', '2021-02-01', '2021-02-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/03/0001', '2021-03-01', '2021-03-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/04/0001', '2021-04-01', '2021-04-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/05/0001', '2021-05-01', '2021-05-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/06/0001', '2021-06-01', '2021-06-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/07/0001', '2021-07-01', '2021-07-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/08/0001', '2021-08-01', '2021-08-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/09/0001', '2021-09-01', '2021-09-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/10/0001', '2021-10-01', '2021-10-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/11/0001', '2021-11-01', '2021-11-20', '815.74')
INSERT INTO Faktury VALUES ('2','SUC/2021/12/0001', '2021-12-01', '2021-12-20', '815.74')
---
INSERT INTO Faktury VALUES ('4','SUC/2021/01/0002', '2021-01-01', '2021-01-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/02/0002', '2021-02-01', '2021-02-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/03/0002', '2021-03-01', '2021-03-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/04/0002', '2021-04-01', '2021-04-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/05/0002', '2021-05-01', '2021-05-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/06/0002', '2021-06-01', '2021-06-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/07/0002', '2021-07-01', '2021-07-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/08/0002', '2021-08-01', '2021-08-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/09/0002', '2021-09-01', '2021-09-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/10/0002', '2021-10-01', '2021-10-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/11/0002', '2021-11-01', '2021-11-20', '815.74')
INSERT INTO Faktury VALUES ('4','SUC/2021/12/0002', '2021-12-01', '2021-12-20', '815.74')
---
INSERT INTO Faktury VALUES ('11','SUC/2021/12/0003', '2021-12-01', '2021-12-20', '815.74')
---
INSERT INTO SadRejonowy
(
[Nazwa]
, [Adres]
, [KodPocztowy]
, [Miasto]
, [Województwo]
, [NIP]
, [NrTelefonu]
, [email]
)
VALUES ('S¹d Rejonowy w Rybniku', 'Plac M. Kopernika 2', '44-200', 'Rybnik', default, '642-23-33-394', ' 324393100', 'biuro.podawcze@rybnik.sr.gov.pl')
INSERT INTO SadRejonowy VALUES ('S¹d Rejonowy Katowice-Wschód w Katowicach', 'ul.Lompy 14', '40-040', 'Katowice', default, '954-258-40-48', '326047987', 'poi@katowice-wschod.sr.gov.pl')
INSERT INTO SadRejonowy VALUES ('S¹d Rejonowy Katowice-Zachód w Katowicach', 'ul. Warszawska 45', '40-040', 'Katowice', default, '634-262-74-55', '326047581', 'boi.cywilny@katowice-zachod.sr.gov.pl')
INSERT INTO SadRejonowy VALUES ('S¹d Rejonowy w Gliwicach', 'ul. Powstañców Warszawy 23', '44-101', 'Gliwice', default, '631-10-78-941', '3233874007', 'boi@gliwice.sr.gov.pl')
INSERT INTO SadRejonowy VALUES ('S¹d Rejonowy w Zabrzu', 'ul. 3-go Maja 21', '41-800', 'Zabrze', default, '648-11-03-595', '3237358317', 'informacja@zabrze.sr.gov.pl')
---
INSERT INTO NakazZaplaty
(
[Sygnatura]
, [IDSadRejonowy]
, [DataNakazu]
, [NaleznoscGlowna]
, [Odsetki]
, [KosztyPostepowania]
)
Values ('I NC 1585/11', '1', '2011-05-31', '2252.95', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 2541/12','1','2012-06-30', '5909.93', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 2542/12', '1', '2012-12-31', '2868.66', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 125/21', '1', '2021-12-31', '10604.62', default, '1758.50')
INSERT INTO NakazZaplaty VALUES ('I NC 1586/11', '5', '2011-05-31', '2252.95', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 2531/12','5','2012-06-30', '5909.93', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 1587/12', '5', '2012-12-31', '2868.66', default, '1500.50')
INSERT INTO NakazZaplaty VALUES ('I NC 1587/08', '5', '2008-12-31', '3105.00', default, '859.59')
INSERT INTO NakazZaplaty VALUES ('I NC 1589/09', '5', '2009-12-31', '3105.00', default, '859.59')
INSERT INTO NakazZaplaty VALUES ('I NC 1592/09', '5', '2009-12-31', '3105.00', default, '859.59')
INSERT INTO NakazZaplaty VALUES ('I NC 159/21', '5', '2021-12-31', '9788.88', default, '1800.25')
INSERT INTO NakazZaplaty VALUES ('I NC 335/19', '5', '2019-12-31', '2915.92', default, '1525.50')
INSERT INTO NakazZaplaty VALUES ('I NC 458/17', '5', '2017-12-31', '5506.02', default, '458.78')
INSERT INTO NakazZaplaty VALUES ('I NC 458/14', '5', '2014-12-31', '7685.86', default, '967.45')
INSERT INTO NakazZaplaty VALUES ('I NC 245/14', '4', '2014-12-31', '6587.88', default, '967.45')
INSERT INTO NakazZaplaty VALUES ('I NC 246/14', '4', '2014-12-31', '3842.93', default, '967.45')
INSERT INTO NakazZaplaty VALUES ('I NC 246/15', '4', '2015-12-31', '2195.96', default, '967.45')
INSERT INTO NakazZaplaty VALUES ('I NC 246/16', '2', '2016-12-31', '7341.36', default, '967.45')
INSERT INTO NakazZaplaty VALUES ('I NC 246/18', '3', '2018-12-31', '7289.80', default, '967.45')
---
INSERT INTO KlauzulaWykonalnosci
(
[IDNakazZaplaty]
,[DataKlauzuli]
)
VALUES ('8', '2009-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('9', '2010-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('10', '2010-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('1', '2011-06-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('5', '2011-06-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('6', '2012-07-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('2', '2012-07-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('3', '2013-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('7', '2013-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('14', '2015-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('15', '2015-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('16', '2015-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('17', '2016-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('18', '2017-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('13', '2018-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('19', '2019-01-15')
INSERT INTO KlauzulaWykonalnosci VALUES ('12', '2020-01-15')
---
INSERT INTO Komornik
([Imie]
, [Nazwisko]
, [Nazwa]
, [IDSadRejonowy]
, [Adres]
, [KodPocztowy]
, [Miasto]
, [Województwo]
, [NIP]
, [NrTelefonu]
, [email]
)
VALUES ('Arkadiusz', 'Chmielowski', 'Kancelaria Komornicza nr I', '1', 'ul. Pocztowa 6', '44-200', 'Rybnik', default, '647-227-12-41', '423-61-76' ,'chmielowskiarkadiusz@gmail.com')
INSERT INTO Komornik VALUES ('Leszek', 'Ferczykowski', 'Kancelaria Komornicza nr VI', '2', 'ul. Mariacka 37/7', '40-014', 'Katowice', default, '644-255-12-41', '428-64-79' ,'katowice6@komornik.pl')
INSERT INTO Komornik VALUES ('Marcin', 'Kaczorek', 'Kancelaria Komornicza nr VII', '3', 'ul. Gliwicka 224', '40-860', 'Katowice', default, '649-785-12-41', '781-64-79' ,'katowice.kaczor@komornik.pl')
INSERT INTO Komornik VALUES ('Robert', '£ukasiak', 'Kancelaria Komornicza nr IX', '4', 'ul. Zwyciêstwa 12/4', '44-100', 'Gliwice', default, '654-789-12-43', '782-65-78' ,'www.gliwice-komornik.pl')
INSERT INTO Komornik VALUES ('Adam', 'Barañski', 'Kancelaria Komornicza nr I', '5', 'ul. Wolnoœci 289/2', '41-800', 'Zabrze', default, '645-987-21-33', '582-33-44' ,'zabrze4@komornikid.pl')
---
INSERT INTO EgzekucjaKomornicza
VALUES ('1', '5', 'KM 10/09', '2009-02-01', '2009-05-25')
INSERT INTO EgzekucjaKomornicza VALUES ('1', '5', 'KM 10/14', '2014-02-01', '2016-05-25')
INSERT INTO EgzekucjaKomornicza VALUES ('2', '5', 'KM 1587/15', '2015-05-01', '2015-11-05')
INSERT INTO EgzekucjaKomornicza VALUES ('2', '5', 'KM 158/17', '2017-05-01', '2018-11-05')
INSERT INTO EgzekucjaKomornicza VALUES ('3', '5', 'KM 159/17', '2017-05-01', '2018-11-05')
INSERT INTO EgzekucjaKomornicza VALUES ('4', '1', 'KM 1452/11', '2011-11-01', '2015-11-05')
INSERT INTO EgzekucjaKomornicza VALUES ('4', '1', 'KM 452/16', '2016-03-01', null)
INSERT INTO EgzekucjaKomornicza VALUES ('5', '5', 'KM 1453/11', '2011-11-01', '2015-11-05')
INSERT INTO EgzekucjaKomornicza VALUES ('5', '5', 'KM 487/16', '2016-03-01', '2017-03-01')
INSERT INTO EgzekucjaKomornicza VALUES ('5', '5', 'KM 456/18', '2018-11-12', null)
INSERT INTO EgzekucjaKomornicza VALUES ('6', '5', 'KM 13/13', '2013-03-05', null)
INSERT INTO EgzekucjaKomornicza VALUES ('7', '1', 'KM 13/13', '2013-03-05', '2013-10-27')
INSERT INTO EgzekucjaKomornicza VALUES ('8', '1', 'KM 145/14', '2014-03-05', '2014-10-27')
INSERT INTO EgzekucjaKomornicza VALUES ('9', '5', 'KM 146/14', '2014-03-05', '2014-10-27')
INSERT INTO EgzekucjaKomornicza VALUES ('9', '5', 'KM 225/17', '2017-03-05', '2019-10-27')
INSERT INTO EgzekucjaKomornicza VALUES ('10', '5', 'KM 74/15', '2015-07-05', '2019-05-27')
INSERT INTO EgzekucjaKomornicza VALUES ('11', '4', 'KM 145/15', '2015-07-05','2019-05-27')
INSERT INTO EgzekucjaKomornicza VALUES ('11', '4', 'KM 114/20', '2020-01-31', null)
INSERT INTO EgzekucjaKomornicza VALUES ('12', '4', 'KM 168/15', '2015-07-05', null)
INSERT INTO EgzekucjaKomornicza VALUES ('13', '4', 'KM 114/16', '2016-07-05', '2020-04-25')
INSERT INTO EgzekucjaKomornicza VALUES ('14', '2', 'KM 124/19', '2019-07-05', '2020-04-25')
INSERT INTO EgzekucjaKomornicza VALUES ('15', '5', 'KM 174/20', '2020-11-05', null)
INSERT INTO EgzekucjaKomornicza VALUES ('16', '3', 'KM 125/21', '2021-02-05', null)
---
INSERT INTO FakturyZasadzone VALUES ('1','1')
INSERT INTO FakturyZasadzone VALUES ('2','1')
INSERT INTO FakturyZasadzone VALUES ('3','1')
INSERT INTO FakturyZasadzone VALUES ('4','1')
INSERT INTO FakturyZasadzone VALUES ('5','1')
---
INSERT INTO FakturyZasadzone VALUES ('6','2')
INSERT INTO FakturyZasadzone VALUES ('7','2')
INSERT INTO FakturyZasadzone VALUES ('8','2')
INSERT INTO FakturyZasadzone VALUES ('9','2')
INSERT INTO FakturyZasadzone VALUES ('10','2')
INSERT INTO FakturyZasadzone VALUES ('11','2')
INSERT INTO FakturyZasadzone VALUES ('12','2')
INSERT INTO FakturyZasadzone VALUES ('13','2')
INSERT INTO FakturyZasadzone VALUES ('14','2')
INSERT INTO FakturyZasadzone VALUES ('15','2')
INSERT INTO FakturyZasadzone VALUES ('16','2')
INSERT INTO FakturyZasadzone VALUES ('17','2')
INSERT INTO FakturyZasadzone VALUES ('18','2')
---
INSERT INTO FakturyZasadzone VALUES ('19','3')
INSERT INTO FakturyZasadzone VALUES ('20','3')
INSERT INTO FakturyZasadzone VALUES ('21','3')
INSERT INTO FakturyZasadzone VALUES ('22','3')
INSERT INTO FakturyZasadzone VALUES ('23','3')
INSERT INTO FakturyZasadzone VALUES ('24','3')
---
INSERT INTO FakturyZasadzone VALUES ('184','4')
INSERT INTO FakturyZasadzone VALUES ('185','4')
INSERT INTO FakturyZasadzone VALUES ('186','4')
INSERT INTO FakturyZasadzone VALUES ('187','4')
INSERT INTO FakturyZasadzone VALUES ('188','4')
INSERT INTO FakturyZasadzone VALUES ('189','4')
INSERT INTO FakturyZasadzone VALUES ('190','4')
INSERT INTO FakturyZasadzone VALUES ('191','4')
INSERT INTO FakturyZasadzone VALUES ('192','4')
INSERT INTO FakturyZasadzone VALUES ('193','4')
INSERT INTO FakturyZasadzone VALUES ('194','4')
INSERT INTO FakturyZasadzone VALUES ('195','4')
INSERT INTO FakturyZasadzone VALUES ('196','4')
---
INSERT INTO FakturyZasadzone VALUES ('25','5')
INSERT INTO FakturyZasadzone VALUES ('26','5')
INSERT INTO FakturyZasadzone VALUES ('27','5')
INSERT INTO FakturyZasadzone VALUES ('28','5')
INSERT INTO FakturyZasadzone VALUES ('29','5')
---
INSERT INTO FakturyZasadzone VALUES ('30','6')
INSERT INTO FakturyZasadzone VALUES ('31','6')
INSERT INTO FakturyZasadzone VALUES ('32','6')
INSERT INTO FakturyZasadzone VALUES ('33','6')
INSERT INTO FakturyZasadzone VALUES ('34','6')
INSERT INTO FakturyZasadzone VALUES ('35','6')
INSERT INTO FakturyZasadzone VALUES ('36','6')
INSERT INTO FakturyZasadzone VALUES ('37','6')
INSERT INTO FakturyZasadzone VALUES ('38','6')
INSERT INTO FakturyZasadzone VALUES ('39','6')
INSERT INTO FakturyZasadzone VALUES ('40','6')
INSERT INTO FakturyZasadzone VALUES ('41','6')
INSERT INTO FakturyZasadzone VALUES ('42','6')
---
INSERT INTO FakturyZasadzone VALUES ('43','7')
INSERT INTO FakturyZasadzone VALUES ('44','7')
INSERT INTO FakturyZasadzone VALUES ('45','7')
INSERT INTO FakturyZasadzone VALUES ('46','7')
INSERT INTO FakturyZasadzone VALUES ('47','7')
INSERT INTO FakturyZasadzone VALUES ('48','7')
---
INSERT INTO FakturyZasadzone VALUES ('49','8')
INSERT INTO FakturyZasadzone VALUES ('50','8')
INSERT INTO FakturyZasadzone VALUES ('51','8')
INSERT INTO FakturyZasadzone VALUES ('52','8')
INSERT INTO FakturyZasadzone VALUES ('53','8')
INSERT INTO FakturyZasadzone VALUES ('54','8')
INSERT INTO FakturyZasadzone VALUES ('55','8')
INSERT INTO FakturyZasadzone VALUES ('56','8')
INSERT INTO FakturyZasadzone VALUES ('57','8')
INSERT INTO FakturyZasadzone VALUES ('58','8')
INSERT INTO FakturyZasadzone VALUES ('59','8')
INSERT INTO FakturyZasadzone VALUES ('60','8')
---
INSERT INTO FakturyZasadzone VALUES ('61','9')
INSERT INTO FakturyZasadzone VALUES ('62','9')
INSERT INTO FakturyZasadzone VALUES ('63','9')
INSERT INTO FakturyZasadzone VALUES ('64','9')
INSERT INTO FakturyZasadzone VALUES ('65','9')
INSERT INTO FakturyZasadzone VALUES ('66','9')
INSERT INTO FakturyZasadzone VALUES ('67','9')
INSERT INTO FakturyZasadzone VALUES ('68','9')
INSERT INTO FakturyZasadzone VALUES ('69','9')
INSERT INTO FakturyZasadzone VALUES ('70','9')
INSERT INTO FakturyZasadzone VALUES ('71','9')
INSERT INTO FakturyZasadzone VALUES ('72','9')
---
INSERT INTO FakturyZasadzone VALUES ('73','10')
INSERT INTO FakturyZasadzone VALUES ('74','10')
INSERT INTO FakturyZasadzone VALUES ('75','10')
INSERT INTO FakturyZasadzone VALUES ('76','10')
INSERT INTO FakturyZasadzone VALUES ('77','10')
INSERT INTO FakturyZasadzone VALUES ('78','10')
INSERT INTO FakturyZasadzone VALUES ('79','10')
INSERT INTO FakturyZasadzone VALUES ('80','10')
INSERT INTO FakturyZasadzone VALUES ('81','10')
INSERT INTO FakturyZasadzone VALUES ('82','10')
INSERT INTO FakturyZasadzone VALUES ('83','10')
INSERT INTO FakturyZasadzone VALUES ('84','10')
---
INSERT INTO FakturyZasadzone VALUES ('197','11')
INSERT INTO FakturyZasadzone VALUES ('198','11')
INSERT INTO FakturyZasadzone VALUES ('199','11')
INSERT INTO FakturyZasadzone VALUES ('200','11')
INSERT INTO FakturyZasadzone VALUES ('201','11')
INSERT INTO FakturyZasadzone VALUES ('202','11')
INSERT INTO FakturyZasadzone VALUES ('203','11')
INSERT INTO FakturyZasadzone VALUES ('204','11')
INSERT INTO FakturyZasadzone VALUES ('205','11')
INSERT INTO FakturyZasadzone VALUES ('206','11')
INSERT INTO FakturyZasadzone VALUES ('207','11')
INSERT INTO FakturyZasadzone VALUES ('208','11')
---
INSERT INTO FakturyZasadzone VALUES ('168','12')
INSERT INTO FakturyZasadzone VALUES ('169','12')
INSERT INTO FakturyZasadzone VALUES ('170','12')
INSERT INTO FakturyZasadzone VALUES ('171','12')
---
INSERT INTO FakturyZasadzone VALUES ('145','13')
INSERT INTO FakturyZasadzone VALUES ('146','13')
INSERT INTO FakturyZasadzone VALUES ('147','13')
INSERT INTO FakturyZasadzone VALUES ('148','13')
INSERT INTO FakturyZasadzone VALUES ('149','13')
INSERT INTO FakturyZasadzone VALUES ('150','13')
INSERT INTO FakturyZasadzone VALUES ('151','13')
INSERT INTO FakturyZasadzone VALUES ('152','13')
INSERT INTO FakturyZasadzone VALUES ('153','13')
---
INSERT INTO FakturyZasadzone VALUES ('85','14')
INSERT INTO FakturyZasadzone VALUES ('86','14')
INSERT INTO FakturyZasadzone VALUES ('87','14')
INSERT INTO FakturyZasadzone VALUES ('88','14')
INSERT INTO FakturyZasadzone VALUES ('89','14')
INSERT INTO FakturyZasadzone VALUES ('90','14')
INSERT INTO FakturyZasadzone VALUES ('91','14')
INSERT INTO FakturyZasadzone VALUES ('92','14')
INSERT INTO FakturyZasadzone VALUES ('93','14')
INSERT INTO FakturyZasadzone VALUES ('94','14')
INSERT INTO FakturyZasadzone VALUES ('95','14')
INSERT INTO FakturyZasadzone VALUES ('96','14')
INSERT INTO FakturyZasadzone VALUES ('97','14')
INSERT INTO FakturyZasadzone VALUES ('98','14')
---
INSERT INTO FakturyZasadzone VALUES ('99','15')
INSERT INTO FakturyZasadzone VALUES ('100','15')
INSERT INTO FakturyZasadzone VALUES ('101','15')
INSERT INTO FakturyZasadzone VALUES ('102','15')
INSERT INTO FakturyZasadzone VALUES ('103','15')
INSERT INTO FakturyZasadzone VALUES ('104','15')
INSERT INTO FakturyZasadzone VALUES ('105','15')
INSERT INTO FakturyZasadzone VALUES ('106','15')
INSERT INTO FakturyZasadzone VALUES ('107','15')
INSERT INTO FakturyZasadzone VALUES ('108','15')
INSERT INTO FakturyZasadzone VALUES ('109','15')
INSERT INTO FakturyZasadzone VALUES ('110','15')
---
INSERT INTO FakturyZasadzone VALUES ('111','16')
INSERT INTO FakturyZasadzone VALUES ('112','16')
INSERT INTO FakturyZasadzone VALUES ('113','16')
INSERT INTO FakturyZasadzone VALUES ('114','16')
INSERT INTO FakturyZasadzone VALUES ('115','16')
INSERT INTO FakturyZasadzone VALUES ('116','16')
INSERT INTO FakturyZasadzone VALUES ('117','16')
---
INSERT INTO FakturyZasadzone VALUES ('118','17')
INSERT INTO FakturyZasadzone VALUES ('119','17')
INSERT INTO FakturyZasadzone VALUES ('120','17')
INSERT INTO FakturyZasadzone VALUES ('121','17')
---
INSERT INTO FakturyZasadzone VALUES ('122','18')
INSERT INTO FakturyZasadzone VALUES ('123','18')
INSERT INTO FakturyZasadzone VALUES ('124','18')
INSERT INTO FakturyZasadzone VALUES ('125','18')
INSERT INTO FakturyZasadzone VALUES ('126','18')
INSERT INTO FakturyZasadzone VALUES ('127','18')
INSERT INTO FakturyZasadzone VALUES ('128','18')
INSERT INTO FakturyZasadzone VALUES ('129','18')
INSERT INTO FakturyZasadzone VALUES ('130','18')
INSERT INTO FakturyZasadzone VALUES ('131','18')
INSERT INTO FakturyZasadzone VALUES ('132','18')
INSERT INTO FakturyZasadzone VALUES ('133','18')
---
INSERT INTO FakturyZasadzone VALUES ('158','19')
INSERT INTO FakturyZasadzone VALUES ('159','19')
INSERT INTO FakturyZasadzone VALUES ('160','19')
INSERT INTO FakturyZasadzone VALUES ('161','19')
INSERT INTO FakturyZasadzone VALUES ('162','19')
INSERT INTO FakturyZasadzone VALUES ('163','19')
INSERT INTO FakturyZasadzone VALUES ('164','19')
INSERT INTO FakturyZasadzone VALUES ('165','19')
INSERT INTO FakturyZasadzone VALUES ('166','19')
INSERT INTO FakturyZasadzone VALUES ('167','19')
--- KONIEC BAZY
--- Zadania
--- 1. Wyszukaj wszystkie Nakazy Zap³aty G³ównych Kontrahentów
SELECT
nz.Sygnatura
, gk.Imie
, gk.Nazwisko
FROM GlownyKontrahent gk
JOIN UzytkowanieLokalu ul on ul.IDGlownyKontrahent = gk.IDGlownyKontrahent
JOIN Faktury f on ul.IDUzytkowanieLokalu = f.IDUzytkowanieLokalu
JOIN FakturyZasadzone fz on f.IDFaktury = fz.IDFaktury
JOIN NakazZaplaty nz on fz.IDNakazZaplaty = nz.IDNakazZaplaty
GROUP BY nz.Sygnatura, gk.Imie, gk.Nazwisko order by gk.Nazwisko
---2. Wyszukaj Nakazy Zap³aty wydane przez SR Zabrze
SELECT 
nz.Sygnatura
FROM SadRejonowy sr
JOIN NakazZaplaty nz ON sr.IDSadRejonowy = nz.IDSadRejonowy
WHERE sr.Miasto like '%zabrze%'
---3. Wyszukaj lokale mieszkalne, które s¹ bezumownie zajmowane
SELECT
lm.Ulica
, lm.NrBudynku
, lm.NrLokalu
, lm.Miasto
FROM LokalMieszkalny lm
JOIN UzytkowanieLokalu uz ON lm.IDLokal = uz.IDLokal
WHERE uz.TypUzytkowania like '%bezum%'
--- 4. Policz sumê wystawionych faktur dla poszczególnych miast
SELECT SUM(WartoscFaktury) AS SumaFaktur
, LM.Miasto
FROM Faktury f
JOIN UzytkowanieLokalu ul on f.IDUzytkowanieLokalu = ul.IDUzytkowanieLokalu
JOIN LokalMieszkalny lm on ul.IDLokal = lm.IDLokal
GROUP BY LM.Miasto order by SumaFaktur
--- 5. Policz liczbê wydanych Nakazów Zap³aty dla SR poszczególnych miast
SELECT COUNT(nz.IDNakazZaplaty) AS LiczbaNakazow
, sr.Miasto
FROM NakazZaplaty nz
JOIN SadRejonowy sr ON nz.IDSadRejonowy = sr.IDSadRejonowy
GROUP BY sr.Miasto
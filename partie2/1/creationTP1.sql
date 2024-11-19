DROP table APPARTENIR;
DROP table EFFECTUER;
DROP table COURSE;

DROP table Ecurie;
DROP table Circuit;
DROP table Pilote;


-- script de creation des tables de la base F1
CREATE TABLE PILOTE( 
nuPilote number(5) constraint pk_pilote Primary key, 
nomPilote varchar2(20), 
prenomPilote varchar2(20),
nationalite varchar2(20)
);

CREATE TABLE CIRCUIT (
nuCi number(5) constraint pk_circuit primary key,
nomCi varchar2(20),
paysCi varchar2(20)
);

create table Ecurie (
nuEcurie number(5) constraint pk_ecurie Primary key,
nomEcurie varchar2(20)
);

create table COURSE (
nuCO number(5) constraint pk_course Primary key, 
anneeCo number(4),
meteo varchar2(5) constraint ck_meteo check (meteo in ('sec','pluie','mix')),
nuCi number(5) constraint fk_co_ci references Circuit(nuCi)
);
 
create table EFFECTUER(
nuCo number(5) constraint fk_co_effectuer references Course(nuCo),
nuPilote number(5) constraint fk_pilote_effectuer references Pilote(nuPilote),
classement number(5) constraint ck_effectuer check (classement>0),
constraint pk_effectuer primary key (nuCo,nuPilote)
);
 
 
create table APPARTENIR(
nuPilote number(5) constraint fk_pilote_appartenir references Pilote(nuPilote),
nuEcurie number(5) constraint fk_ecurie_appartenir references Ecurie(nuEcurie),
annee number(4),
constraint pk_appartenir primary key (nuPilote, nuEcurie, annee)
);

--insertion des tuples
INSERT INTO PILOTE VALUES (1, 'HAMILTON','Lewis', 'Royaume-Uni');    
INSERT INTO PILOTE VALUES (2, 'MASSA', 'Felipe', 'Bresil');
INSERT INTO PILOTE VALUES (3, 'RAIKKONEN','Kimi', 'Finlande');
INSERT INTO PILOTE VALUES (4, 'KUBICA', 'Robert', 'Pologne');
INSERT INTO PILOTE VALUES (5, 'SCHUMACHER', 'Mickael', 'Allemagne');
INSERT INTO PILOTE VALUES (6, 'ALONSO','Fernando', 'Espagne'); 
INSERT INTO PILOTE VALUES (7, 'FISICHELLA', 'Giancarlo','Italie');

INSERT INTO CIRCUIT values (1, 'Silverstone','Grande-Bretagne');
INSERT INTO CIRCUIT values (2, 'Gilles-Villeneuve','Canada');
INSERT INTO CIRCUIT values (3, 'Shangai','Chine');

INSERT INTO ECURIE values (1, 'Ferrari');
INSERT INTO ECURIE values (2, 'McLarenMercedes');
INSERT INTO ECURIE values (3, 'Renault');
INSERT INTO ECURIE values (4, 'WilliamsBMW');
INSERT INTO ECURIE values (5, 'Force India');

INSERT INTO APPARTENIR values (1,2,2009);
INSERT INTO APPARTENIR values (1,2,2008);
INSERT INTO APPARTENIR values (1,2,2007);    
INSERT INTO APPARTENIR values (2,1,2009);
INSERT INTO APPARTENIR values (2,1,2008);
INSERT INTO APPARTENIR values (2,1,2007);
INSERT INTO APPARTENIR values (2,1,2006);
INSERT INTO APPARTENIR values (3,1,2009);
INSERT INTO APPARTENIR values (3,1,2008);
INSERT INTO APPARTENIR values (3,1,2007);
INSERT INTO APPARTENIR values (3,2,2006);
INSERT INTO APPARTENIR values (4,4,2009);
INSERT INTO APPARTENIR values (4,4,2008);
INSERT INTO APPARTENIR values (4,4,2007);
INSERT INTO APPARTENIR values (4,4,2006);
INSERT INTO APPARTENIR values (5,1,2006);
INSERT INTO APPARTENIR values (6,3,2009);
INSERT INTO APPARTENIR values (6,3,2008);
INSERT INTO APPARTENIR values (6,2,2007);
INSERT INTO APPARTENIR values (6,3,2006);
INSERT INTO APPARTENIR values (7,5,2009);
INSERT INTO APPARTENIR values (7,5,2008);
INSERT INTO APPARTENIR values (7,3,2007);
INSERT INTO APPARTENIR values (7,3,2006);


INSERT INTO COURSE values (1, 2006, 'pluie',1);
INSERT INTO COURSE values (2, 2006, 'sec',2);
INSERT INTO COURSE values (3, 2006, 'pluie',3);
INSERT INTO COURSE values (4, 2007, 'sec',1);
INSERT INTO COURSE values (5, 2007, 'sec',2);
INSERT INTO COURSE values (6, 2007, 'pluie',3);
INSERT INTO COURSE values (7, 2008, 'mix',1);
INSERT INTO COURSE values (8, 2008, 'sec',2);
INSERT INTO COURSE values (9, 2008, 'pluie',3);
INSERT INTO COURSE values (10, 2009, 'pluie',1);
INSERT INTO COURSE values (11, 2009, 'pluie',2);
INSERT INTO COURSE values (12, 2009, 'mix',3);


INSERT INTO EFFECTUER values (1,6,1);
INSERT INTO EFFECTUER values (1,5,2);
INSERT INTO EFFECTUER values (1,3,3);
INSERT INTO EFFECTUER values (1,2,5);
INSERT INTO EFFECTUER values (1,7,4);
INSERT INTO EFFECTUER values (2,6,1);
INSERT INTO EFFECTUER values (2,5,2);
INSERT INTO EFFECTUER values (2,7,3);
INSERT INTO EFFECTUER values (2,2,4);
INSERT INTO EFFECTUER values (3,5,1);
INSERT INTO EFFECTUER values (3,6,2);
INSERT INTO EFFECTUER values (3,7,3);
INSERT INTO EFFECTUER values (3,4,13);


INSERT INTO EFFECTUER values (4,3,1);
INSERT INTO EFFECTUER values (4,6,2);
INSERT INTO EFFECTUER values (4,1,3);
INSERT INTO EFFECTUER values (4,4,4);
INSERT INTO EFFECTUER values (4,2,5);
INSERT INTO EFFECTUER values (5,1,1);
INSERT INTO EFFECTUER values (5,3,5);
INSERT INTO EFFECTUER values (5,6,7);
INSERT INTO EFFECTUER values (5,5,8);
INSERT INTO EFFECTUER values (6,3,1);
INSERT INTO EFFECTUER values (6,6,2);
INSERT INTO EFFECTUER values (6,2,3);
INSERT INTO EFFECTUER values (6,7,11);

INSERT INTO EFFECTUER values (7,1,1);
INSERT INTO EFFECTUER values (7,3,4);
INSERT INTO EFFECTUER values (7,6,6);
INSERT INTO EFFECTUER values (7,2,13);
INSERT INTO EFFECTUER values (8,4,1);
INSERT INTO EFFECTUER values (8,2,4);
INSERT INTO EFFECTUER values (9,1,1);
INSERT INTO EFFECTUER values (9,2,2);
INSERT INTO EFFECTUER values (9,3,3);
INSERT INTO EFFECTUER values (9,6,4);
INSERT INTO EFFECTUER values (9,4,6);
INSERT INTO EFFECTUER values (9,7,17);

COMMIT;
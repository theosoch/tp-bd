-- 
-- TP n°1
-- 

-- Q.2

INSERT INTO PILOTE VALUES (8, 'TRULLI', 'Jarno', 'Italie');

INSERT INTO ECURIE VALUES (6, 'Lotus');

INSERT INTO CIRCUIT VALUES (4, 'Albert Park', 'Australie');

INSERT INTO COURSE VALUES (13, 2010, 'sec', 4);

INSERT INTO APPARTENIR VALUES (8, 6, 2010);

INSERT INTO EFFECTUER VALUES (13, 8, 24);

-- Q.3

CREATE TABLE CIRCUIT_DISTANCE AS SELECT * FROM CIRCUIT;

-- Q.4

ALTER TABLE CIRCUIT_DISTANCE ADD (
    distance NUMBER(4)
);

-- Q.5

UPDATE CIRCUIT_DISTANCE
SET distance = 5303
WHERE nuCi = 4;

-- Q.6

DELETE FROM CIRCUIT_DISTANCE WHERE nuCi = 4;

ALTER TABLE EFFECTUER DROP CONSTRAINT fk_co_effectuer;
ALTER TABLE EFFECTUER ADD CONSTRAINT fk_co_effectuer FOREIGN KEY(nuCo) REFERENCES COURSE ON DELETE CASCADE;

ALTER TABLE COURSE DROP CONSTRAINT fk_co_ci;
ALTER TABLE COURSE ADD CONSTRAINT fk_co_ci FOREIGN KEY(nuCi) REFERENCES CIRCUIT ON DELETE CASCADE;

DELETE FROM CIRCUIT WHERE nuCi = 4;

-- Q.7

DROP TABLE CIRCUIT_DISTANCE;

-- Q.8

DESC COURSE;

-- Q.9

SELECT
    T.table_name,
    C.column_name,
    C.data_type
FROM
    user_tables T,
    user_tab_columns C
WHERE
    T.table_name IN ('PILOTE', 'CIRCUIT', 'COURSE', 'EFFECTUER', 'ECURIE', 'APPATENIR')
    AND C.table_name = T.table_name
;

-- Q.10

-- INSERT INTO PILOTE VALUES (8, 'Dupont', 'Fabrice', 'France');
-- Cette requête échoue car il existe déjà un pilote n°8.

-- Q.11

-- INSERT INTO EFFECTUER VALUES (14, 7, 2);
-- Cette requête échoue car il manque une valeur d'attribut à insérer (ici, la météo de la course).

-- Q.12

ALTER TABLE PILOTE MODIFY nuPilote INTEGER;
ALTER TABLE PILOTE ADD CONSTRAINT PILOTE_nuPilote_value CHECK (
    0 <= nuPilote AND nuPilote <= 999999
);

-- Q.13

ALTER TABLE CIRCUIT MODIFY paysCi VARCHAR2(20) CONSTRAINT CIRCUIT_paysCi_not_null NOT NULL;
ALTER TABLE APPARTENIR MODIFY annee NUMBER(4) DEFAULT 2010;
ALTER TABLE APPARTENIR ADD CONSTRAINT APPARTENIR_annee_value CHECK (
    annee > 0
);

-- Q.14

SELECT
    Constraints.TABLE_NAME,
    ConstraintColumns.COLUMN_NAME,
    Constraints.CONSTRAINT_NAME,
    Constraints.R_CONSTRAINT_NAME,
    Constraints.CONSTRAINT_TYPE,
    Constraints.SEARCH_CONDITION,
    Constraints.SEARCH_CONDITION_VC,
    Constraints.DELETE_RULE
FROM USER_CONSTRAINTS Constraints, USER_CONS_COLUMNS ConstraintColumns
WHERE (
    ConstraintColumns.OWNER = Constraints.OWNER
    AND Constraints.TABLE_NAME IN ('PILOTE', 'CIRCUIT', 'COURSE', 'EFFECTUER', 'ECURIE', 'APPATENIR')
    AND ConstraintColumns.TABLE_NAME = Constraints.TABLE_NAME
    AND ConstraintColumns.CONSTRAINT_NAME = Constraints.CONSTRAINT_NAME
);

-- 

COMMIT;
-- 
-- TP n°2 - Partie n°2
-- 

-- 

-- 2.a
SELECT TABLE_NAME FROM ALL_TABLES
WHERE OWNER = 'GILLES_HUBERT' AND TABLE_NAME LIKE 'TP2_%';

-- 2.b
SELECT * FROM GILLES_HUBERT.TP2_PILOTE;
SELECT * FROM GILLES_HUBERT.TP2_EFFECTUERQUALIFICATION;
SELECT * FROM GILLES_HUBERT.TP2_EFFECTUER;
SELECT * FROM GILLES_HUBERT.TP2_ECURIE;
SELECT * FROM GILLES_HUBERT.TP2_COURSE;
SELECT * FROM GILLES_HUBERT.TP2_CIRCUIT;
SELECT * FROM GILLES_HUBERT.TP2_APPARTENIR;

-- 2.c
DESC GILLES_HUBERT.TP2_PILOTE;
DESC GILLES_HUBERT.TP2_EFFECTUERQUALIFICATION;
DESC GILLES_HUBERT.TP2_EFFECTUER;
DESC GILLES_HUBERT.TP2_ECURIE;
DESC GILLES_HUBERT.TP2_COURSE;
DESC GILLES_HUBERT.TP2_CIRCUIT;
DESC GILLES_HUBERT.TP2_APPARTENIR;

-- 2.d
SELECT
    ALL_CONSTRAINTS.TABLE_NAME,
    ALL_CONS_COLUMNS.COLUMN_NAME,
    ALL_CONSTRAINTS.CONSTRAINT_NAME,
    ALL_CONSTRAINTS.R_CONSTRAINT_NAME,
    ALL_CONSTRAINTS.CONSTRAINT_TYPE,
    ALL_CONSTRAINTS.SEARCH_CONDITION,
    ALL_CONSTRAINTS.SEARCH_CONDITION_VC,
    ALL_CONSTRAINTS.DELETE_RULE
FROM ALL_CONSTRAINTS, ALL_CONS_COLUMNS
WHERE (
    ALL_CONSTRAINTS.OWNER = 'GILLES_HUBERT'
    AND ALL_CONS_COLUMNS.OWNER = ALL_CONSTRAINTS.OWNER
    AND ALL_CONSTRAINTS.TABLE_NAME IN ('TP2_PILOTE', 'TP2_EFFECTUERQUALIFICATION', 'TP2_EFFECTUER', 'TP2_ECURIE', 'TP2_COURSE', 'TP2_CIRCUIT', 'TP2_APPARTENIR')
    AND ALL_CONS_COLUMNS.TABLE_NAME = ALL_CONSTRAINTS.TABLE_NAME
    AND ALL_CONS_COLUMNS.CONSTRAINT_NAME = ALL_CONSTRAINTS.CONSTRAINT_NAME
);

-- 

COMMIT;
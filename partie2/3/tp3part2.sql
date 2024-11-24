-- 
-- TP n°3 - Partie n°2
-- 

-- Q.1

SELECT
    C.*
FROM
    CHERCHEUR C
ORDER BY
    C.NomCh
ASC NULLS FIRST;

-- Q.2

SELECT
    C.CodeCh,
    C.NomCh,
    E.NomEq
FROM
    CHERCHEUR C,
    EQUIPE E
WHERE
    C.CodeEq = E.CodeEq
;

-- Q.3

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    EQUIPE E
WHERE
    E.NomEq = 'PSA'
    AND C.CodeEq = E.CodeEq
;

-- Q.4

SELECT
    COUNT(C.CodeCh) AS nbrChercheurs
FROM
    CHERCHEUR C,
    EQUIPE E
WHERE
    E.NomEq = 'FIRM'
    AND C.CodeEq = E.CodeEq
GROUP BY
    E.CodeEq
;

-- Q.5

SELECT
    L.CodeLabo,
    L.NomLabo,
    COUNT(C.CodeCh) AS nbrChercheurs
FROM
    CHERCHEUR C,
    EQUIPE E,
    LABORATOIRE L
WHERE
    E.CodeLabo = L.CodeLabo
    AND C.CodeEq = E.CodeEq
GROUP BY
    L.CodeLabo, L.NomLabo
;

-- Q.6

SELECT
    R.CodeEq,
    R.NomEq,
    R.nbrChercheurs
FROM
    (
        SELECT
            E.CodeEq,
            E.NomEq,
            COUNT(C.CodeCh) AS nbrChercheurs
        FROM
            CHERCHEUR C,
            EQUIPE E
        WHERE
            C.CodeEq = E.CodeEq
        GROUP BY
            E.CodeEq, E.NomEq
    ) R
WHERE
    R.nbrChercheurs >= 3
;

-- Q.7

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    (
        ( SELECT E.CodeEq FROM EQUIPE E )
        MINUS
        (
            SELECT
                E1.CodeEq
            FROM
                EQUIPE E1,
                EQUIPE E2
            WHERE
                ( E1.CodeEq != E2.CodeEq )
                AND E1.BUDGET < E2.BUDGET
        )
    ) R
WHERE
    C.CodeEq = R.CodeEq
;

-- Q.8

CREATE OR REPLACE VIEW
    NBR_CHERCHEURS_PAR_EQUIPE
AS (
    SELECT
        E.CodeEq,
        COUNT(C.CodeCh) AS nbrChercheurs
    FROM
        CHERCHEUR C,
        EQUIPE E
    WHERE
        C.CodeEq = E.CodeEq
    GROUP BY
        E.CodeEq, E.NomEq
);

SELECT
    E.CodeEq,
    E.NomEq,
    R.nbrChercheurs
FROM
    EQUIPE E,
    (
        ( SELECT * FROM NBR_CHERCHEURS_PAR_EQUIPE )
        MINUS
        (
            SELECT
                E1.*
            FROM
                NBR_CHERCHEURS_PAR_EQUIPE E1,
                NBR_CHERCHEURS_PAR_EQUIPE E2
            WHERE
                (E1.CodeEq != E2.CodeEq)
                AND E1.nbrChercheurs > E2.nbrChercheurs
        )
) R
WHERE
    E.CodeEq = R.CodeEq
;

-- Q.9

CREATE OR REPLACE VIEW
    NBR_THEMES_PAR_CHERCHEUR
AS (
    SELECT
        T.CodeCh,
        COUNT(T.CodeTh) as nbrThemes
    FROM
        TRAVAILLER T
    GROUP BY
        T.CodeCh
);

SELECT
    C.CodeCh,
    C.NomCh,
    R.nbrThemes
FROM
    CHERCHEUR C,
    (
        ( SELECT * FROM NBR_THEMES_PAR_CHERCHEUR )
        MINUS
        (
            SELECT
                X1.*
            FROM
                NBR_THEMES_PAR_CHERCHEUR X1,
                NBR_THEMES_PAR_CHERCHEUR X2
            WHERE
                ( X1.CodeCh != X2.CodeCh )
                AND X1.nbrThemes < X2.nbrThemes
        )
    ) R
WHERE
    C.CodeCh = R.CodeCh
;

-- Q.10

CREATE OR REPLACE VIEW
    NBR_CHERCHEURS_PAR_THEME
AS (
    SELECT
        T.CodeTh,
        COUNT(T.CodeCh) as nbrChercheurs
    FROM
        TRAVAILLER T
    GROUP BY
        T.CodeTh
);

SELECT
    T.CodeTh,
    T.Libelle,
    R.nbrChercheurs
FROM
    THEME T,
    (
        ( SELECT * FROM NBR_CHERCHEURS_PAR_THEME )
        MINUS
        (
            SELECT
                X1.*
            FROM
                NBR_CHERCHEURS_PAR_THEME X1,
                NBR_CHERCHEURS_PAR_THEME X2
            WHERE
                ( X1.CodeTh != X2.CodeTh )
                AND X1.nbrChercheurs < X2.nbrChercheurs
        )
    ) R
WHERE
    T.CodeTh = R.CodeTh
;

-- Q.11

CREATE OR REPLACE VIEW
    SALAIRE_MOYEN_PAR_LABO
AS (
    SELECT
        L.CodeLabo,
        AVG(C.Salaire) AS salaireMoyen
    FROM
        LABORATOIRE L,
        EQUIPE E,
        CHERCHEUR C
    WHERE
        E.CodeLabo = L.CodeLabo
        AND C.CodeEq = E.CodeEq
    GROUP BY
        L.CodeLabo
);

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    EQUIPE E,
    LABORATOIRE L,
    SALAIRE_MOYEN_PAR_LABO SMPL
WHERE
    E.CodeLabo = L.CodeLabo
    AND SMPL.CodeLabo = L.CodeLabo
    AND C.CodeEq = E.CodeEq
    AND C.Salaire > SMPL.salaireMoyen
ORDER BY
    C.CodeCh
ASC NULLS FIRST;

-- Q.12

CREATE OR REPLACE VIEW
    CHERCHEURS_EQ5
AS (
    SELECT C.* FROM CHERCHEUR C WHERE C.CodeEq = 5
);

( SELECT C.* FROM CHERCHEURS_EQ5 C )
MINUS
(
    SELECT
        C1.*
    FROM
        CHERCHEURS_EQ5 C1,
        CHERCHEURS_EQ5 C2
    WHERE
        ( C1.CodeCh != C2.CodeCh )
        AND C1.Salaire <= C2.Salaire
);

( SELECT C.* FROM CHERCHEURS_EQ5 C )
MINUS
(
    SELECT
        C1.*
    FROM
        (SELECT C.* FROM CHERCHEUR C WHERE C.CodeEq = 5) C1,
        (SELECT C.* FROM CHERCHEUR C WHERE C.CodeEq = 5) C2
    WHERE
        ( C1.CodeCh != C2.CodeCh )
        AND C1.Salaire <= C2.Salaire
);

-- Q.13

CREATE OR REPLACE VIEW
    THEMES_EQUIPE_PSA
AS (
    SELECT DISTINCT
        TR.CodeTh
    FROM
        TRAVAILLER TR,
        EQUIPE E,
        CHERCHEUR C
    WHERE
        E.NomEq = 'PSA'
        AND C.CodeEq = E.CodeEq
        AND TR.CodeCh = C.CodeCh
);

CREATE OR REPLACE VIEW
    THEMES_EQUIPE_SMM
AS (
    SELECT DISTINCT
        TR.CodeTh
    FROM
        TRAVAILLER TR,
        EQUIPE E,
        CHERCHEUR C
    WHERE
        E.NomEq = 'SMM'
        AND C.CodeEq = E.CodeEq
        AND TR.CodeCh = C.CodeCh
);

SELECT * FROM THEMES_EQUIPE_PSA;
SELECT * FROM THEMES_EQUIPE_SMM;

( SELECT * FROM THEMES_EQUIPE_PSA )
MINUS
( SELECT * FROM THEMES_EQUIPE_SMM );

-- Q.14

SELECT DISTINCT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    TRAVAILLER TR,
    THEME TH
WHERE
    (
        TH.Libelle = 'SYSTEMES DINFORMATION GEOGRAPHIQUE'
        OR TH.Libelle = 'SYSTEMES HYPERMEDIA'
    )
    AND TR.CodeTh = TH.CodeTh
    AND C.CodeCh = TR.CodeCh
;

-- Q.15

CREATE OR REPLACE VIEW
    CH_THEME_MOD_MATH
AS (
    SELECT
        C.CodeCh,
        C.NomCh
    FROM
        CHERCHEUR C,
        TRAVAILLER TR,
        THEME TH
    WHERE
        TH.Libelle = 'MODELISATION MATHEMATIQUE'
        AND TR.CodeTh = TH.CodeTh
        AND C.CodeCh = TR.CodeCh
);

CREATE OR REPLACE VIEW
    CH_THEME_GENIE_LOGICIEL
AS (
    SELECT
        C.CodeCh,
        C.NomCh
    FROM
        CHERCHEUR C,
        TRAVAILLER TR,
        THEME TH
    WHERE
        TH.Libelle = 'GENIE-LOGICIEL'
        AND TR.CodeTh = TH.CodeTh
        AND C.CodeCh = TR.CodeCh
);

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    CH_THEME_MOD_MATH C1,
    CH_THEME_GENIE_LOGICIEL C2
WHERE
    C.CodeCh = C1.CodeCh
    AND C.CodeCh = C2.CodeCh
;

-- Q.16

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    CH_THEME_MOD_MATH C1,
    (
        ( SELECT C.CodeCh FROM CHERCHEUR C )
        MINUS
        ( SELECT C.CodeCh FROM CH_THEME_GENIE_LOGICIEL C )
    ) C2
WHERE
    C.CodeCh = C1.CodeCh
    AND C.CodeCh = C2.CodeCh
;

-- Q.17

SELECT
    C.CodeCh,
    C.NomCh
FROM
    CHERCHEUR C,
    CHERCHEUR C1
WHERE
    C1.NomCh = 'STEMMERA'
    AND C.CodeCh != C1.CodeCh
    AND C.CodeEq = C1.CodeEq
;

-- Q.18

SELECT DISTINCT
    C.NomCh
FROM
    CHERCHEUR C,
    (
        ( SELECT C.CodeCh FROM CHERCHEUR C )
        MINUS
        (
            SELECT DISTINCT
                R.CodeCh
            FROM
                (
                    (
                        SELECT
                            C.CodeCh,
                            TH.CodeTh
                        FROM
                            CHERCHEUR C,
                            THEME TH
                    )
                    MINUS
                    ( SELECT TR.CodeCh, TR.CodeTh FROM TRAVAILLER TR )
                ) R
        )
    ) R
WHERE
    C.CodeCh = R.CodeCh
;

-- 

COMMIT;
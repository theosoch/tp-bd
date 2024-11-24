-- 
-- TP n°3 - Partie n°1
-- 

-- Q.1

CREATE OR REPLACE VIEW
    CHERCHEUR_2400
AS (
    SELECT
        C.CodeCh,
        C.NomCh,
        C.Salaire
    FROM
        CHERCHEUR C
    WHERE
        C.Salaire >= 2400
);

INSERT INTO CHERCHEUR
VALUES (15, 'Thierry', 2, 2600);

SELECT * FROM CHERCHEUR;
SELECT * FROM CHERCHEUR_2400;

-- Q.2

CREATE OR REPLACE VIEW
    CHERCHEUR_EQ1
AS (
    SELECT
        C.CodeCh,
        C.NomCh
    FROM
        CHERCHEUR C
    WHERE
        C.CodeEq = 1
);

INSERT INTO CHERCHEUR
VALUES (14, 'RENAUD', 1, 2500);

SELECT * FROM CHERCHEUR_EQ1;

UPDATE CHERCHEUR_EQ1
SET NomCh='RENAUDIN'
WHERE CodeCh = 14;

INSERT INTO CHERCHEUR_EQ1
VALUES (18, 'LALANDE');

DELETE FROM CHERCHEUR
WHERE CodeCh = 18;

-- On constate que le chercheur a bien été inséré dans la table
-- CHERCHEUR mais n'est pas dans la vue CHERCHEUR_EQ1 car il ne fait pas
-- partie de l'équipe n°1.

-- 

COMMIT;
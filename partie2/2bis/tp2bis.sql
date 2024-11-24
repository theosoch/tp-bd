-- 
-- TP n°2bis
-- 

-- Q.1

-- ALTER TABLE PILOTE DROP (nbVictoires);

ALTER TABLE
    PILOTE
ADD (
    nbVictoires NUMBER DEFAULT 0
);

-- Q.2

UPDATE
    PILOTE P
SET
    P.nbVictoires = (
        SELECT
            COUNT(E.nuCo) + 0
        FROM
            EFFECTUER E
        WHERE
            E.nuPilote = P.nuPilote
            AND E.classement = 1
        GROUP BY
            P.nuPilote
    ) || (
        SELECT
            0 AS nbVictoires
        FROM
            (
                ( SELECT P1.nuPilote FROM PILOTE P1 WHERE P1.nuPilote = P.nuPilote )
                MINUS
                (
                    SELECT DISTINCT
                        nuPilote
                    FROM
                        EFFECTUER E
                    WHERE
                        E.classement = 1
                        AND P.nuPilote = E.nuPilote
                )
            ) P
    )
;

-- Q.3

SELECT * FROM PILOTE WHERE ROWNUM <= 3;

-- SELECT
--     *
-- FROM
--     PILOTE P
-- WHERE
--     ROWNUM <= 3
-- ORDER BY
--     P.nbVictoires
-- DESC NULLS FIRST;

-- Q.4

SELECT
    E.*
FROM
    (
        SELECT
            P.nuPilote
        FROM
            PILOTE P
        WHERE
            P.nbVictoires > 0
    ) P,
    EFFECTUER E
WHERE
    E.nuCo = 1
    AND P.nuPilote = E.nuPilote
;

-- Q.5

SELECT
    E.*
FROM
    PILOTE P,
    EFFECTUER E
WHERE
    E.nuCo = 1
    AND E.classement = 3
    AND P.nuPilote = E.nuPilote
;

-- 

COMMIT;
-- 
-- TP n°1
-- 

-- Q.0.a

SELECT * FROM PILOTE;

-- Q.0.b

SELECT nomPilote, nuPilote FROM PILOTE;

-- Q.0bis.a

SELECT COURSE.nuCi FROM COURSE;

-- Q.0bis.b

SELECT DISTINCT nuCi FROM COURSE;

-- Q.1

SELECT anneeCo, meteo
FROM COURSE
WHERE nuCi = 2;

-- Q.2bis

SELECT nuCo, anneeCo, meteo
FROM COURSE
WHERE nuCi = 2
ORDER BY anneeCo ASC NULLS FIRST;

-- Q.3

SELECT nuCi, nomCi, paysCi, longueurCi
FROM CIRCUIT
ORDER BY paysCi DESC NULLS FIRST;

-- Q.4

SELECT DISTINCT nomPilote
FROM PILOTE
WHERE nomPilote LIKE 'F%';

-- Q.5

SELECT nuPilote
FROM APPARTENIR
WHERE 
    (nuEcurie = 1 OR nuEcurie = 2)
    AND annee = 2009
;

-- Q.6

SELECT nuPilote
FROM EFFECTUER
WHERE
    nuCo = 9
    AND classement <= 3
;

-- Q.7

SELECT nuCi, nomCi, ((longueurCi * nbTours) / 1000) AS DistanceTotale
FROM CIRCUIT;

-- Q.8

SELECT COUNT(*) AS nbCircuits FROM CIRCUIT;

-- Q.9

SELECT AVG(temps) AS tempsAvg
FROM EFFECTUER
WHERE nuCo = 1;

-- Q.10

SELECT AVG(temps) AS tempsAvg, nuCo
FROM EFFECTUER
GROUP BY nuCo
ORDER BY tempsAvg ASC NULLS FIRST;

-- Q.11

SELECT AVG(E.temps) AS tempsAvg, E.nuCo
FROM EFFECTUER E
GROUP BY E.nuCo
HAVING AVG(E.temps) < 5000;

-- Q.12

SELECT DISTINCT
    A1.nuPilote,
    COUNT(DISTINCT(A1.nuEcurie)) AS nbEcuriesPassees
FROM
    APPARTENIR A1,
    APPARTENIR A2
WHERE
    A1.nuEcurie != A2.nuEcurie
GROUP BY
    A1.nuPilote
HAVING
    COUNT(DISTINCT(A1.nuEcurie)) >= 2
;

-- Q.13.a

SELECT nuCo, anneeCo, nomCi, paysCi
FROM COURSE, CIRCUIT;

-- Q.13.b

SELECT nuCo, anneeCo, nomCi, paysCi
FROM COURSE, CIRCUIT
WHERE COURSE.nuCi = CIRCUIT.nuCi;

-- Q.13bis

SELECT DISTINCT nomCi, paysCi
FROM CIRCUIT, COURSE
WHERE
    meteo = 'pluie'
    AND CIRCUIT.nuCi = COURSE.nuCi
;

-- Q.14

SELECT DISTINCT
    nomPilote,
    prenomPilote,
    nationalite
FROM
    PILOTE P,
    APPARTENIR A,
    ECURIE E
WHERE
    E.nomEcurie = 'Ferrari'
    AND A.nuEcurie = E.nuEcurie
    AND P.nuPilote = A.nuPilote
;

-- Q.15

-- SELECT DISTINCT
--     nomPilote,
--     prenomPilote,
--     nationalite
-- FROM
--     PILOTE P INNER JOIN (
--         APPARTENIR A INNER JOIN (
--             SELECT nuEcurie
--             FROM ECURIE E
--             WHERE E.nomEcurie = 'Ferrari'
--         ) ON A.nuEcurie = E.nuEcurie
--     ) R1 ON R1.nuPilote = P.nuPilote
-- ;

SELECT DISTINCT
    nomPilote,
    prenomPilote,
    nationalite
FROM
    PILOTE P,
    APPARTENIR A,
    ECURIE E
WHERE
    E.nomEcurie = 'Ferrari'
    AND A.nuEcurie = E.nuEcurie
    AND A.annee = 2006
    AND P.nuPilote = A.nuPilote
;

-- Q.16

SELECT
    nomPilote,
    prenomPilote,
    nationalite
FROM
    PILOTE P,
    EFFECTUER E,
    COURSE CO,
    CIRCUIT CI
WHERE
    CI.nomCi = 'Silverstone'
    AND CO.nuCi = CI.nuCi
    AND E.nuCo = CO.nuCo
    AND E.classement = 1
    AND P.nuPilote = E.nuPilote
;

-- Q.17

SELECT DISTINCT
    P.nomPilote,
    P.prenomPilote,
    P.nationalite,
    E.tempsTour
FROM
    PILOTE P,
    EFFECTUER E,
    COURSE CO,
    CIRCUIT CI
WHERE
    CI.nomCi = 'Silverstone'
    AND CO.nuCi = CI.nuCi
    AND E.nuCo = CO.nuCo
    AND E.classement = 1
    AND P.nuPilote = E.nuPilote
;

-- Q.18

-- ???

-- Q.19

(
    SELECT *
    FROM
        (
            SELECT nuCi
            FROM CIRCUIT
        ) CI1
)
MINUS
(
    SELECT
        CI.nuCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.nuCi = CI.nuCi
);

-- Q.20

(
    SELECT DISTINCT
        P.nomPilote,
        P.prenomPilote
    FROM
        PILOTE P,
        EFFECTUER E,
        COURSE CO,
        CIRCUIT CI
    WHERE
        CI.nomCi = 'Silverstone'
        AND CO.nuCi = CI.nuCi
        AND E.nuCo = CO.nuCo
        AND E.classement = 1
        AND P.nuPilote = E.nuPilote
)
INTERSECT
(
    SELECT DISTINCT
        P.nomPilote,
        P.prenomPilote
    FROM
        PILOTE P,
        EFFECTUER E,
        COURSE CO,
        CIRCUIT CI
    WHERE
        CI.nomCi = 'Gilles-Villeneuve'
        AND CO.nuCi = CI.nuCi
        AND E.nuCo = CO.nuCo
        AND E.classement = 1
        AND P.nuPilote = E.nuPilote
);

-- Q.21

(SELECT DISTINCT nomCi FROM CIRCUIT)
MINUS
(
    SELECT DISTINCT
        CI.nomCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.anneeCo = 2009
        AND CI.nuCi = CO.nuCi
);

-- Q.22

(
    SELECT DISTINCT
        CI.nomCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.anneeCo < 2009
        AND CI.nuCi = CO.nuCi
)
MINUS
(
    SELECT DISTINCT
        CI.nomCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.anneeCo = 2009
        AND CI.nuCi = CO.nuCi
);

-- Q.23

(
    SELECT DISTINCT
        CI.nomCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.anneeCo = 2009
        AND CI.nuCi = CO.nuCi
)
MINUS
(
    SELECT DISTINCT
        CI.nomCi
    FROM
        CIRCUIT CI,
        COURSE CO
    WHERE
        CO.anneeCo < 2009
        AND CI.nuCi = CO.nuCi
);

-- Q.24

SELECT DISTINCT
    P.nomPilote,
    E.nuCo
FROM
    PILOTE P,
    EFFECTUER E,
    EFFECTUERQUALIFICATION EQ
WHERE
    (
        E.nuCo = EQ.nuCo
        AND E.nuPilote = EQ.nuPilote
    )
    AND E.classement < EQ.classement
    AND P.nuPilote = E.nuPilote
ORDER BY
    E.nuCo
;

-- Q.25

SELECT DISTINCT
    P.nomPilote,
    E.nuCo
FROM
    PILOTE P,
    EFFECTUER E,
    EFFECTUERQUALIFICATION EQ
WHERE
    (
        E.nuCo = EQ.nuCo
        AND E.nuPilote = EQ.nuPilote
    )
    AND E.classement = EQ.classement
    AND P.nuPilote = E.nuPilote
ORDER BY
    E.nuCo
;

-- Q.26

(
    SELECT
        EQ.nuCo, P.nomPilote
    FROM
        PILOTE P,
        EFFECTUERQUALIFICATION EQ
    WHERE
        P.nuPilote = EQ.nuPilote
)
MINUS
(
    SELECT DISTINCT
        EQ.nuCo, P.nomPilote
    FROM
        PILOTE P,
        EFFECTUER E,
        EFFECTUERQUALIFICATION EQ
    WHERE
        (
            E.nuCo = EQ.nuCo
            AND E.nuPilote = EQ.nuPilote
        )
    AND P.nuPilote = E.nuPilote
);

-- Q.27

SELECT DISTINCT
    E.nomEcurie,
    A.annee,
    COUNT(A.nuPilote)
FROM
    ECURIE E,
    APPARTENIR A
WHERE
    E.nuEcurie = A.nuEcurie
GROUP BY
    E.nomEcurie, A.annee
;

-- Q.28


(
    SELECT
        P.nomPilote,
        P.prenomPilote
    FROM
        PILOTE P,
        EFFECTUER E
    WHERE
        E.nuCo = 5
        AND P.nuPilote = E.nuPilote
)
MINUS
(
    SELECT
        P.nomPilote,
        P.prenomPilote
    FROM
        PILOTE P,
        EFFECTUER E1,
        EFFECTUER E2
    WHERE
        E1.nuCo = 5
        AND E2.nuCo = 5
        AND E2.nuPilote != E1.nuPilote
        AND E1.temps >= E2.temps
        AND P.nuPilote = E1.nuPilote
);

-- Q.29

SELECT
    CI.nomCi
FROM
    CIRCUIT CI,
    (
        (
            SELECT
                CI.nuCi,
                COUNT(CO.nuCo) AS courseCount
            FROM
                CIRCUIT CI,
                COURSE CO
            WHERE
                CO.nuCi = CI.nuCi
            GROUP BY
                CO.nuCi
        )
        MINUS (
            SELECT CI1.nuCi, CI1.courseCount
            FROM
                (
                    SELECT
                        CI.nuCi,
                        COUNT(CO.nuCo) AS courseCount
                    FROM
                        CIRCUIT CI,
                        COURSE CO
                    WHERE
                        CO.nuCi = CI.nuCi
                    GROUP BY
                        CO.nuCi
                ) CI1,
                (
                    SELECT
                        CI.nuCi,
                        COUNT(CO.nuCo) AS courseCount
                    FROM
                        CIRCUIT CI,
                        COURSE CO
                    WHERE
                        CO.nuCi = CI.nuCi
                    GROUP BY
                        CO.nuCi
                ) CI2
            WHERE CI1.courseCount < CI2.courseCount
        )
    ) R
WHERE
    CI.nuCi = R.nuCi
;

-- Q.30

SELECT
    P.nomPilote,
    P.prenomPilote
FROM
    PILOTE P,
    (
        (
            SELECT
                P.nuPilote,
                COUNT(E.classement) AS firstCount
            FROM
                PILOTE P,
                EFFECTUER E
            WHERE
                E.classement = 1
                AND P.nuPilote = E.nuPilote
            GROUP BY P.nuPilote
        )
        MINUS
        (
            SELECT
                P1.nuPilote,
                P1.firstCount
            FROM
                (
                    SELECT
                        P.nuPilote,
                        COUNT(E.classement) AS firstCount
                    FROM
                        PILOTE P,
                        EFFECTUER E
                    WHERE
                        E.classement = 1
                        AND P.nuPilote = E.nuPilote
                    GROUP BY P.nuPilote
                ) P1,
                (
                    SELECT
                        P.nuPilote,
                        COUNT(E.classement) AS firstCount
                    FROM
                        PILOTE P,
                        EFFECTUER E
                    WHERE
                        E.classement = 1
                        AND P.nuPilote = E.nuPilote
                    GROUP BY P.nuPilote
                ) P2
            WHERE
                P1.firstCount < P2.firstCount
        )
    ) R
WHERE
    P.nuPilote = R.nuPilote
;

-- Q.31

SELECT 
    P.nomPilote,
    (E.temps / CI.nbTours) AS tempMoyen,
    E.tempsTour,
    E.nuCo
FROM
    PILOTE P,
    EFFECTUER E,
    COURSE CO,
    CIRCUIT CI
WHERE
    CO.nuCi = CI.nuCi
    AND E.nuCo = CO.nuCo
    AND P.nuPilote = E.nuPilote
    AND (E.temps / CI.nbTours) <= (1.05*E.tempsTour)
;

-- Q.32

SELECT
    P.nomPilote,
    R.nuCo
FROM
    PILOTE P,
    (
        (
            SELECT
                E.nuPilote,
                E.nuCo
            FROM
                EFFECTUER E
            WHERE
                E.classement > 1
        )
        MINUS
        (
            SELECT
                E1.nuPilote,
                E1.nuCo
            FROM
                EFFECTUER E1,
                EFFECTUER E2
            WHERE
                (
                    R1.nuPilote != R2.nuPilote
                    AND R1.nuCo = R2.nuCo
                )
                AND (
                    E1.classement > 1
                    AND E2.classement > 1
                )
                AND R1.tempsTour >= R2.tempsTour
        )
    ) R
WHERE
    P.nuPilote = R.nuPilote
ORDER BY
    R.nuCo
ASC NULLS FIRST;

-- Q.33

SELECT DISTINCT
    R1.nuCo
FROM
    (
        (
            SELECT
                EQ.nuPilote,
                EQ.nuCo,
                EQ.tempsTour
            FROM
                EFFECTUERQUALIFICATION EQ
        )
        MINUS
        (
            SELECT
                EQ1.nuPilote,
                EQ1.nuCo,
                EQ1.tempsTour
            FROM
                EFFECTUERQUALIFICATION EQ1,
                EFFECTUERQUALIFICATION EQ2
            WHERE
                (
                    EQ1.nuPilote != EQ2.nuPilote
                    AND EQ1.nuCo = EQ2.nuCo
                )
                AND EQ1.tempsTour >= EQ2.tempsTour
        )
    ) R1,
    (
        (
            SELECT
                E.nuPilote,
                E.nuCo,
                E.tempsTour
            FROM
                EFFECTUER E
        )
        MINUS
        (
            SELECT
                E1.nuPilote,
                E1.nuCo,
                E1.tempsTour
            FROM
                EFFECTUER E1,
                EFFECTUER E2
            WHERE
                (
                    E1.nuPilote != E2.nuPilote
                    AND E1.nuCo = E2.nuCo
                )
                AND E1.tempsTour >= E2.tempsTour
        )
    ) R2
WHERE
    (
        R1.nuCo = R2.nuCo
    )
    AND R1.tempsTour > R2.tempsTour
;
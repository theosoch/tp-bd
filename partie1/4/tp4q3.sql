-- 
-- TP n°4 - Question n°2
-- 

-- 

INSERT INTO Stade
VALUES (1, 'Stade 1', 'Toulouse');

-- 

INSERT INTO Matchs
VALUES (1, 'Equipe A', 'Equipe B', TO_DATE('11/06/2019'), '19:00-22:00', 1);

-- 

INSERT INTO Buvette
VALUES (1, 'Aile Ouest', 1);

INSERT INTO Buvette
VALUES (2, 'Aile Est', 1);

-- 

INSERT INTO Employe
VALUES (1, 'Deschamps', 'Fleur', TO_DATE('04/03/1995'));

-- 

INSERT INTO Fournisseur
VALUES (1, 'SoGood', '21 rue de la République', 75000, 'Paris');

INSERT INTO Fournisseur
VALUES (2, 'SoBon', '11 route de Paris', 35000, 'Rennes');

-- 

INSERT INTO Travailler
VALUES (1, 1, 1, '19:00', '20:00');

INSERT INTO Travailler
VALUES (1, 1, 2, '20:30', '22:00');

-- 

INSERT INTO Produit
VALUES (1, 'Sandwichs chèvre tomate', 'salé', 'végétarien');

INSERT INTO Produit
VALUES (2, 'Donuts chocolat', 'sucré', 'végétarien');

INSERT INTO Produit(NumP, DescriptionP, TypeP, Categorie)
VALUES (3, 'Sandwichs thon mayo', 'salé', 'viande');

-- 

INSERT INTO Fournir
VALUES (1, 1, 1, TO_DATE('11/06/2019'), 250, 1.60);

INSERT INTO Fournir
VALUES (1, 2, 1, TO_DATE('11/06/2019'), 130, 1.25);

INSERT INTO Fournir
VALUES (2, 3, 1, TO_DATE('11/06/2019'), 130, 1.35);

-- 

COMMIT;
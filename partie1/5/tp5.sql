-- 
-- TP n°5
-- 

-- Q.1

-- SELECT * FROM GILLES_HUBERT.tp4_buvettes;

INSERT INTO Employe(NumE, Nom, Prenom, DateNaissance)
SELECT DISTINCT NumE, Nom, Prenom, DateNaissance
FROM GILLES_HUBERT.tp4_buvettes
WHERE NumE IS NOT NULL;

-- INSERT INTO Matchs(NumM, Equipe1, Equipe2, DateM, HeureM, NumS)
SELECT DISTINCT NumM, Equipe1, Equipe2, DateM, HeureM, NumS
FROM GILLES_HUBERT.tp4_buvettes
WHERE NumM IS NOT NULL;

INSERT INTO Buvette(NumB, Emplacement, NumS)
SELECT DISTINCT NumB, Emplacement, NumS
FROM GILLES_HUBERT.tp4_buvettes
WHERE NumB IS NOT NULL;

INSERT INTO Stade(NumS, NomS, VilleS)
SELECT DISTINCT NumS, NomS, Ville
FROM GILLES_HUBERT.tp4_buvettes;

INSERT INTO Produit(NumP, DescriptionP, TypeP, Categorie)
SELECT DISTINCT NumP, 'Description', 'Type', Categorie
FROM GILLES_HUBERT.tp4_buvettes;

INSERT INTO Fournisseur(NumF, NomF, LigneAdresse, CodePostal, VilleF)
SELECT DISTINCT NumF, NomF, LigneAdresse, CodePostal, VilleF
FROM GILLES_HUBERT.tp4_buvettes;

INSERT INTO Travailler(NumE, NumM, NumB, HeureDebut, HeureFin)
SELECT DISTINCT NumE, NumM, NumB, HeureDebut, HeureFin
FROM GILLES_HUBERT.tp4_buvettes;

INSERT INTO Fournir(NumF, NumP, NumS, DateL, Quantite, PrixUnitaire)
SELECT DISTINCT NumF, NumP, NumS, DateL, Quantite, PrixUnitaire
FROM GILLES_HUBERT.tp4_buvettes;

-- 

COMMIT;
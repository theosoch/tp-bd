-- 
-- TP n°2 - Partie n°1
-- 

-- 

SELECT * FROM Moniteur;
SELECT * FROM Specialite;
SELECT * FROM Cours;
SELECT * FROM Adherent;
SELECT * FROM Materiel;
SELECT * FROM Suivre;
SELECT * FROM Louer;

-- 

-- 4.a
DELETE FROM Materiel
WHERE Materiel.typeMateriel = 'Raquette';

-- 4.b
DELETE FROM Suivre
WHERE Suivre.numAdherent = 1 AND Suivre.codeCours = 3;

-- 4.c
-- Cette requête rencontre un problème car il existe déjà une association "suivre" entre le cours 2 et un adhérent.
-- On peut alors faire deux choses :
--  - soit supprimer l'association (à savoir la ligne correspondante dans la table `Suivre`)
--  - soit rajouter la contrainte "ON DELETE CASCADE" à l'attribut (ou aux attributs, dans le cas d'un couple de valeurs formant une seule clés) correspondant à la clés étrangère `Suivre.numAdherent`.
-- J'ai fait le choix de mettre en place la seconde option, car on peut considérer que lorsqu'un cours est supprimé, ses adhérent ne le suivent logiquement plus.
-- On peut faire ce même raisonnement pour adhérent et ajouter la contrainte "ON DELETE CASCADE" à `Suivre.codeCours`.
DELETE FROM Cours WHERE Cours.codeCours = 2;

-- 4.d
UPDATE Adherent SET Adherent.adresse = '23 route de Toulouse, Saint-Gaudens'
WHERE Adherent.nom = 'Lars' AND Adherent.prenom = 'Julien';

-- 4.e
UPDATE Materiel SET Materiel.prix = Materiel.prix*1.1;

-- 4.f
UPDATE Materiel SET Materiel.qteDispo = Materiel.qteDispo+2
WHERE Materiel.codeMateriel = 1;

-- 

COMMIT;
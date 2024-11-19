-- 
-- TP n°1
-- 

-- 

DROP TABLE Suivre;
DROP TABLE Cours;
DROP TABLE Moniteur;
DROP TABLE Specialite;
DROP TABLE Louer;
DROP TABLE Adherent;
DROP TABLE Materiel;

-- 

CREATE TABLE Moniteur (
    numMoniteur NUMBER,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    dateNaissance DATE NOT NULL,

    CONSTRAINT Moniteur_primaryKey PRIMARY KEY(numMoniteur)
);

-- 

CREATE TABLE Specialite (
    idSpecialite NUMBER,
    nom VARCHAR(255),

    CONSTRAINT Specialite_primaryKey PRIMARY KEY(idSpecialite)
);

ALTER TABLE Specialite
ADD CONSTRAINT Specialite_values_nom CHECK (
    nom = 'ski'
    OR nom = 'snowboard'
    OR nom = 'raquette'
);

-- 

CREATE TABLE Materiel (
    codeMateriel NUMBER,
    typeMateriel VARCHAR(255) NOT NULL,
    marque VARCHAR(255) NOT NULL,
    prix NUMBER NOT NULL,
    qteDispo NUMBER NOT NULL,

    CONSTRAINT Materiel_primaryKey PRIMARY KEY(codeMateriel)
);

ALTER TABLE Materiel
ADD CONSTRAINT Materiel_values_prix CHECK (
    prix > 0
);

ALTER TABLE Materiel
ADD CONSTRAINT Materiel_values_qteDispo CHECK (
    qteDispo > 0
);

-- 

CREATE TABLE Adherent (
    numAdherent NUMBER,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    tel VARCHAR(255),
    age NUMBER NOT NULL,

    CONSTRAINT Adherent_primaryKey PRIMARY KEY(numAdherent)
);

ALTER TABLE Adherent
ADD CONSTRAINT Adherent_values_age CHECK (
    age > 12 AND age < 100
);

-- 

CREATE TABLE Cours (
    codeCours NUMBER,
    niveau VARCHAR(255) NOT NULL,
    nbPlaces NUMBER NOT NULL,
    dateCours DATE NOT NULL,
    numMoniteur NUMBER NOT NULL,
    idSpecialite NUMBER,

    CONSTRAINT Cours_primaryKey PRIMARY KEY(codeCours)
);
    
ALTER TABLE Cours
ADD CONSTRAINT Cours_foreignKey_numMoniteur FOREIGN KEY(numMoniteur) REFERENCES Moniteur ON DELETE CASCADE;
    
ALTER TABLE Cours
ADD CONSTRAINT Cours_foreignKey_idSpecialite FOREIGN KEY(idSpecialite) REFERENCES Specialite;

ALTER TABLE Cours
ADD CONSTRAINT Cours_values_niveau CHECK (
    niveau = 'debutant'
    OR niveau = 'moyen'
    OR niveau = 'confirme'
    OR niveau = 'competition'
);

ALTER TABLE Cours
ADD CONSTRAINT Cours_values_nbPlaces CHECK (
    nbPlaces > 0
);

-- 

CREATE TABLE Suivre (
    numAdherent NUMBER,
    codeCours NUMBER,

    CONSTRAINT Suivre_foreignKey_numAdherent FOREIGN KEY(numAdherent) REFERENCES Adherent ON DELETE CASCADE,
    CONSTRAINT Suivre_foreignKey_codeCours FOREIGN KEY(codeCours) REFERENCES Cours ON DELETE CASCADE,
    
    CONSTRAINT Suivre_primaryKey PRIMARY KEY(numAdherent, codeCours)
);

-- 

CREATE TABLE Louer (
    numAdherent NUMBER,
    codeMateriel NUMBER,
    quantite NUMBER NOT NULL,

    CONSTRAINT Louer_foreignKey_numAdherent FOREIGN KEY(numAdherent) REFERENCES Adherent ON DELETE CASCADE,
    CONSTRAINT Louer_foreignKey_codeMateriel FOREIGN KEY(codeMateriel) REFERENCES Materiel ON DELETE CASCADE,

    CONSTRAINT Louer_primaryKey PRIMARY KEY(numAdherent, codeMateriel)
);

ALTER TABLE Louer
ADD CONSTRAINT Louer_values_quantite CHECK (
    quantite > 0
);

-- 

INSERT INTO Moniteur(numMoniteur, nom, prenom, adresse, dateNaissance)
VALUES (1, 'Dupond', 'Jean', '12 route du col, Germ', TO_DATE('01-01-1980'));

INSERT INTO Moniteur(numMoniteur, nom, prenom, adresse, dateNaissance)
VALUES (2, 'Martin', 'Sophie', 'Route du lac, Loudenvielle', TO_DATE('13-05-1988'));

-- 

INSERT INTO Specialite(idSpecialite, nom)
VALUES (1, 'ski');

INSERT INTO Specialite(idSpecialite, nom)
VALUES (2, 'snowboard');

INSERT INTO Specialite(idSpecialite, nom)
VALUES (3, 'raquette');

-- 

INSERT INTO Materiel(codeMateriel, typeMateriel, marque, prix, qteDispo)
VALUES (1, 'Ski', 'HyperGliss', 10, 2);

INSERT INTO Materiel(codeMateriel, typeMateriel, marque, prix, qteDispo)
VALUES (2, 'Snowboard', 'HyperGlass', 11, 3);

INSERT INTO Materiel(codeMateriel, typeMateriel, marque, prix, qteDispo)
VALUES (4, 'Raquette', 'Smash', 8, 2);

-- 

INSERT INTO Adherent(numAdherent, nom, prenom, adresse, tel, age)
VALUES (1, 'Lars', 'Julien', '12 rue principale, Muret', '0666666666', 13);

INSERT INTO Adherent(numAdherent, nom, prenom, adresse, tel, age)
VALUES (2, 'Salma', 'Louise', '23 route de Tarbes, Pau', '0777777777', 26);

INSERT INTO Adherent(numAdherent, nom, prenom, adresse, tel, age)
VALUES (3, 'Jardin', 'Lucien', 'Route d’Espagne, Tarbes', NULL, 52);

-- 

INSERT INTO Cours(codeCours, niveau, nbPlaces, dateCours, numMoniteur, idSpecialite)
VALUES (1, 'debutant', 1, TO_DATE('01-02-2013'), 1, 2);

INSERT INTO Cours(codeCours, niveau, nbPlaces, dateCours, numMoniteur, idSpecialite)
VALUES (2, 'moyen', 1, TO_DATE('02-02-2013'), 1, 2);

INSERT INTO Cours(codeCours, niveau, nbPlaces, dateCours, numMoniteur, idSpecialite)
VALUES (3, 'debutant', 5, TO_DATE('01-02-2013'), 2, 1);

-- 

INSERT INTO Suivre(codeCours, numAdherent)
VALUES (1, 1);

INSERT INTO Suivre(codeCours, numAdherent)
VALUES (1, 2);

INSERT INTO Suivre(codeCours, numAdherent)
VALUES (3, 1);

INSERT INTO Suivre(codeCours, numAdherent)
VALUES (2, 3);

-- 

INSERT INTO Louer(numAdherent, codeMateriel, quantite)
VALUES (3, 1, 1);

INSERT INTO Louer(numAdherent, codeMateriel, quantite)
VALUES (2, 1, 2);

-- 

COMMIT;
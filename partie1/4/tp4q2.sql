-- 
-- TP n°4 - Question n°2
-- 

-- 

DROP TABLE Fournir;
DROP TABLE Travailler;
DROP TABLE Buvette;
DROP TABLE Matchs;
DROP TABLE Fournisseur;
DROP TABLE Produit;
DROP TABLE Stade;
DROP TABLE Employe;

-- 

CREATE TABLE Employe (
    NumE NUMBER PRIMARY KEY,

    Nom VARCHAR(255) NOT NULL,
    Prenom VARCHAR(255) NOT NULL,
    DateNaissance DATE NOT NULL
);

-- 

CREATE TABLE Stade (
    NumS NUMBER PRIMARY KEY,

    NomS VARCHAR(255) NOT NULL,
    VilleS VARCHAR(255) NOT NULL
);

-- 

CREATE TABLE Produit (
    NumP NUMBER PRIMARY KEY,

    DescriptionP VARCHAR(255),
    TypeP VARCHAR(255) NOT NULL CHECK (TypeP IN ('salé', 'sucré')),
    Categorie VARCHAR(255) NOT NULL CHECK (Categorie IN ('végétarien', 'viande'))
);

-- 

CREATE TABLE Fournisseur (
    NumF NUMBER PRIMARY KEY,

    NomF VARCHAR(255) NOT NULL,
    LigneAdresse VARCHAR(255) NOT NULL,
    CodePostal NUMBER NOT NULL,
    VilleF VARCHAR(255) NOT NULL
);

-- 

CREATE TABLE Matchs (
    NumM NUMBER PRIMARY KEY,

    Equipe1 VARCHAR(255) NOT NULL,
    Equipe2 VARCHAR(255) NOT NULL,
    DateM DATE NOT NULL,
    HeureM VARCHAR(255) NOT NULL,
    NumS NUMBER NOT NULL,

    CONSTRAINT fk_Matchs_NumS FOREIGN KEY(NumS) REFERENCES Stade(NumS)
);

-- 

CREATE TABLE Buvette (
    NumB NUMBER PRIMARY KEY,

    Emplacement VARCHAR2(255) NOT NULL,
    NumS NUMBER NOT NULL,

    CONSTRAINT fk_Buvette_NumS FOREIGN KEY(NumS) REFERENCES Stade(NumS)
);

-- 

CREATE TABLE Travailler (
    NumE NUMBER NOT NULL,
    NumM NUMBER NOT NULL,
    NumB NUMBER NOT NULL,

    HeureDebut VARCHAR(255) NOT NULL,
    HeureFin VARCHAR(255) NOT NULL,

    CONSTRAINT pk_Travailler PRIMARY KEY(NumE, NumM, NumB),
    
    CONSTRAINT fk_Travailler_NumE FOREIGN KEY(NumE) REFERENCES Employe(NumE),
    CONSTRAINT fk_Travailler_NumM FOREIGN KEY(NumM) REFERENCES Matchs(NumM),
    CONSTRAINT fk_Travailler_NumB FOREIGN KEY(NumB) REFERENCES Buvette(NumB),

    UNIQUE(HeureDebut, HeureFin)
);

-- 

CREATE TABLE Fournir (
    NumF NUMBER NOT NULL,
    NumP NUMBER NOT NULL,
    NumS NUMBER NOT NULL,
    DateL DATE NOT NULL,

    Quantite NUMBER NOT NULL,
    PrixUnitaire NUMBER NOT NULL,

    CONSTRAINT pk_Fournir PRIMARY KEY(NumF, NumP, NumS, DateL),
    
    CONSTRAINT fk_Fournir_NumF FOREIGN KEY(NumF) REFERENCES Fournisseur(NumF),
    CONSTRAINT fk_Fournir_NumP FOREIGN KEY(NumP) REFERENCES Produit(NumP),
    CONSTRAINT fk_Fournir_NumS FOREIGN KEY(NumS) REFERENCES Stade(NumS)
);

-- 

COMMIT;
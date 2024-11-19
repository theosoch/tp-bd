Le MLD est le suivant :

```haskell
Employe(__NumE__, Nom, Prenom, DateNaissance)

Matchs(__NumM__, Equipe1, Equipe2, DateM, HeureM, #NumS)

Buvette(__NumB__, Emplacement, #NumS)

Stade(__NumS__, NomS, VilleS)

Produit(__NumP__, DescriptionP, TypeP, Categorie)

Fournisseur(__NumF__, NomF, LigneAdresse, CodePostal, VilleF)

Travailler(__#NumE, #NumM, #NumB__, HeureDebut, HeureFin)

Fournir(__#NumF, #NumP, #NumS, DateL__, Quantite, PrixUnitaire)
```
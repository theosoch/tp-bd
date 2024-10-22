L'annexe du TP précédent permet de déterminer une contrainte supplémentaire:
- `Adherent.tel` peut être nulle

En se basant sur le contexte et le modèle logique des données du TP1, on peut en déduire les contraintes supplémentaires suivantes:
- le nombre de places dans un cours est limité
    => la cardinalité maximale `n_max_suivre` de la classe d'association `Suivre` est finie
    => le nombre d'associations `Suivre` ne peut pas excéder `n_max_suivre`.

- un cours possède exactement `1` moniteur et au plus `1` spécialité.

- un cours ne peut se dérouler qu'une et une seule fois.

- *pour un même matériel, le total des quantités de ses locations ne peut pas être supérieur à sa quantité disponible. (à vérifier)*
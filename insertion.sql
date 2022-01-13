-- Insertion dans UTILISATEUR
INSERT INTO UTILISATEUR VALUES (1, 'jeanpierre12', 'jeanpierre@unistra.fr', '1334JDS0');
INSERT INTO UTILISATEUR VALUES (2, 'MartaBandor23', 'martaband0r@unistra.fr', '474RH%');
INSERT INTO UTILISATEUR VALUES (3, 'stefan65', 'stefanungureanu@unistra.fr', '338FDBF');
INSERT INTO UTILISATEUR VALUES (4, 'briceDw', 'bricedupont@unistra.fr', '1334JDS0');
INSERT INTO UTILISATEUR VALUES (5, 'jehanne', 'jehanne@unistra.fr', '1334JDS2930');

-- Insertion dans RECETTE
INSERT INTO RECETTE VALUES (1, 'Cheesecake', 'Gâteau avec du chocolat et du fromage', 3, 1, 1, 100, 20, 30, 10, 2);
INSERT INTO RECETTE VALUES (2, 'Creme brulee', 'Creme avec du sucre qui est brule avec un dispositif special', 5, 3, 3, 234, 21, 42, 30, 2);
INSERT INTO RECETTE VALUES (4, 'Soupe Goulash', 'Soupe de tomate avec de la boeuf', 2, 2, 4, 350, 23, 11, 100, 2);

-- Insertion dans INGREDIENTS
INSERT INTO INGREDIENTS VALUES (1, 'Sauce tomate', 120, 30.2, 12.3, 93.2, 2);
INSERT INTO INGREDIENTS VALUES (2, 'Sucre', 190, 30.23, 19.7, 99.99, 2);
INSERT INTO INGREDIENTS VALUES (3, 'Fromage Blanc', 50, 30.33, 9.27, 39.39, 1);

-- Insertion dans ETAPES
INSERT INTO ETAPES VALUES (1, 23, 'Bruler eau', 1, 4, 1);
INSERT INTO ETAPES VALUES (2, 123, 'Bruler le sucre', 1, 2, 4);
INSERT INTO ETAPES VALUES (3, 10, 'Preparer la creme', 5, 2, 10);
INSERT INTO ETAPES VALUES (4, 23, 'Melanger chocolat et fromage', 13, 1, 12);

-- Insertion dans ETAPES_INTERMEDIAIRE
INSERT INTO ETAPES_INTERMEDIAIRE VALUES (12, 'Trouver le bon type de chocolat');
INSERT INTO ETAPES_INTERMEDIAIRE VALUES (1, 'Ajouter du sel dans eau');
INSERT INTO ETAPES_INTERMEDIAIRE VALUES (2, 'Procurer dispositif pour bruler le sucre');

-- Insertion dans REGIME_ALIMENTAIRE
INSERT INTO REGIME_ALIMENTAIRE VALUES (1, 'Végan', 2);
INSERT INTO REGIME_ALIMENTAIRE VALUES (2, 'Végétarien', 2);

-- Insertion dans MEDIA
INSERT INTO MEDIA VALUES (1, 'Light and Creamy Cheesecake Recipe', 'https://www.youtube.com/watch?v=ZYoYffXWiwk', 'Video', 1);
INSERT INTO MEDIA VALUES (2, 'Recette de goulash de boeuf hongrois', 'https://www.youtube.com/watch?v=VT2VBV74VTI&pp=ugMICgJmchABGAE%3D', 'Video', 4);
INSERT INTO MEDIA VALUES (3, 'Creme brulee', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.cuisineaz.com%2Frecettes%2Fcreme-brulee-68417.aspx&psig=AOvVaw34ky2GsTavPn_vdg3DmK-8&ust=1637176626253000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIi-r67MnfQCFQAAAAAdAAAAABAD', 'Image', 2);

-- Insertion dans FAIRE_PLANNING
INSERT INTO FAIRE_PLANNING VALUES (1, '2021-11-11', 1, 1);
INSERT INTO FAIRE_PLANNING VALUES (2, '2021/11/16', 3, 2);
INSERT INTO FAIRE_PLANNING VALUES (3, '2021/12/24', 2, 4);

-- Insertion dans FAIRE_PLANNING_ARCHIVE
INSERT INTO FAIRE_PLANNING_ARCHIVE VALUES (1, '2021-11-11', 1, 1, 1);
INSERT INTO FAIRE_PLANNING_ARCHIVE VALUES (2, '2021/11/16', 3, 2, 2);
INSERT INTO FAIRE_PLANNING_ARCHIVE VALUES (3, '2021/12/24', 2, 4, 3);

-- Insertion dans ACHETER_INGREDIENT
INSERT INTO ACHETER_INGREDIENT VALUES (1, '2021-10-23', 2, 3);
INSERT INTO ACHETER_INGREDIENT VALUES (2, '2021-10-31', 2, 1);
INSERT INTO ACHETER_INGREDIENT VALUES (3, '2021-11-17', 2, 3);
INSERT INTO ACHETER_INGREDIENT VALUES (4, '2021-12-31', 2, 4);

-- Insertion dans ACHETER_INGREDIENT_ARCHIVE
INSERT INTO ACHETER_INGREDIENT_ARCHIVE VALUES (1, '2021-10-23', 2, 3, 1);
INSERT INTO ACHETER_INGREDIENT_ARCHIVE VALUES (2, '2021-10-31', 2, 1, 2);
INSERT INTO ACHETER_INGREDIENT_ARCHIVE VALUES (3, '2021-11-17', 2, 3, 3);
INSERT INTO ACHETER_INGREDIENT_ARCHIVE VALUES (4, '2021-12-31', 2, 4, 4);

-- Insertion dans REGIME_UTILISATEUR 
INSERT INTO REGIME_UTILISATEUR VALUES (10, 'Végan', 1, 5);
INSERT INTO REGIME_UTILISATEUR VALUES (12, 'Végétarien', 3, 2);

-- Insertion dans REGIME_INGREDIENTS
INSERT INTO REGIME_INGREDIENTS VALUES (1, 1, 5);
INSERT INTO REGIME_INGREDIENTS VALUES (2, 1, 3);
INSERT INTO REGIME_INGREDIENTS VALUES (3, 2, 1);
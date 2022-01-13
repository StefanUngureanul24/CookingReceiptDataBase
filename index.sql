-- Indexes are automatically created
-- When primary keys are declared during the table creation
-- or if it was defined as UNIQUE

--

-- Table UTILISATEUR 

-- Table RECETTE
CREATE INDEX recette_nom_idx ON recette(nom);

-- Table INGREDIENTS 

-- Table ETAPES
CREATE INDEX etapes_nom_idx ON etapes(nom);

-- Table ETAPES_INTERMEDIAIRE

-- Table REGIME_ALIMENTAIRE
CREATE INDEX regime_nom_idx ON regime_alimentaire(nom);

-- Table MEDIA
CREATE INDEX media_nom_type_idx ON media(nom, type);

-- Table FAIRE_PLANNING
CREATE INDEX planning_date_idx ON faire_planning(data);

-- Table FAIRE_PLANNING_ARCHIVE
CREATE INDEX planning_arch_date_idx ON faire_planning_archive(data);

-- Table ACHETER_INGREDIENT
CREATE INDEX achat_date_idx ON acheter_ingredient(data);

-- Table ACHETER_INGREDIENT_ARCHIVE
CREATE INDEX achat_arch_data_idx ON acheter_ingredient_archive(data);

-- Table REGIME_UTILISATEUR 
CREATE INDEX regime_utilis_nom_idx ON regime_utilisateur(nom);

-- Table REGIME_INGREDIENTS

-- Table CATEGORIES
-- J'ai tenté de créer une index sur le champs nom_categories
-- Pour que la recherche des nom de categories soit optimisée
-- Mais j'ai l'erreur suivante : ORA-01408: cette liste de colonnes est deja indexee
-- Et j'ai effectivement afficher la liste d'indexes de la table avec la commande suivante:
-- SELECT * FROM USER_INDEXES WHERE TABLE_NAME = UPPER('categories') 

-- CREATE INDEX categories_nom_idx ON categories(nom_categorie);


-- Table INGREDIENTS_CATEGORIES


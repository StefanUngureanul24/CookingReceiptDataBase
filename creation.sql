CREATE TABLE UTILISATEUR (
	id_utilis int NOT NULL PRIMARY KEY,
	login varchar(255) UNIQUE NOT NULL,
	mail varchar(255) UNIQUE NOT NULL,
	mdp varchar(255) NOT NULL,
	CONSTRAINT UTILISATEUR_FORMAT_MAIL CHECK (mail like '%_@_%')
);

CREATE TABLE RECETTE (
	id_recette int NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL,
	description varchar(255),
	difficulte int NOT NULL,
	prix int NOT NULL,
	nb_personnes int NOT NULL,
	calories int NOT NULL,
	lipides decimal(10, 2) NOT NULL,
	glucides decimal(10, 2) NOT NULL,
	protides decimal(10, 2) NOT NULL,
	duree_totale decimal(10, 2) NOT NULL,
	id_utilis int NOT NULL,
	CONSTRAINT RECETTE_DIFFICULTE_CHECK CHECK (difficulte BETWEEN 1 AND 5),
	CONSTRAINT RECETTE_PRIX_CHECK CHECK (prix BETWEEN 1 AND 5),
	CONSTRAINT RECETTE_NBPERSONNES_CHECK CHECK (nb_personnes > 0),
	CONSTRAINT RECETTE_CAL_CHECK CHECK (calories >= 0),
	CONSTRAINT RECETTE_LIP_CHECK CHECK (lipides >= 0),
	CONSTRAINT RECETTE_GLU_CHECK CHECK (glucides >= 0),
	CONSTRAINT RECETTE_PRO_CHECK CHECK (protides >= 0)
);	

CREATE TABLE INGREDIENTS (
	id_ingredient int NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL UNIQUE,
	calories int NOT NULL,
	lipides decimal(10, 2) NOT NULL,
	glucides decimal(10, 2) NOT NULL,
	protides decimal(10, 2) NOT NULL,
	id_utilis int NOT NULL,
	CONSTRAINT INGREDIENTS_CAL_CHECK CHECK (calories >= 0),
	CONSTRAINT INGREDIENTS_LIP_CHECK CHECK (lipides >= 0),
	CONSTRAINT INGREDIENTS_GLU_CHECK CHECK (glucides >= 0),
	CONSTRAINT INGREDIENTS_PRO_CHECK CHECK (protides >= 0)
);	

CREATE TABLE ETAPES (
	id_etape int NOT NULL PRIMARY KEY,
	duree_totale int NOT NULL,
	nom varchar(255) NOT NULL,
	ordre int NOT NULL,
	id_recette int NOT NULL,
	id_etapeinter int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE,
	FOREIGN KEY (id_etapeinter) REFERENCES ETAPES_INTERMEDIAIRE 
);

CREATE TABLE RECETTE_INGREDIENTS (
	id_ri int NOT NULL PRIMARY KEY,
	quantite decimal(10, 2) NOT NULL,
	id_recette int NOT NULL,
	id_ingredient int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE,
	FOREIGN KEY (id_ingredient) REFERENCES INGREDIENTS
);

CREATE TABLE ETAPES_INTERMEDIAIRE (
	id_etapeinter int NOT NULL PRIMARY KEY,
	nom varchar(255) UNIQUE NOT NULL	
);

CREATE TABLE REGIME_ALIMENTAIRE (
	id_regime int NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL,
	id_recette int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE
);

CREATE TABLE MEDIA (
	id_media int NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL,
	url varchar(255) NOT NULL,
	type varchar(255) NOT NULL,
	id_recette int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE
);

CREATE TABLE FAIRE_PLANNING (
	id_fp int NOT NULL PRIMARY KEY,
	data Date NOT NULL,
	id_recette int NOT NULL,
	id_utilis int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE,
	FOREIGN KEY (id_utilis) REFERENCES UTILISATEUR
); 	

CREATE TABLE FAIRE_PLANNING_ARCHIVE (
	id_fp_arch int NOT NULL PRIMARY KEY,
	data Date NOT NULL,
	id_recette int NOT NULL,
	id_utilis int NOT NULL, 
	id_fp int NOT NULL,
	FOREIGN KEY (id_recette) REFERENCES RECETTE,
	FOREIGN KEY (id_utilis) REFERENCES UTILISATEUR,
	FOREIGN KEY (id_fp) REFERENCES FAIRE_PLANNING
);

CREATE TABLE ACHETER_INGREDIENT (
	id_ai int NOT NULL PRIMARY KEY,
	data Date NOT NULL,
	id_utilis int NOT NULL,
	id_ingredient int NOT NULL,
	FOREIGN KEY (id_utilis) REFERENCES UTILISATEUR,
	FOREIGN KEY (id_ingredient) REFERENCES INGREDIENTS
);

CREATE TABLE ACHETER_INGREDIENT_ARCHIVE (
	id_ai_arch int NOT NULL PRIMARY KEY,
	data Date NOT NULL,
	id_utilis int NOT NULL,
	id_ingredient int NOT NULL,
	id_ai int NOT NULL,
	FOREIGN KEY (id_utilis) REFERENCES UTILISATEUR,
	FOREIGN KEY (id_ingredient) REFERENCES INGREDIENTS,
	FOREIGN KEY (id_ai) REFERENCES ACHETER_INGREDIENT
);

CREATE TABLE REGIME_UTILISATEUR (
	id_ru int NOT NULL PRIMARY KEY,
	nom varchar(255),
	id_regime int NOT NULL,
	id_utilis int NOT NULL,
	FOREIGN KEY (id_utilis) REFERENCES UTILISATEUR,
	FOREIGN KEY (id_regime) REFERENCES REGIME_ALIMENTAIRE
);

CREATE TABLE REGIME_INGREDIENTS (
	id_ri int NOT NULL PRIMARY KEY,
	id_regime int NOT NULL,
	id_ingredient int NOT NULL,
	FOREIGN KEY (id_regime) REFERENCES REGIME_ALIMENTAIRE,
	FOREIGN KEY (id_ingredient) REFERENCES INGREDIENTS
);

-- To reproduce the ingredients' categories
CREATE TABLE CATEGORIES (
	id_categorie int NOT NULL PRIMARY KEY,
	nom_categorie varchar(25) NOT NULL,
	CONSTRAINT CATEGORIE_NOM_UNIQUE UNIQUE (nom_categorie)
);

-- To create a link between the two tables
-- INGREDIENTS and CATEGORIES
CREATE TABLE INGREDIENTS_CATEGORIES (
	id_ingredient int NOT NULL,
	id_categorie int NOT NULL,
	CONSTRAINT INGREDIENTS_CATEGORIE_I_FK FOREIGN KEY (id_ingredient) REFERENCES ingredients(id_ingredient),
	CONSTRAINT INGREDIENTS_CATEGORIE_C_FK FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
);

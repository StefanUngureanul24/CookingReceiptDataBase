-- J'ai ajouté toutes les tables que j'ai mentioné en commentaires
-- Dans la fichier creation.sql

-- Pas plus de 20 ingrédients par recettes

-- J'ai créé cette table que j'avais pas créée pour le premier rendu (sans inclure les clés étrangères)
-- CREATE TABLE recette_ingredients (
-- id_ri int NOT NULL PRIMARY KEY,
-- quantite Decimal(10, 2),
-- id_recette int,
-- id_ingredient int
-- );

CREATE OR REPLACE TRIGGER no_ingredients
	BEFORE INSERT OR UPDATE ON recette_ingredients
	FOR EACH ROW

	DECLARE
	nb_v NUMBER;
	
	BEGIN
		SELECT COUNT(id_ri) 
		INTO nb_v
		FROM recette_ingredients
		WHERE id_recette=:new.id_recette;
	
		IF nb_v >= 20 THEN
			RAISE_APPLICATION_ERROR(-20000, 'Pas plus de 20 ingrédients par recette');
		END IF;
END;
/

-- La liste des ingrédients ne peut pas être générée plus d'un mois à l'avance

-- J'ai créé cette table que j'avais pas créée pour le premier rendu (sans inclure les clés étrangères)
-- CREATE TABLE acheter_ingredient (
-- id_ai int NOT NULL PRIMARY KEY,
-- quantite Decimal,
-- id_utilis int,
-- id_ ingredient int
-- );

-- J'ai modifié le nom du champs date (marquée ainsi dans le modèle logique) de la table acheter_ingredient 
-- ALTER TABLE acheter_ingredient ADD data DATE;
-- Puisque je récévais une erreur lors de la création de la table

CREATE OR REPLACE TRIGGER liste_ingredients
	BEFORE INSERT OR UPDATE ON acheter_ingredient
	FOR EACH ROW
BEGIN
	
	IF :new.data >= ADD_MONTHS(SYSDATE, 1) THEN
			RAISE_APPLICATION_ERROR(-20000, 'La liste des ingrédients ne peut pas être générée plus d''un mois à l''avance!');
		END IF;
END;
/

-- La durée d'une recette est égale à au moins le minimum de la durée de ses étapes
-- J'ai ajoutée le champ duree_totale dans la table recette, ce que j'avais pas fait pour le premier rendu  

-- ALTER TABLE recette ADD duree_totale decimal(10, 2);

CREATE OR REPLACE TRIGGER duree_recette
	BEFORE INSERT OR UPDATE ON recette
	FOR EACH ROW

	DECLARE
		d_recette_v recette.duree_totale%TYPE;
		d_etapes_v recette.duree_totale%TYPE;
	BEGIN
		SELECT duree_totale INTO d_recette_v
		FROM recette
		WHERE id_recette = :new.id_recette;
		-- 
		SELECT SUM(duree_totale) INTO d_etapes_v 
		FROM etapes
		WHERE id_recette = :new.id_recette;
		--
		IF d_recette_v < d_etapes_v THEN 
			RAISE_APPLICATION_ERROR(-20000, 'La durée d''une recette est égale à au moins le minimum de la durée de ses étapes');
		END IF;
END;
/

-- Le nombre de calorie d’une recette est similaire à celui de la somme des calories de ses ingrédients (+/- 20%).
CREATE OR REPLACE TRIGGER calorie_recette
	AFTER INSERT OR UPDATE ON recette_ingredients
	FOR EACH ROW
	 
	DECLARE
		calorie_recette_v ingredients.calories%TYPE;
		calorie_etapes_v ingredients.calories%TYPE;
		
BEGIN 
		SELECT calories INTO calorie_recette_v
		FROM recette 
		WHERE id_recette = :new.id_recette;  
		
		SELECT SUM(rec_ingr.quantite * ingr.calories ) INTO calorie_etapes_v
		FROM recette_ingredients rec_ingr, ingredients ingr
		WHERE id_recette = :new.id_recette;
		
		IF (calorie_recette_v < (calorie_etapes_v * 0.8)) AND (calorie_etapes_v < (calorie_recette_v * 0.8)) THEN
			RAISE_APPLICATION_ERROR(-20000, 'Le nombre de calorie d’une recette est similaire à celui de la somme des calories de ses ingrédients (+/- 20%).');
		END IF;
END;
/

		
-- Les plannings de recettes et la liste des courses sont archivés lorsqu’ils sont supprimés ou une fois les dates associées dépassées.

-- Création de la table faire_planning, ainsi que faire_planning_archive

-- CREATE TABLE faire_planning (
-- id_fap int NOT NULL PRIMARY KEY,
-- dt Date,
-- id_utilis int, 
-- id_recette int
-- );

CREATE OR REPLACE TRIGGER archive_delete_planning
	BEFORE DELETE ON faire_planning 
	FOR EACH ROW
	
DECLARE
	info_planning_v faire_planning%ROWTYPE;

BEGIN
	SELECT * INTO info_planning_v			
	FROM faire_planning
	WHERE data > ADD_MONTHS(SYSDATE, 10);

	INSERT INTO faire_planning_archive 
	VALUES (:old.id_fp, :old.data, :old.id_recette, :old.id_utilis, :old.id_fp);
	

END;
/


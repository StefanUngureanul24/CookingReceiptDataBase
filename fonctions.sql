-- Fonction qui change le nom d'un ingrédient par un autre dans les étapes de réalisation d'une recette

CREATE OR REPLACE FUNCTION remplace_ingredients (id_recette_v IN recettes.id_recette%TYPE, source_v IN ingredients.id_ingredient%TYPE, dest_v IN ingredients.id_ingredient%TYPE
) RETURN CLOB IS
BEGIN
	DECLARE
		CURSOR etapes_c IS
			SELECT LOWER(nom) AS "Name",
				LOWER (duree_totale) AS "Duree"
			FROM ETAPES
			WHERE id_recette = id_recette_v
			ORDER BY ordre;
		ingred_src_v ingredients.nom%TYPE;
		ingred_dest_v ingredients.nom%TYPE;
		res_v CLOB := '';
BEGIN
	SELECT LOWER(nom) 
	FROM INGREDIENTS
	WHERE id_ingredient = source_v;
	SELECT LOWER(nom) INTO ingred_dest_v
	FROM INGREDIENTS
	WHERE id_ingredient = dest_v;
	
	FOR etape_v IN etape_c LOOP
		res_v := res_v || ' ' || REPLACE(etape_v.Name, ingred_src_v, ingred_dest_v);
		res_v := res_v || ' (' || etape_v."Duree" || ')' || CHR(10);
		
	res_v := res_v || CHR(10);
	END LOOP; 
	
	RETURN res_v;
END;
END;
/

-- Fonction qui retourne a liste des ingrédients où la quantité d’ingrédient a été adaptée pour un nombre de personnes différent du nombre de personnes de la recette d’origine
CREATE OR REPLACE FUNCTION remplace_quantite (id_recette_v IN recette.id_recette%TYPE, nb_pers_v IN recette.nb_personnes%TYPE) RETURN CLOB IS
BEGIN
	DECLARE 
		nb_pers_source recette.nb_personnes%TYPE;
		CURSOR ingred_c IS
			SELECT i.nom, ri.quantite, ri.id_ingredient
			FROM recette_ingredients ri, ingredients i
			WHERE ir.id_ingredient = i.id_ingredient AND ri.id_recette = id_recette_v;
		res_v CLOB := 'Les ingredients : ' || CHR(10);
		
	BEGIN 
		SELECT nb_personnes INTO nb_pers_v
		FROM recette
		WHERE id_recette = id_recette_v;
		
	FOR ingred_v IN ingred_c LOOP
		v_res := v_res || ingred_v.nom || (ingred_v.quantite / nb_pers_source) * nb_pers_v || CHR(10);
	END LOOP;
	
	RETURN res_v;
END;
END;
/

-- Procédure qui crée une copie de recette où certains ingrédients ont été remplacés par d'autres équivalents et où le nombre de personnes peut-être différent de celui de la recette originale
CREATE OR REPLACE PROCEDURE copier_recette(id_recette_v IN recette.id_recette%TYPE, nb_pers IN recette.id_recette%TYPE, ingr_changer_v IN ingredients.id_ingredient%TYPE) IS
BEGIN
	DECLARE 
		ingred_remplacer_v ingredients.id_ingredient%TYPE := NULL;
		ingred_categorie_v ingredients_categories.id_categorie%TYPE;
		prochain_id_v recette.id_recette%TYPE;
		prochain_id_v recette%ROWTYPE;
		ingred_src_v ingredients.nom%TYPE;
		ingred_dest_v ingredients.nom%TYPE;
		
		CURSOR etapes_c IS
		SELECT *
		FROM ETAPES
		WHERE id_recette = id_recette_v;
		
		CUROSR ingred_c IS
		SELECT * 
		FROM RECETTE_INGREDIENTS 
		WHERE id_recette = id_recette_v;

BEGIN
	SELECT nom INTO ingred_src_v
	FROM INGREDIENTS
	WHERE id_ingredient := ingr_changer_v;

	IF ingred_remplacer_v IS NULL THEN ingred_remplacer_v := ingr_changer_v;
	END IF;

END;
END;
/

-- Fonction qui retourne un booléen si la recette ne contient que des ingrédients valides pour un certain régime
CREATE OR REPLACE FUNCTION recette_regime_compatible(id_recette_v IN recette.id_recette%TYPE, regime_v IN regime_alimentaire.nom%TYPE) RETURN BOOLEAN IS
BEGIN
	DECLARE
		res_v BOOLEAN := TRUE;
		CURSOR recette_c IS
			SELECT id_recette
			FROM recette_ingredients
			WHERE id_ingredient IN (
				SELECT id_ingredient
				FROM regime_alimenaire 
			);
			
			BEGIN 
				FOR recette_v IN recette_c LOOP 
					IF recette_v.id_recette = id_recette_v THEN res_v := FALSE;
					END IF;
				END LOOP;
			RETURN res_v;
			END;
END;
/

					 


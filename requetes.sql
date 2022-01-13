--1
SELECT id_recette, nom FROM recette r, regime_alimentaire a WHERE r.id_recette=a.id_recette 
                AND calories / nb_personnes < 200 
                    AND a.nom ='Sans Gluten' 
                        AND r.id_recette IN
                            (SELECT id_recette from faire_planning);

-- The receipt that is most the most common in users' planning 
SELECT id_recette,
	count(id_recette) as occurrence 
		FROM faire_planning 
			GROUP BY id_recette ORDER BY occurrence DESC 					LIMIT 1;
			
-- For each ingredient, number of receipts and number of categories in which it appears
SELECT i.nom,
    COUNT(DISTINCT r.id_recette) AS nb_recettes,
    	COUNT(DISTINCT ic.id_categorie) AS nb_categories
  		FROM ingredients i, recette_ingredients r, ingredients_categories ic
  			WHERE i.id_ingredient = r.id_ingredient 
  				AND i.id_ingredient = ic.id_ingredient
  					GROUP BY i.nom;
  					
-- Users who only added vegetarian receipts to the database
SELECT u.id_utilis
	FROM utilisateur u, recette r
		WHERE u.id_utilis=r.id_utilis AND r.id_recette NOT IN 			(SELECT id_regime 
				FROM regime_alimentaire 
					WHERE nom 
						NOT LIKE '%Végétarien%');




-- For each user, select all the details, such as:
-- login, email, shopping list, nombre of receipts created
-- as well as number of ingredients saved
SELECT
  id_utilis,
  login AS pseudo,
  mail AS email,
  (SELECT COUNT(id_recette)
    FROM recette r
    WHERE r.id_utilis = utilisateur.id_utilis) AS nb de recette créé,
  (SELECT COUNT(id_ingredient)
    FROM ingredients i
    WHERE i.id_utilis = utilisateur.id_utilis) AS nb d ingrédients enregistrés,
  (SELECT COUNT(*)
    FROM faire_planning f
    WHERE  f.id_utilis= utilisateur.id_utilis AND data >= SYSDATE) AS "nb recettes prévu de réaliser"
  FROM utilisateur;


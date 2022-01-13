--1
SELECT id_recette, nom FROM recette r, regime_alimentaire a WHERE r.id_recette=a.id_recette 
                AND calories / nb_personnes <200 
                    AND a.nom ='Sans Gluten' 
                        AND r.id_recette IN
                            (SELECT id_recette from faire_planning);



--2 La recette la plus souvent présente dans des plannings d’utilisateurs.


SELECT id_recette,
	count(id_recette) as occurrence 
		FROM faire_planning 
			GROUP BY id_recette ORDER BY occurrence DESC 					LIMIT 1;
			
			
--3 Pour chaque ingrédient, nombre de recette et nombre de catégorie dans lesquelles il apparaît.

SELECT i.nom,
    COUNT(DISTINCT r.id_recette) AS nb_recettes,
    	COUNT(DISTINCT ic.id_categorie) AS nb_categories
  		FROM ingredients i, recette_ingredients r, ingredients_categories ic
  			WHERE i.id_ingredient = r.id_ingredient 
  				AND i.id_ingredient = ic.id_ingredient
  					GROUP BY i.nom;
  					
--4 Les utilisateurs qui n’ont ajouté à la base de données que des recettes végétariennes.

SELECT u.id_utilis
	FROM utilisateur u, recette r
		WHERE u.id_utilis=r.id_utilis AND r.id_recette NOT IN 			(SELECT id_regime 
				FROM regime_alimentaire 
					WHERE nom 
						NOT LIKE '%Végétarien%');





--5 Pour chaque utilisateur, son login, son nom, son prénom, son adresse, son nombre de recette créé, son nombre d’ingrédients enregistrés, le nombre de recette qu’il a prévu de réaliser (la recette est dans son planning à une date postérieure à la date d’aujourd’hui).

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

  
  
  

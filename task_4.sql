WITH pizza AS (
	SELECT 
	cafe_name,
	menu -> 'Пицца' AS product
	FROM cafe.restaurants r  
	WHERE type = 'pizzeria'
	)
SELECT cafe_name, count_pizza 
FROM (
	SELECT b.*,
	DENSE_RANK() OVER (ORDER BY count_pizza DESC) AS rn
	FROM (
		SELECT cafe_name, COUNT(*) AS count_pizza
		FROM (
			SELECT cafe_name,
			(JSONB_EACH(product)).KEY
			FROM pizza
			) a
		GROUP BY cafe_name
		ORDER BY COUNT(*) DESC
		) b
) c
WHERE rn =1
;

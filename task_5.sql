WITH pizza AS (
	SELECT 
	cafe_name,
	menu -> 'Пицца' AS product
	FROM cafe.restaurants r  
	WHERE type = 'pizzeria'
	)
SELECT 
cafe_name,
pizza_type,
key AS name_pizza,
value AS price
FROM (
	SELECT a.*,
	ROW_NUMBER() OVER (PARTITION BY cafe_name ORDER BY value DESC) AS rn
	FROM (
		SELECT cafe_name,
		'Пицца' AS pizza_type,
		(JSONB_EACH(product)).key,
		(JSONB_EACH(product)).value
		FROM pizza
		) a
	) b
WHERE rn =1
;

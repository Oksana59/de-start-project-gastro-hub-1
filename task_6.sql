BEGIN;

WITH pizza AS (
SELECT 
cafe_name,
'"' || new_price::TEXT || '"' AS price_cappuccino
FROM(
	SELECT 
	cafe_name,
	ROUND((menu -> 'Кофе' -> 'Капучино')::INTEGER *1.2) AS new_price
	FROM cafe.restaurants r  
	WHERE menu -> 'Кофе' ? 'Капучино'
 	FOR NO KEY UPDATE
	) a
	)
UPDATE cafe.restaurants r
SET menu = JSONB_SET(menu, '{Кофе, Капучино}', p.price_cappuccino::JSONB)
FROM pizza p
WHERE p.cafe_name = r.cafe_name;

COMMIT;


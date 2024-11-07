CREATE VIEW top3_cafe AS 
SELECT cafe_name, type, bill_avg
FROM (
	SELECT a.*,
	ROW_NUMBER() OVER (PARTITION BY a.type ORDER BY bill_avg DESC) AS rn
	FROM (
		SELECT 
		r.type, r.cafe_name,
		ROUND(AVG(avg_check), 2) AS bill_avg
		FROM cafe.sales s
		LEFT JOIN cafe.restaurants r ON s.restaurant_uuid = r.restaurant_uuid 
		GROUP BY r.type, r.cafe_name
		) a
	) b
WHERE b.rn <=3
;

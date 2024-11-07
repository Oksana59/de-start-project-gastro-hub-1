CREATE MATERIALIZED VIEW avg_bill_change AS 
SELECT a.*,
LAG(bill_avg_current_year, 1) OVER (PARTITION BY cafe_name) AS bill_avg_previous_year,
ROUND(bill_avg_current_year *100 / (LAG(bill_avg_current_year, 1) OVER (PARTITION BY cafe_name)) -100, 2) AS delta_percent
FROM (
	SELECT 
	EXTRACT(YEAR FROM s.date) AS YEAR, r.cafe_name, r.type, 
	ROUND(AVG(avg_check), 2) AS bill_avg_current_year
	FROM cafe.sales s
	LEFT JOIN cafe.restaurants r ON s.restaurant_uuid = r.restaurant_uuid 
	WHERE EXTRACT(YEAR FROM s.date) != 2023
	GROUP BY year, r.cafe_name, r.type
	ORDER BY r.cafe_name, year
	) a
;

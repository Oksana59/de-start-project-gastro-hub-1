SELECT 
cafe_name, COUNT(manager_uuid)
FROM (
SELECT DISTINCT 
r.cafe_name, 
rm.manager_uuid,
rm.date_work_begin,
rm.date_work_end
FROM cafe.restaurant_manager_work_dates rm
LEFT JOIN cafe.restaurants r ON r.restaurant_uuid = rm.restaurant_uuid 
) a
GROUP BY cafe_name
ORDER BY COUNT(manager_uuid) DESC
LIMIT 3
;

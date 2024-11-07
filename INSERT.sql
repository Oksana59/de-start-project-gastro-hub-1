INSERT INTO cafe.restaurants (cafe_name, type, menu)
SELECT DISTINCT 
s.cafe_name, 
CAST(s.type AS cafe.restaurant_type), 
m.menu
FROM raw_data.sales s
LEFT JOIN raw_data.menu m ON s.cafe_name = m.cafe_name 
;

INSERT INTO cafe.managers (manager, manager_phone)
SELECT DISTINCT manager, manager_phone 
FROM raw_data.sales
;

INSERT INTO cafe.restaurant_manager_work_dates (restaurant_uuid, manager_uuid, date_work_begin, date_work_end)
SELECT DISTINCT
r.restaurant_uuid,
m.manager_uuid, 
MIN(s.report_date),
MAX(s.report_date)
FROM raw_data.sales s 
LEFT JOIN cafe.managers m ON s.manager = m.manager 
LEFT JOIN cafe.restaurants r ON s.cafe_name = r.cafe_name 
GROUP BY r.restaurant_uuid, m.manager_uuid
;

INSERT INTO cafe.sales (date, restaurant_uuid, avg_check)
SELECT 
s.report_date,
r.restaurant_uuid,
s.avg_check 
FROM raw_data.sales s
LEFT JOIN cafe.restaurants r ON s.cafe_name = r.cafe_name
;


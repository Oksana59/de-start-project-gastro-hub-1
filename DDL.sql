CREATE SCHEMA cafe;

CREATE TYPE cafe.restaurant_type AS ENUM 
    ('coffee_shop', 'restaurant', 'bar', 'pizzeria'); 
   
CREATE TABLE cafe.restaurants (
	restaurant_uuid UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	cafe_name VARCHAR NOT NULL,
	type cafe.restaurant_type,
	menu JSONB
);

CREATE TABLE cafe.managers (
	manager_uuid UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	manager VARCHAR NOT NULL,
	manager_phone VARCHAR
);

CREATE TABLE cafe.restaurant_manager_work_dates (
	restaurant_uuid UUID REFERENCES cafe.restaurants,
	manager_uuid UUID REFERENCES cafe.managers,
	date_work_begin DATE NOT NULL CHECK(date_work_begin < date_work_end),
	date_work_end DATE NOT NULL DEFAULT current_date,
	PRIMARY KEY (restaurant_uuid, manager_uuid)
);

CREATE TABLE cafe.sales (
	date DATE NOT NULL,
	restaurant_uuid UUID REFERENCES cafe.restaurants,
	avg_check NUMERIC(6,2) CHECK(avg_check > 0),
	PRIMARY KEY (date, restaurant_uuid)
);


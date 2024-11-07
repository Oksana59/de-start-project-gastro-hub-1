BEGIN;

ALTER TABLE cafe.managers ADD COLUMN managers_phones TEXT ARRAY;

WITH phone_array AS (
SELECT 
manager,
ARRAY['8-800-2500-' || rn::TEXT, manager_phone] AS phones
FROM (
	SELECT 
	manager,
	manager_phone,
	ROW_NUMBER() OVER (ORDER BY manager)+99 AS rn
	FROM cafe.managers m 
	) a
)
UPDATE cafe.managers m
SET managers_phones = p.phones
FROM phone_array p
WHERE m.manager = p.manager
;

ALTER TABLE cafe.managers DROP COLUMN manager_phone;

COMMIT;

SELECT 'vodila' AS table_nm,
       count(*) AS cnt
FROM ts.vodila

UNION ALL

SELECT 'transport' AS table_nm,
       count(*)    AS cnt
FROM ts.transport

UNION ALL

SELECT 'trip'   AS table_nm,
       count(*) AS cnt
FROM ts.trip

UNION ALL

SELECT 'bus_info' AS table_nm,
       count(*)   AS cnt
FROM ts.bus_info

UNION ALL

SELECT 'metro_info' AS table_nm,
       count(*)     AS cnt
FROM ts.metro_info

UNION ALL

SELECT 'trip_history' AS table_nm,
       count(*)     AS cnt
FROM ts.trip_history;

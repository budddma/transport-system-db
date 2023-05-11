-- 1) SELECT запрос с использованием GROUP BY + HAVING:
-- Находит тип топлива, для которых средняя пассажировместимость больше 30

SELECT fuel, avg(capacity) as avg_capacity
FROM ts.bus_info
GROUP BY fuel
HAVING avg(capacity) > 30;

-- 2) SELECT запрос с использованием ORDER BY:
-- Сортирует водителей по стажу

SELECT vodila_nm, experience
FROM ts.vodila
ORDER BY experience DESC;

-- 3) SELECT запрос с использованием <func>(...) OVER(PARTITION BY ...):
-- Находит средний стаж водителей на каждом маршруте

SELECT route_nm,
       avg(experience) OVER (PARTITION BY route_id) AS avg_experience
FROM ts.vodila
         JOIN ts.transport using (vodila_id)
         JOIN ts.trip using (transport_id)
         JOIN ts.route using (route_id);

-- 4) SELECT запрос с использованием <func>(...) OVER(ORDER BY ...):
-- Сортирует маршруты поездов по пассажировместимости

SELECT DISTINCT row_number() OVER (ORDER BY capacity desc) as row_number,
                route_nm,
                capacity
FROM ts.transport
         JOIN ts.trip using (transport_id)
         LEFT JOIN ts.metro_info using (transport_id)
         RIGHT JOIN ts.route using (route_id)
where bus_flg = FALSE
ORDER BY row_number;

-- 5) SELECT запрос с использованием <func>(...) OVER(PARTITION BY + ORDER BY):
-- Находит текущую остановку для каждого маршрута.
-- Если на маршруте не один рейс, то находит последний обновлённый из trip_history

SELECT DISTINCT route_nm,
                FIRST_VALUE(stop_nm) OVER (PARTITION BY route_id ORDER BY update_dttm DESC)     as curr_stop,
                FIRST_VALUE(update_dttm) OVER (PARTITION BY route_id ORDER BY update_dttm DESC) as last_update
FROM ts.route
         JOIN ts.trip using (route_id)
         JOIN ts.trip_history using (trip_id)
         JOIN ts.stop ON ts.trip.curr_stop_id = ts.stop.stop_id;

-- 6) SELECT запрос с использованием <func>(...) OVER(...) и агрегирующей функцией:
-- Считает общее число рейсов для каждого маршрута

SELECT DISTINCT route_nm,
       COUNT(trip_id) OVER (PARTITION BY route_id) AS trip_count
FROM ts.route
         LEFT JOIN ts.trip
                   using (route_id);

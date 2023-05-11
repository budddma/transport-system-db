-- 1) VIEW, которая исключает id из bus_info
-- и скрывает автобусный номер

CREATE OR REPLACE VIEW ts.bus_view AS
SELECT (CASE
            WHEN bus_no IS NULL THEN 'Без названия - Неизвестен'
            ELSE CONCAT('****', right(bus_no, 2))
    END) as bus_number,
       fuel,
       capacity
FROM ts.bus_info;

-- 2) VIEW, которая исключает id из vodila
-- и оставляет только имя водилы

CREATE OR REPLACE VIEW ts.vodila_view AS
SELECT (CASE
            WHEN position(' ' in vodila_nm) = 0 THEN vodila_nm
            ELSE substring(vodila_nm, 1, position(' ' in vodila_nm) - 1)
    END) as name,
       experience
FROM ts.vodila;


-- 3) VIEW, сопоставляющая маршруту текущую и предыдущую остановки

CREATE OR REPLACE VIEW ts.route_curr_prev_stops AS
SELECT route_nm as route, curr.stop_nm as curr_stop, prev.stop_nm as prev_stop
FROM ts.trip AS t
         JOIN ts.route USING (route_id)
         JOIN ts.stop curr ON t.curr_stop_id = curr.stop_id
         LEFT JOIN ts.trip_history AS th USING (trip_id)
         LEFT JOIN ts.stop prev ON th.curr_stop_id = prev.stop_id;


-- 4) VIEW, сопоставляющая маршруту его начальную и конечную остановки

CREATE OR REPLACE VIEW ts.route_init_final_stops AS
SELECT route_nm as route, init.stop_nm as initial_stop, final.stop_nm as final_stop
FROM ts.route
         JOIN ts.stop AS init ON route.initial_stop_id = init.stop_id
         JOIN ts.stop AS final ON final_stop_id = final.stop_id;


-- 5) VIEW, сопоставляющая имени водителя его маршртут

CREATE OR REPLACE VIEW ts.vodila_route AS
SELECT (CASE
            WHEN position(' ' in vodila_nm) = 0 THEN vodila_nm
            ELSE substring(vodila_nm, 1, position(' ' in vodila_nm) - 1)
    END)        as driver,
       route_nm as route
FROM ts.vodila
         JOIN ts.transport USING (vodila_id)
         JOIN ts.trip USING (transport_id)
         JOIN ts.route USING (route_id);


-- 6) VIEW, сопоставляющая каждому водителю автобуса скрытый номер его машины

CREATE OR REPLACE VIEW ts.vodila_number AS
SELECT (CASE
            WHEN position(' ' in vodila_nm) = 0 THEN vodila_nm
            ELSE substring(vodila_nm, 1, position(' ' in vodila_nm) - 1)
    END)        as driver,
       (CASE
            WHEN bus_no IS NULL THEN NULL
            ELSE CONCAT('****', right(bus_no, 2))
    END) as bus_number
FROM ts.vodila
         JOIN ts.transport USING (vodila_id)
         JOIN ts.bus_info USING (transport_id);

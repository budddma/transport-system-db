-- Создаём кластеризованные индексы на первичном ключе,
-- хотя вроде в PostgreSQL они автоматом создаётся

CREATE UNIQUE INDEX stop_index ON ts.stop (stop_id) include (stop_nm);

CREATE UNIQUE INDEX route_index ON ts.route (route_id) include (route_nm);

CREATE UNIQUE INDEX trip_index ON ts.trip (trip_id);

CREATE UNIQUE INDEX transport_index ON ts.transport (transport_id);


-- Некластеризованные индексы на полях,
-- по которым чаще делается поиск

CREATE INDEX bus_flg_index ON ts.transport (bus_flg);

CREATE UNIQUE INDEX bus_no_index ON ts.bus_info (bus_no);

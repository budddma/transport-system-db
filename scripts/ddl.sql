CREATE SCHEMA ts;

CREATE TABLE IF NOT EXISTS ts.stop
(
    stop_id INTEGER PRIMARY KEY,
    stop_nm VARCHAR(30) NOT NULL,
    bus_flg BOOLEAN     NOT NULL
);

CREATE TABLE IF NOT EXISTS ts.route
(
    route_id        INTEGER PRIMARY KEY,
    route_nm        VARCHAR(30) NOT NULL,
    initial_stop_id INTEGER,
    final_stop_id   INTEGER,
    FOREIGN KEY (initial_stop_id) REFERENCES ts.stop (stop_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (final_stop_id) REFERENCES ts.stop (stop_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ts.vodila
(
    vodila_id  INTEGER PRIMARY KEY,
    vodila_nm  VARCHAR(30),
    experience INTEGER DEFAULT 0
        CONSTRAINT chk_exp CHECK (experience >= 0)
);

CREATE TABLE IF NOT EXISTS ts.transport
(
    transport_id INTEGER PRIMARY KEY,
    vodila_id    INTEGER,
    bus_flg      BOOLEAN NOT NULL,
    FOREIGN KEY (vodila_id) REFERENCES ts.vodila (vodila_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ts.trip
(
    trip_id      INTEGER PRIMARY KEY,
    transport_id INTEGER,
    route_id     INTEGER,
    curr_stop_id INTEGER,
    FOREIGN KEY (transport_id) REFERENCES ts.transport (transport_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (route_id) REFERENCES ts.route (route_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (curr_stop_id) REFERENCES ts.stop (stop_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ts.trip_history
(
    trip_id      INTEGER,
    curr_stop_id INTEGER,
    update_dttm  TIMESTAMP NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES ts.trip (trip_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (curr_stop_id) REFERENCES ts.stop (stop_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TYPE ts.FUEL_TYPE AS ENUM ('petrol', 'gas', 'electricity');

CREATE TABLE IF NOT EXISTS ts.bus_info
(
    transport_id INTEGER,
    bus_no       VARCHAR(30) UNIQUE,
    fuel         ts.FUEL_TYPE,
    capacity     INTEGER,
    FOREIGN KEY (transport_id) REFERENCES ts.transport (transport_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ts.metro_info
(
    transport_id INTEGER,
    cars_cnt     INTEGER,
    capacity     INTEGER,
    depot        VARCHAR(30),
    FOREIGN KEY (transport_id) REFERENCES ts.transport (transport_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

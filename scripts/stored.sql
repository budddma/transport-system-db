-- Функции

-- Поддерживает версинирование SCD 4 для trip

CREATE OR REPLACE FUNCTION ts.update_curr_stop()
    RETURNS TRIGGER AS
$$
BEGIN
    IF (EXISTS (SELECT 1 FROM ts.trip_history AS th WHERE th.trip_id = NEW.trip_id))
    THEN
        UPDATE ts.trip_history
        SET curr_stop_id = OLD.curr_stop_id,
            update_dttm  = now()
        WHERE ts.trip_history.trip_id = NEW.trip_id;
    ELSE
        INSERT INTO ts.trip_history (trip_id, curr_stop_id, update_dttm)
        VALUES (NEW.trip_id, OLD.curr_stop_id, now());
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

--- Проверяет новые значения на DQ check

CREATE OR REPLACE FUNCTION ts.check_trip()
    RETURNS TRIGGER AS
$$
DECLARE
    transport_bus_flg boolean;
    route_bus_flg     boolean;
    stop_bus_flg      boolean;
BEGIN
    SELECT bus_flg
    INTO transport_bus_flg
    FROM ts.transport AS t
    WHERE t.transport_id = NEW.transport_id;

    SELECT bus_flg
    INTO route_bus_flg
    FROM ts.route AS r
             JOIN ts.stop ON (initial_stop_id = stop_id)
    WHERE r.route_id = NEW.route_id;

    SELECT bus_flg
    INTO stop_bus_flg
    FROM ts.stop AS s
    WHERE s.stop_id = NEW.curr_stop_id;

    IF (transport_bus_flg = route_bus_flg and route_bus_flg = stop_bus_flg) THEN
        RETURN NULL;
    ELSE
        RAISE EXCEPTION 'bus_flg добавляемых значений не согласован';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Триггеры

CREATE OR REPLACE TRIGGER trip_update_trigger
    AFTER UPDATE OF curr_stop_id
    ON ts.trip
    FOR EACH ROW
    WHEN (OLD.curr_stop_id IS DISTINCT FROM NEW.curr_stop_id)
EXECUTE FUNCTION ts.update_curr_stop();

CREATE OR REPLACE TRIGGER trip_check_trigger
    BEFORE INSERT or UPDATE
    ON ts.trip
    FOR EACH ROW
EXECUTE FUNCTION ts.check_trip();

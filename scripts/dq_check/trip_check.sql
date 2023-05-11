WITH r as (SELECT route_id, bus_flg
           from ts.route
                    JOIN ts.stop
                         on (initial_stop_id = stop_id))

SELECT trip_id, trans.bus_flg as transport_bus_flg, r.bus_flg as route_bus_flg, s.bus_flg AS stop_bus_flg
from ts.trip
         join ts.transport as trans using (transport_id)
         join r using (route_id)
         join ts.stop AS s on (curr_stop_id = s.stop_id);

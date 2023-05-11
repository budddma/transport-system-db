SELECT route_id, init_stop.bus_flg as init_bus_flg, final_stop.bus_flg as final_bus_flg FROM ts.route
    JOIN ts.stop as init_stop
        on (initial_stop_id = init_stop.stop_id)
    JOIN ts.stop as final_stop
        on (route.final_stop_id = final_stop.stop_id);

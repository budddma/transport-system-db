SELECT transport_id, bus_flg as real_bus_flg, true as expected_bus_flg
FROM ts.bus_info
    JOIN ts.transport USING (transport_id)
UNION
SELECT transport_id, bus_flg as real_bus_flg, false as expected_bus_flg
FROM ts.metro_info
    JOIN ts.transport USING (transport_id)

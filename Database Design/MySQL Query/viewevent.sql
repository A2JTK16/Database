CREATE OR REPLACE VIEW viewevent AS SELECT 
event.traveller_username
, event.start_location_id 
, event.end_location_id
, event.event_id
, event.event_name 
, event.start_event 
, event.end_event
, event.note

, l1.location_name as start_location_name
, l1.latitude as strt_loc_lat
, l1.longitude as strt_loc_long

, l2.location_name as end_location_name
, l2.latitude as end_loc_lat
, l2.longitude as end_loc_long

, travel.depature_time
, travel.transportation_mode
FROM event 
INNER JOIN location l1 ON event.start_location_id = l1.location_id /* inner join : hanya yg berelasi yg dijoin, beda dengan left join dan right join */
INNER JOIN location l2 ON event.end_location_id = l2.location_id
NATURAL JOIN travel; /* natural join : yg sama ditulis sekali */

Create or replace view view_event as
SELECT DISTINCT
      Tl.traveller_username AS Username, Tl.traveller_fullname AS Fullname,  Tl.traveller_address AS Home_Address,
      E.event_name AS Event_Name, E.start_event AS Start_Event, E.end_event AS End_Event, E.note AS Event_Note,
      L1.location_name AS Start_Location_Name , L1.latitude as strt_loc_lat , L1.longitude as strt_loc_long,
      L2.location_name AS Event_Location_name, L2.latitude as end_loc_lat , L2.longitude as end_loc_long,
	    T.transportation_mode, T.depature_time AS Depature_Time
   FROM
      traveller Tl, event E, location L1, location L2, travel T
   WHERE
      Tl.traveller_username = E.traveller_username
      AND
      E.event_id = T.event_id
      And
      L1.location_id = E.Start_Location_id
	  and
	  L2.location_id = E.End_Location_Id;
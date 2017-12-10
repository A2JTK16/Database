/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     12/5/2017 1:16:04 AM                         */
/*==============================================================*/


drop table if exists EVENT;

drop table if exists LOCATION;

drop table if exists TRANSPORTATION_MODE;

drop table if exists TRAVEL;

drop table if exists TRAVELLER;

/*==============================================================*/
/* Table: EVENT                                                 */
/*==============================================================*/
create table EVENT
(
   TRAVELLER_USERNAME   varchar(30) not null,
   START_LOCATION_ID    int not null,
   END_LOCATION_ID      int not null,
   EVENT_ID             bigint not null auto_increment,
   EVENT_NAME           varchar(35) not null,
   START_EVENT          datetime not null,
   END_EVENT            datetime not null,
   NOTE                 text,
   primary key (TRAVELLER_USERNAME, START_LOCATION_ID, END_LOCATION_ID, EVENT_ID)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   LOCATION_ID          int not null auto_increment,
   LATITUDE             float,
   LONGITUDE            float,
   LOCATION_NAME        varchar(100),
   primary key (LOCATION_ID)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: TRANSPORTATION_MODE                                   */
/*==============================================================*/
create table TRANSPORTATION_MODE
(
   TRANSPORTATION_CODE  char(2) not null,
   TRANSPORTATION_NAME  varchar(30),
   TRANSPORTATION_SPEED float,
   primary key (TRANSPORTATION_CODE)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: TRAVEL                                                */
/*==============================================================*/
create table TRAVEL
(
   TRAVELLER_USERNAME   varchar(30) not null,
   START_LOCATION_ID    int not null,
   END_LOCATION_ID      int not null,
   EVENT_ID             bigint not null,
   TRANSPORTATION_CODE  char(2) not null,
   DEPATURE_TIME        datetime,
   primary key (TRAVELLER_USERNAME, START_LOCATION_ID, END_LOCATION_ID, EVENT_ID)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: TRAVELLER                                             */
/*==============================================================*/
create table TRAVELLER
(
   TRAVELLER_USERNAME   varchar(30) not null,
   TRAVELLER_EMAIL      varchar(40),
   TRAVELLER_PASSWORD   varchar(25),
   TRAVELLER_FULLNAME   varchar(50),
   TRAVELLER_ADDRESS    varchar(60),
   primary key (TRAVELLER_USERNAME)
)ENGINE=MyISAM;

alter table EVENT add constraint FK_CREATE foreign key (TRAVELLER_USERNAME)
      references TRAVELLER (TRAVELLER_USERNAME) on delete restrict on update restrict;

alter table EVENT add constraint FK_LOCATED foreign key (START_LOCATION_ID)
      references LOCATION (LOCATION_ID) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_4 foreign key (END_LOCATION_ID)
      references LOCATION (LOCATION_ID) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_MEMILIKI_PE_AG foreign key (TRAVELLER_USERNAME, START_LOCATION_ID, END_LOCATION_ID, EVENT_ID)
      references EVENT (TRAVELLER_USERNAME, START_LOCATION_ID, END_LOCATION_ID, EVENT_ID) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_NEED foreign key (TRANSPORTATION_CODE)
      references TRANSPORTATION_MODE (TRANSPORTATION_CODE) on delete restrict on update restrict;

INSERT INTO traveller (traveller_username,traveller_email, traveller_password, traveller_fullname, traveller_address) VALUES 
   ('nmuntaaza','naufalmwh11@gmail.com','qwerty','Naufal Muntaaza Waliy Hibatullah', 'Ciwaruga'),
   ('alpinj', 'alpinj@yahoo.com', 'asdfg', 'Alpin Jestinera', 'Bekasi');

INSERT INTO location (latitude, longitude, location_name) VALUES
   (-6.872034, 107.574794, 'Politeknik Negeri Bandung'),
   (-6.861166, 107.592947, 'UPI Bandung');

INSERT INTO transportation_mode (transportation_code, transportation_name, transportation_speed) VALUES
   ('MB', 'Mobil', 45),
   ('MT', 'Motor', 50);

INSERT INTO event (traveller_username, start_location_id, end_location_id, event_name, start_event, end_event, note) VALUES 
   ('nmuntaaza', 1, 2, 'Kajian Abu Takeru', '2017-12-10 15:00:00', '2017-12-10 17:00:00', 'Minjem Helm');

INSERT INTO travel (traveller_username, start_location_id, end_location_id, event_id, transportation_code, depature_time) VALUES
   ('nmuntaaza', 1, 2, 1, 'MB', '2017-12-10 15:30:00');

-- Function login --
DROP FUNCTION IF EXISTS isThereUser;
DELIMITER //
   CREATE FUNCTION isThereUser(usrname VARCHAR(30), pass VARCHAR(25)) RETURNS BOOLEAN DETERMINISTIC
   BEGIN

   DECLARE result BOOLEAN;

   SELECT COUNT(*) INTO @temp FROM traveller WHERE (traveller_username = usrname AND traveller_password = pass);
   IF @temp = 1 THEN SET result = TRUE;
   ELSEIF @temp = 0 THEN SET result = FALSE;
   END IF;

   RETURN(result);
   END //
DELIMITER ;


create view faiz
Create or replace view view_event as
SELECT DISTINCT
      Tl.traveller_username AS Username, Tl.traveller_fullname AS Fullname,  Tl.traveller_address AS Home_Address,
      E.event_id AS Event_ID, E.event_name AS Event_Name, E.start_event AS Start_Event, E.end_event AS End_Event, E.note AS Event_Note,
      L1.location_id as Start_Location_id, L1.location_name AS Start_Location_Event , L2.location_id as End_Location_Id, L2.location_name AS End_Location_Event, 
	  TM.transportation_name AS Transportation_Mode, T.depature_time AS Depature_Time
   FROM
      traveller Tl, event E, location L1, location L2, transportation_mode TM, travel T
   WHERE
      Tl.traveller_username = E.traveller_username
      AND
      E.event_id = T.event_id
      AND
      T.transportation_code = TM.transportation_code
      And
      L1.location_id = E.Start_Location_id 
	  and
	  L2.location_id = E.End_Location_Id;
     
/*

CREATE VIEW VEVENT AS
   SELECT 
      Tl.traveller_username AS Username, Tl.traveller_fullname AS Fullname,  Tl.traveller_address AS Home_Address, 
      E.event_id AS Event_ID, E.event_name AS Event_Name, E.start_event AS Start_Event, E.end_event AS End_Event, E.note AS Event_Note, 
      L.location_name AS Location_Event, TM.transportation_name AS Transportation_Mode, T.depature_time AS Depature_Time 
   FROM
      traveller Tl, event E, location L, transportation_mode TM, travel T 
   WHERE
      Tl.traveller_username = E.traveller_username
      AND
      E.event_id = T.event_id
      AND
      T.transportation_code = TM.transportation_code;

------------------------------
CREATE VIEW VEVENT AS
SELECT DISTINCT
      Tl.traveller_username AS Username, Tl.traveller_fullname AS Fullname,  Tl.traveller_address AS Home_Address, 
      E.event_id AS Event_ID, E.event_name AS Event_Name, E.start_event AS Start_Event, E.end_event AS End_Event, E.note AS Event_Note, 
      E.start_location_id AS Start_Location_Event, E.end_location_id AS End_Location_Event, TM.transportation_name AS Transportation_Mode, T.depature_time AS Depature_Time 
   FROM
      traveller Tl, event E, location L, transportation_mode TM, travel T 
   WHERE
      Tl.traveller_username = E.traveller_username
      AND
      E.event_id = T.event_id
      AND
      T.transportation_code = TM.transportation_code;

*/

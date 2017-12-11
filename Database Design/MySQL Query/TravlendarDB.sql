/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     12/11/2017 11:24:38 AM                       */
/*==============================================================*/


drop table if exists EVENT;

drop table if exists LOCATION;

drop table if exists TRAVEL;

drop table if exists TRAVELLER;

/*==============================================================*/
/* Table: EVENT                                                 */
/*==============================================================*/
create table EVENT
(
   traveller_username   varchar(30) not null,
   location_id          int not null,
   loc_location_id      int not null,
   event_id             bigint not null auto_increment,
   event_name           varchar(35) not null,
   start_event          datetime not null,
   end_event            datetime not null,
   note                 text,
   primary key (traveller_username, location_id, loc_location_id, event_id)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   location_id          int not null auto_increment,
   latitude             float not null,
   longitude            float not null,
   location_name        varchar(100),
   primary key (location_id)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: TRAVEL                                                */
/*==============================================================*/
create table TRAVEL
(
   traveller_username   varchar(30) not null,
   location_id          int not null,
   loc_location_id      int not null,
   event_id             bigint not null,
   depature_time        datetime not null,
   transportation_mode  enum('walking', 'driving', 'bicycling', 'transit') not null,
   primary key (traveller_username, location_id, loc_location_id, event_id)
)ENGINE=MyISAM;

/*==============================================================*/
/* Table: TRAVELLER                                             */
/*==============================================================*/
create table TRAVELLER
(
   traveller_username   varchar(30) not null,
   traveller_email      varchar(40) unique not null,
   traveller_password   varchar(25) not null,
   traveller_fullname   varchar(50),
   traveller_address    varchar(60),
   primary key (traveller_username)
)ENGINE=MyISAM;

alter table EVENT add constraint FK_CREATE foreign key (traveller_username)
      references TRAVELLER (traveller_username) on delete restrict on update restrict;

alter table EVENT add constraint FK_LOCATED foreign key (location_id)
      references LOCATION (location_id) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_4 foreign key (loc_location_id)
      references LOCATION (location_id) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_MEMILIKI_PE_AG foreign key (traveller_username, location_id, loc_location_id, event_id)
      references EVENT (traveller_username, location_id, loc_location_id, event_id) on delete restrict on update restrict;


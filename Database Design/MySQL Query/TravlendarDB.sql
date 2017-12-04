/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     12/4/2017 11:01:38 PM                        */
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
   LOCATION_ID          int not null,
   LOC_LOCATION_ID      int not null,
   EVENT_ID             bigint not null,
   EVENT_NAME           varchar(35) not null,
   START_EVENT          datetime not null,
   END_EVENT            datetime not null,
   NOTE                 text,
   primary key (TRAVELLER_USERNAME, LOCATION_ID, LOC_LOCATION_ID, EVENT_ID)
);

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   LOCATION_ID          int not null,
   LATITUDE             float,
   LONGITUDE            float,
   primary key (LOCATION_ID)
);

/*==============================================================*/
/* Table: TRANSPORTATION_MODE                                   */
/*==============================================================*/
create table TRANSPORTATION_MODE
(
   TRANSPORTATION_CODE  char(2) not null,
   TRANSPORTATION_NAME  varchar(30),
   TRANSPORTATION_SPEED float,
   primary key (TRANSPORTATION_CODE)
);

/*==============================================================*/
/* Table: TRAVEL                                                */
/*==============================================================*/
create table TRAVEL
(
   TRAVELLER_USERNAME   varchar(30) not null,
   LOCATION_ID          int not null,
   LOC_LOCATION_ID      int not null,
   EVENT_ID             bigint not null,
   TRANSPORTATION_CODE  char(2) not null,
   DEPATURE_TIME        datetime,
   primary key (TRAVELLER_USERNAME, LOCATION_ID, LOC_LOCATION_ID, EVENT_ID)
);

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
);

alter table EVENT add constraint FK_CREATE foreign key (TRAVELLER_USERNAME)
      references TRAVELLER (TRAVELLER_USERNAME) on delete restrict on update restrict;

alter table EVENT add constraint FK_LOCATED foreign key (LOCATION_ID)
      references LOCATION (LOCATION_ID) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_4 foreign key (LOC_LOCATION_ID)
      references LOCATION (LOCATION_ID) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_MEMILIKI_PE_AG foreign key (TRAVELLER_USERNAME, LOCATION_ID, LOC_LOCATION_ID, EVENT_ID)
      references EVENT (TRAVELLER_USERNAME, LOCATION_ID, LOC_LOCATION_ID, EVENT_ID) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_NEED foreign key (TRANSPORTATION_CODE)
      references TRANSPORTATION_MODE (TRANSPORTATION_CODE) on delete restrict on update restrict;


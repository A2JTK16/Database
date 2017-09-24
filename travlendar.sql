/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     9/24/2017 9:09:19 PM                         */
/*==============================================================*/


drop table if exists EVENT;

drop table if exists LOCATION;

drop table if exists RELATIONSHIP_4;

drop table if exists TRAVELLER;

/*==============================================================*/
/* Table: EVENT                                                 */
/*==============================================================*/
create table EVENT
(
   ID_EVENT             bigint not null,
   ID_PLACE             int not null,
   ID_TRAVELLER         bigint,
   EVENTNAME            varchar(35),
   ARRIVALTIME          datetime,
   DEPATURETIME         datetime,
   primary key (ID_EVENT)
);

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   ID_PLACE             int not null,
   ID_EVENT             bigint,
   ID_TRAVELLER         bigint,
   NM_PLACE             varchar(20),
   primary key (ID_PLACE)
);

/*==============================================================*/
/* Table: RELATIONSHIP_4                                        */
/*==============================================================*/
create table RELATIONSHIP_4
(
   ID_PLACE             int not null,
   LOC_ID_PLACE         int not null,
   DISTANCE             float,
   primary key (ID_PLACE, LOC_ID_PLACE)
);

/*==============================================================*/
/* Table: TRAVELLER                                             */
/*==============================================================*/
create table TRAVELLER
(
   ID_TRAVELLER         bigint not null,
   ID_PLACE             int not null,
   USERNAME             varchar(20),
   EMAIL                varchar(40),
   PASSWORD             varchar(25),
   FULLNAME             varchar(30),
   primary key (ID_TRAVELLER)
);

alter table EVENT add constraint FK_RELATIONSHIP_7 foreign key (ID_TRAVELLER)
      references TRAVELLER (ID_TRAVELLER) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_8 foreign key (ID_PLACE)
      references LOCATION (ID_PLACE) on delete restrict on update restrict;

alter table LOCATION add constraint FK_ALAMAT_RUMAH foreign key (ID_TRAVELLER)
      references TRAVELLER (ID_TRAVELLER) on delete restrict on update restrict;

alter table LOCATION add constraint FK_RELATIONSHIP_9 foreign key (ID_EVENT)
      references EVENT (ID_EVENT) on delete restrict on update restrict;

alter table RELATIONSHIP_4 add constraint FK_RELATIONSHIP_5 foreign key (ID_PLACE)
      references LOCATION (ID_PLACE) on delete restrict on update restrict;

alter table RELATIONSHIP_4 add constraint FK_RELATIONSHIP_6 foreign key (LOC_ID_PLACE)
      references LOCATION (ID_PLACE) on delete restrict on update restrict;

alter table TRAVELLER add constraint FK_ALAMAT_RUMAH2 foreign key (ID_PLACE)
      references LOCATION (ID_PLACE) on delete restrict on update restrict;


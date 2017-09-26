/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     26/09/2017 07:30:06                          */
/*==============================================================*/


drop table if exists DISTANCEMATRIX;

drop table if exists EVENT;

drop table if exists LOCATION;

drop table if exists TRAVELLER;

/*==============================================================*/
/* Table: DISTANCEMATRIX                                        */
/*==============================================================*/
create table DISTANCEMATRIX
(
   LOC_KODE_LOKASI      int not null,
   KODE_LOKASI          int not null,
   JARAK                float,
   primary key (LOC_KODE_LOKASI, KODE_LOKASI)
);

/*==============================================================*/
/* Table: EVENT                                                 */
/*==============================================================*/
create table EVENT
(
   KODE_LOKASI          int not null,
   ID_EVENT             bigint not null,
   ID_TRAVELLER         bigint not null,
   NAMA_EVENT           varchar(35),
   ARRIVALTIME          datetime,
   DEPATURETIME         datetime,
   KDTRANSPORTATIONMODE smallint,
   primary key (ID_TRAVELLER, KODE_LOKASI, ID_EVENT)
)
auto_increment = ID_EVENT;

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   KODE_LOKASI          int not null,
   NAMA_LOKASI          varchar(25),
   primary key (KODE_LOKASI)
)
auto_increment = KODE_LOKASI;

/*==============================================================*/
/* Table: TRAVELLER                                             */
/*==============================================================*/
create table TRAVELLER
(
   ID_TRAVELLER         bigint not null,
   KODE_LOKASI          int,
   USERNAME             varchar(30),
   EMAIL                varchar(40),
   PASSWORD             varchar(255),
   FULLNAME             varchar(50),
   primary key (ID_TRAVELLER)
)
auto_increment = ID_TRAVELLER;

alter table DISTANCEMATRIX add constraint FK_RELATIONSHIP_5 foreign key (LOC_KODE_LOKASI)
      references LOCATION (KODE_LOKASI) on delete restrict on update restrict;

alter table DISTANCEMATRIX add constraint FK_RELATIONSHIP_6 foreign key (KODE_LOKASI)
      references LOCATION (KODE_LOKASI) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_7 foreign key (ID_TRAVELLER)
      references TRAVELLER (ID_TRAVELLER) on delete restrict on update restrict;

alter table EVENT add constraint FK_RELATIONSHIP_8 foreign key (KODE_LOKASI)
      references LOCATION (KODE_LOKASI) on delete restrict on update restrict;

alter table TRAVELLER add constraint FK_ALAMAT_RUMAH foreign key (KODE_LOKASI)
      references LOCATION (KODE_LOKASI) on delete restrict on update restrict;


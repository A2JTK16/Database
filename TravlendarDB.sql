/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     10/16/2017 8:24:09 PM                        */
/*==============================================================*/


drop table if exists CITY;

drop table if exists DISTANCE;

drop table if exists EVENT;

drop table if exists LOCATION;

drop table if exists PROVINCE;

drop table if exists TRANSPORTATION_MODE;

drop table if exists TRAVEL;

drop table if exists TRAVELLER;

/*==============================================================*/
/* Table: CITY                                                  */
/*==============================================================*/
create table CITY
(
   PROVINCE_CODE        char(2) not null,
   CITY_CODE            char(2) not null,
   CITY_NAME            varchar(50),
   primary key (PROVINCE_CODE, CITY_CODE)
);

/*==============================================================*/
/* Table: DISTANCE                                              */
/*==============================================================*/
create table DISTANCE
(
   KD_PROVINSI_AKHIR    char(2) not null,
   KD_KOTA_AKHIR        char(2) not null,
   ID_LOKASI_AKHIR      int not null,
   KD_PROVINSI_AWAL     char(2) not null,
   KD_KOTA_AWAL         char(2) not null,
   ID_LOKASI_AWAL       int not null,
   DISTANCE             float,
   primary key (KD_PROVINSI_AKHIR, KD_KOTA_AKHIR, ID_LOKASI_AKHIR, KD_PROVINSI_AWAL, KD_KOTA_AWAL, ID_LOKASI_AWAL)
);

/*==============================================================*/
/* Table: EVENT                                                 */
/*==============================================================*/
create table EVENT
(
   TRAVELLER_ID         bigint not null,
   PROVINCE_CODE        char(2) not null,
   CITY_CODE            char(2) not null,
   LOCATION_ID          int not null,
   EVENT_ID             bigint not null,
   EVENT_NAME           varchar(35) not null,
   START_EVENT          datetime not null,
   END_EVENT            datetime not null,
   NOTE                 text,
   PLACE                varchar(25),
   primary key (TRAVELLER_ID, PROVINCE_CODE, CITY_CODE, LOCATION_ID, EVENT_ID)
);

/*==============================================================*/
/* Table: LOCATION                                              */
/*==============================================================*/
create table LOCATION
(
   PROVINCE_CODE        char(2) not null,
   CITY_CODE            char(2) not null,
   LOCATION_ID          int not null,
   ADDRESS_PLACE        varchar(55),
   primary key (PROVINCE_CODE, CITY_CODE, LOCATION_ID)
);

/*==============================================================*/
/* Table: PROVINCE                                              */
/*==============================================================*/
create table PROVINCE
(
   PROVINCE_CODE        char(2) not null,
   PROVINCE_NAME        varchar(50),
   primary key (PROVINCE_CODE)
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
   TRANSPORTATION_CODE  char(2) not null,
   TRAVELLER_ID         bigint not null,
   PROVINCE_CODE        char(2) not null,
   CITY_CODE            char(2) not null,
   LOCATION_ID          int not null,
   EVENT_ID             bigint not null,
   DEPATURE_TIME        datetime,
   primary key (TRAVELLER_ID, PROVINCE_CODE, CITY_CODE, LOCATION_ID, TRANSPORTATION_CODE, EVENT_ID)
);

/*==============================================================*/
/* Table: TRAVELLER                                             */
/*==============================================================*/
create table TRAVELLER
(
   TRAVELLER_ID         bigint not null,
   TRAVELLER_NAME       varchar(20),
   TRAVELLER_EMAIL      varchar(40),
   TRAVELLER_PASSWORD   varchar(25),
   TRAVELLER_FULLNAME   varchar(50),
   primary key (TRAVELLER_ID)
);

alter table CITY add constraint FK_HAS_CITY_PROV foreign key (PROVINCE_CODE)
      references PROVINCE (PROVINCE_CODE) on delete restrict on update restrict;

alter table DISTANCE add constraint FK_END_LOCATION foreign key (KD_PROVINSI_AWAL, KD_KOTA_AWAL, ID_LOKASI_AWAL)
      references LOCATION (PROVINCE_CODE, CITY_CODE, LOCATION_ID) on delete restrict on update restrict;

alter table DISTANCE add constraint FK_START_LOCATION foreign key (KD_PROVINSI_AKHIR, KD_KOTA_AKHIR, ID_LOKASI_AKHIR)
      references LOCATION (PROVINCE_CODE, CITY_CODE, LOCATION_ID) on delete restrict on update restrict;

alter table EVENT add constraint FK_CREATE foreign key (TRAVELLER_ID)
      references TRAVELLER (TRAVELLER_ID) on delete restrict on update restrict;

alter table EVENT add constraint FK_LOCATED foreign key (PROVINCE_CODE, CITY_CODE, LOCATION_ID)
      references LOCATION (PROVINCE_CODE, CITY_CODE, LOCATION_ID) on delete restrict on update restrict;

alter table LOCATION add constraint FK_HAS_CITY_LOC foreign key (PROVINCE_CODE, CITY_CODE)
      references CITY (PROVINCE_CODE, CITY_CODE) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_MEMILIKI_PE_AG foreign key (TRAVELLER_ID, PROVINCE_CODE, CITY_CODE, LOCATION_ID, EVENT_ID)
      references EVENT (TRAVELLER_ID, PROVINCE_CODE, CITY_CODE, LOCATION_ID, EVENT_ID) on delete restrict on update restrict;

alter table TRAVEL add constraint FK_NEED foreign key (TRANSPORTATION_CODE)
      references TRANSPORTATION_MODE (TRANSPORTATION_CODE) on delete restrict on update restrict;

INSERT INTO `province` VALUES ('11', 'ACEH');
INSERT INTO `province` VALUES ('12', 'SUMATERA UTARA');
INSERT INTO `province` VALUES ('13', 'SUMATERA BARAT');
INSERT INTO `province` VALUES ('14', 'RIAU');
INSERT INTO `province` VALUES ('15', 'JAMBI');
INSERT INTO `province` VALUES ('16', 'SUMATERA SELATAN');
INSERT INTO `province` VALUES ('17', 'BENGKULU');
INSERT INTO `province` VALUES ('18', 'LAMPUNG');
INSERT INTO `province` VALUES ('19', 'KEPULAUAN BANGKA BELITUNG');
INSERT INTO `province` VALUES ('21', 'KEPULAUAN RIAU');
INSERT INTO `province` VALUES ('31', 'DKI JAKARTA');
INSERT INTO `province` VALUES ('32', 'JAWA BARAT');
INSERT INTO `province` VALUES ('33', 'JAWA TENGAH');
INSERT INTO `province` VALUES ('34', 'DI YOGYAKARTA');
INSERT INTO `province` VALUES ('35', 'JAWA TIMUR');
INSERT INTO `province` VALUES ('36', 'BANTEN');
INSERT INTO `province` VALUES ('51', 'BALI');
INSERT INTO `province` VALUES ('52', 'NUSA TENGGARA BARAT');
INSERT INTO `province` VALUES ('53', 'NUSA TENGGARA TIMUR');
INSERT INTO `province` VALUES ('61', 'KALIMANTAN BARAT');
INSERT INTO `province` VALUES ('62', 'KALIMANTAN TENGAH');
INSERT INTO `province` VALUES ('63', 'KALIMANTAN SELATAN');
INSERT INTO `province` VALUES ('64', 'KALIMANTAN TIMUR');
INSERT INTO `province` VALUES ('65', 'KALIMANTAN UTARA');
INSERT INTO `province` VALUES ('71', 'SULAWESI UTARA');
INSERT INTO `province` VALUES ('72', 'SULAWESI TENGAH');
INSERT INTO `province` VALUES ('73', 'SULAWESI SELATAN');
INSERT INTO `province` VALUES ('74', 'SULAWESI TENGGARA');
INSERT INTO `province` VALUES ('75', 'GORONTALO');
INSERT INTO `province` VALUES ('76', 'SULAWESI BARAT');
INSERT INTO `province` VALUES ('81', 'MALUKU');
INSERT INTO `province` VALUES ('82', 'MALUKU UTARA');
INSERT INTO `province` VALUES ('91', 'PAPUA BARAT');
INSERT INTO `province` VALUES ('94', 'PAPUA');


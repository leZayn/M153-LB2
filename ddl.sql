create or replace table tbl_land
(
	land_id int auto_increment
		primary key,
	name varchar(255) not null,
	constraint tbl_land_name_uindex
		unique (name)
);

create or replace table tbl_mitarbeiter
(
	mitarbeiter_id int auto_increment
		primary key,
	vorname varchar(255) not null,
	nachname varchar(255) null,
	constraint tbl_mitarbeiter_vorname_nachname_uindex
		unique (vorname, nachname)
);

create or replace table tbl_produktkategorie
(
	produktkategorie_id int auto_increment
		primary key,
	name varchar(255) not null,
	constraint tbl_produktkategorie_name_uindex
		unique (name)
);

create or replace table tbl_standort
(
	standort_id int auto_increment
		primary key,
	ortschaft varchar(255) not null,
	plz varchar(255) not null,
	id_land int not null,
	constraint tbl_standort_standort_id_ortschaft_plz_uindex
		unique (standort_id, ortschaft, plz),
	constraint tbl_standort_tbl_land_land_id_fk
		foreign key (id_land) references tbl_land (land_id)
);

create or replace table tbl_hersteller
(
	hersteller_id int auto_increment
		primary key,
	name varchar(255) not null,
	id_standort int null,
	constraint tbl_hersteller_name_uindex
		unique (name),
	constraint tbl_hersteller_tbl_standort_standort_id_fk
		foreign key (id_standort) references tbl_standort (standort_id)
);

create or replace table tbl_artikel
(
	artikel_id int auto_increment
		primary key,
	id_produktkategorie int not null,
	id_hersteller int not null,
	id_standort int not null,
	id_mitarbeiter int not null,
	anzahl int null,
	name varchar(255) null,
	stockwerk int null,
	regal varchar(255) null,
	ablage int null,
	constraint tbl_artikel_anzahl_name_stockwerk_regal_ablage_uindex
		unique (anzahl, name, stockwerk, regal, ablage),
	constraint tbl_artikel_tbl_hersteller_hersteller_id_fk
		foreign key (id_hersteller) references tbl_hersteller (hersteller_id),
	constraint tbl_artikel_tbl_mitarbeiter_mitarbeiter_id_fk
		foreign key (id_mitarbeiter) references tbl_mitarbeiter (mitarbeiter_id),
	constraint tbl_artikel_tbl_produktkategorie_produktkategorie_id_fk
		foreign key (id_produktkategorie) references tbl_produktkategorie (produktkategorie_id),
	constraint tbl_artikel_tbl_standort_standort_id_fk
		foreign key (id_standort) references tbl_standort (standort_id)
);

create or replace definer = root@`%` trigger artikel_transfer_insert
	after insert
	on tbl_artikel
	for each row
	BEGIN
    INSERT INTO tbl_transfer
    SET id_artikel = NEW.artikel_id,
        eingang = NOW(),
        ausgang = null,
        anzahl = NEW.anzahl;
    END;

create or replace definer = root@`%` trigger artikel_transfer_update
	after update
	on tbl_artikel
	for each row
	BEGIN
    INSERT INTO tbl_transfer
    SET id_artikel = OLD.artikel_id,
        eingang = null,
        ausgang = NOW(),
        anzahl = OLD.anzahl - NEW.anzahl;
    END;

create or replace table tbl_transfer
(
	transfer_id int auto_increment
		primary key,
	id_artikel int null,
	eingang datetime null,
	ausgang datetime null,
	anzahl int null,
	constraint tbl_transfer_tbl_artikel_artikel_id_fk
		foreign key (id_artikel) references tbl_artikel (artikel_id)
);

create or replace definer = root@`%` view AlleProduktInformationen as
	select `LB03_Lagerverwaltung`.`tbl_artikel`.`name`                 AS `name`,
       `tp`.`name`                                                 AS `Produktkategorie`,
       `th`.`name`                                                 AS `hersteller`,
       `LB03_Lagerverwaltung`.`tbl_artikel`.`anzahl`               AS `anzahl`,
       concat(`tm`.`vorname`, ' ', `tm`.`nachname`)                AS `Verantwortlicher`,
       concat(`ts`.`plz`, ' ', `ts`.`ortschaft`, ' ', `tl`.`name`) AS `Standort`,
       `LB03_Lagerverwaltung`.`tbl_artikel`.`stockwerk`            AS `stockwerk`,
       `LB03_Lagerverwaltung`.`tbl_artikel`.`regal`                AS `regal`,
       `LB03_Lagerverwaltung`.`tbl_artikel`.`ablage`               AS `ablage`
from ((((((`LB03_Lagerverwaltung`.`tbl_artikel` join `LB03_Lagerverwaltung`.`tbl_produktkategorie` `t` on (
        `LB03_Lagerverwaltung`.`tbl_artikel`.`id_produktkategorie` =
        `t`.`produktkategorie_id`)) left join `LB03_Lagerverwaltung`.`tbl_hersteller` `th` on (`th`.`hersteller_id` =
                                                                                               `LB03_Lagerverwaltung`.`tbl_artikel`.`id_hersteller`)) left join `LB03_Lagerverwaltung`.`tbl_produktkategorie` `tp` on (
        `tp`.`produktkategorie_id` =
        `LB03_Lagerverwaltung`.`tbl_artikel`.`id_produktkategorie`)) left join `LB03_Lagerverwaltung`.`tbl_mitarbeiter` `tm` on (
        `tm`.`mitarbeiter_id` =
        `LB03_Lagerverwaltung`.`tbl_artikel`.`id_mitarbeiter`)) join `LB03_Lagerverwaltung`.`tbl_standort` `ts` on (
        `ts`.`standort_id` = `LB03_Lagerverwaltung`.`tbl_artikel`.`id_standort`))
         join `LB03_Lagerverwaltung`.`tbl_land` `tl` on (`tl`.`land_id` = `ts`.`id_land`));


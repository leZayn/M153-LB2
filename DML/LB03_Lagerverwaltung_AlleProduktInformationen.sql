create definer = root@`%` view AlleProduktInformationen as
select `LB03-Lagerverwaltung`.`tbl_artikel`.`name`                 AS `name`,
       `tp`.`name`                                                 AS `Produktkategorie`,
       `th`.`name`                                                 AS `hersteller`,
       `LB03-Lagerverwaltung`.`tbl_artikel`.`anzahl`               AS `anzahl`,
       concat(`tm`.`vorname`, ' ', `tm`.`nachname`)                AS `Verantwortlicher`,
       concat(`ts`.`plz`, ' ', `ts`.`ortschaft`, ' ', `tl`.`name`) AS `Standort`,
       `LB03-Lagerverwaltung`.`tbl_artikel`.`stockwerk`            AS `stockwerk`,
       `LB03-Lagerverwaltung`.`tbl_artikel`.`regal`                AS `regal`,
       `LB03-Lagerverwaltung`.`tbl_artikel`.`ablage`               AS `ablage`
from ((((((`LB03-Lagerverwaltung`.`tbl_artikel` join `LB03-Lagerverwaltung`.`tbl_produktkategorie` `t` on (
        `LB03-Lagerverwaltung`.`tbl_artikel`.`id_produktkategorie` =
        `t`.`produktkategorie_id`)) left join `LB03-Lagerverwaltung`.`tbl_hersteller` `th` on (`th`.`hersteller_id` =
                                                                                               `LB03-Lagerverwaltung`.`tbl_artikel`.`id_hersteller`)) left join `LB03-Lagerverwaltung`.`tbl_produktkategorie` `tp` on (
        `tp`.`produktkategorie_id` =
        `LB03-Lagerverwaltung`.`tbl_artikel`.`id_produktkategorie`)) left join `LB03-Lagerverwaltung`.`tbl_mitarbeiter` `tm` on (
        `tm`.`mitarbeiter_id` =
        `LB03-Lagerverwaltung`.`tbl_artikel`.`id_mitarbeiter`)) join `LB03-Lagerverwaltung`.`tbl_standort` `ts` on (
        `ts`.`standort_id` = `LB03-Lagerverwaltung`.`tbl_artikel`.`id_standort`))
         join `LB03-Lagerverwaltung`.`tbl_land` `tl` on (`tl`.`land_id` = `ts`.`id_land`));

INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('SSD Speicher', 'Speicher', 'Samsung', 10, 'Monika Monk', '8155 Niederhasli Schweiz', 1, 'D', 12);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('SSD Speicher', 'Speicher', 'Samsung', 12, 'Peter SChmitt', '8604 Volketswil Schweiz', 2, 'A', 22);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Laptop Netzteil ', 'PC Netzteil', 'Asus', 6, 'Mehmet al hayat', '8155 Niederhasli Schweiz', 3, 'R', 2);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Laptop Netzteil', 'PC Netzteil', 'Asus', 22, 'Florian Weiss', '8604 Volketswil Schweiz', 1, 'K', 3);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('RGB Gehäuse', 'Gehäuse', 'Lenovo', 3, 'Hans Müller', '8155 Niederhasli Schweiz', 1, 'L', 15);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('RGB Gehäuse', 'Gehäuse', 'Lenovo', 5, 'Hans Müller', '8155 Niederhasli Schweiz', 2, 'O', 16);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('RGB Gehäuse', 'Gehäuse', 'Lenovo', 2, 'Hans Müller', '8155 Niederhasli Schweiz', 2, 'A', 2);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('RGB Gehäuse', 'Gehäuse', 'Lenovo', 15, 'Peter SChmitt', '8604 Volketswil Schweiz', 1, 'D', 15);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Iphone Ladekabel', 'Ladekabel', 'Apple', 32, 'Colin Anderau', '8155 Niederhasli Schweiz', 3, 'C', 2);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Iphone Ladekabel', 'Ladekabel', 'Apple', 62, 'Colin Anderau', '8155 Niederhasli Schweiz', 2, 'D', 32);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Iphone Ladekabel', 'Ladekabel', 'Apple', 150, 'Phearum Svay', '8604 Volketswil Schweiz', 1, 'A', 2);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('Samsung Ladekabel', 'Ladekabel', 'Samsung', 120, 'Phearum Svay', '8604 Volketswil Schweiz', 1, 'A', 3);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('4k Monitor', 'Monitor', 'Phillips', 3, 'Alan Parmaksiz', '8155 Niederhasli Schweiz', 2, 'C', 4);
INSERT INTO `LB03-Lagerverwaltung`.AlleProduktInformationen (name, Produktkategorie, hersteller, anzahl, Verantwortlicher, Standort, stockwerk, regal, ablage) VALUES ('8K Monitor', 'Monitor', 'Asus', 4, 'Alan Parmaksiz', '8155 Niederhasli Schweiz', 2, 'C', 5);
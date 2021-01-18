USE M153_Lagerverwaltung;

DELIMITER $$

CREATE
    TRIGGER artikel_transfer_update AFTER UPDATE
    ON tbl_artikel
    FOR EACH ROW
BEGIN
    INSERT INTO tbl_transfer
    SET id_artikel = OLD.artikel_id,
        eingang = null,
        ausgang = NOW(),
        anzahl = OLD.anzahl - NEW.anzahl;
    END$$

DELIMITER ;

DELIMITER $$

CREATE
    TRIGGER artikel_transfer_insert AFTER INSERT
    ON tbl_artikel
    FOR EACH ROW
BEGIN
    INSERT INTO tbl_transfer
    SET id_artikel = NEW.artikel_id,
        eingang = NOW(),
        ausgang = null,
        anzahl = NEW.anzahl;
    END$$

DELIMITER ;
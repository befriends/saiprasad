-- 04/09/16
ALTER TABLE `smartdairy`.`sell_entry` 
CHANGE COLUMN `sellid` `sellid` INT(11) NOT NULL AUTO_INCREMENT COMMENT '' ,
CHANGE COLUMN `code` `dairyid` BIGINT(255) NOT NULL COMMENT '' ,
CHANGE COLUMN `sell_entrycol` `code` VARCHAR(45) NULL DEFAULT NULL COMMENT '' ,
CHANGE COLUMN `shift` `shift` VARCHAR(45) NULL COMMENT '' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`sellid`)  COMMENT '';


CREATE TABLE `smartdairy`.`purchasefood` (
  `purchaseid` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `date` VARCHAR(100) NOT NULL COMMENT '',
  `companyname` VARCHAR(100) NOT NULL COMMENT '',
  `foodname` VARCHAR(100) NOT NULL COMMENT '',
  `quantity` DOUBLE NOT NULL COMMENT '',
  `purchaserate` DOUBLE NOT NULL COMMENT '',
  `sellrate` DOUBLE NOT NULL COMMENT '',
  `subtotal` DOUBLE NOT NULL COMMENT '',
  `discount` DOUBLE NOT NULL COMMENT '',
  `totalamount` DOUBLE NOT NULL COMMENT '',
  PRIMARY KEY (`purchaseid`)  COMMENT '');

CREATE TABLE `smartdairy`.`foodsell` (
  `foodsellid` INT(15) NOT NULL AUTO_INCREMENT COMMENT '',
  `customername` VARCHAR(100) NOT NULL COMMENT '',
  `foodname` VARCHAR(100) NOT NULL COMMENT '',
  `sellrate` DOUBLE NOT NULL COMMENT '',
  `date` VARCHAR(100) NOT NULL COMMENT '',
  `quantity` DOUBLE NOT NULL COMMENT '',
  `subtotal` DOUBLE NOT NULL COMMENT '',
  `discount` DOUBLE NULL COMMENT '',
  `totalamount` DOUBLE NOT NULL COMMENT '',
  `bill` DOUBLE NOT NULL COMMENT '',
  PRIMARY KEY (`foodsellid`)  COMMENT '');

ALTER TABLE `smartdairy`.`foodsell` 
CHANGE COLUMN `bill` `bill` DOUBLE NULL DEFAULT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`foodsell` 
CHANGE COLUMN `bill` `bill` BIGINT(255) NULL DEFAULT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`foodsell` 
CHANGE COLUMN `bill` `bill` VARCHAR(100) NULL DEFAULT NULL COMMENT '' ;

smarthotel


ALTER TABLE `smarthotel`.`materialstock` 
CHANGE COLUMN `quantity` `quantity` DOUBLE  NULL COMMENT '' ;

CREATE TABLE `dailymilk` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `addate` varchar(100) NOT NULL,
  `bfat` varchar(100) NOT NULL,
  `bsnf` varchar(100) NOT NULL,
  `brate` varchar(100) NOT NULL,
  `bfat2` varchar(100) NOT NULL,
  `bsnf2` varchar(100) NOT NULL,
  `brate2` varchar(100) NOT NULL,
  `dperfat` varchar(100) NOT NULL,
  `aperfat` varchar(100) NOT NULL,
  `dpersnf` varchar(100) NOT NULL,
  `apersnf` varchar(100) NOT NULL,
  `applieddate` varchar(100) NOT NULL,
  `activeflag` varchar(45) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `smartdairy`.`dailymilk` 
RENAME TO  `smartdairy`.`rategenerator` ;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `applieddate` `applieddate` VARCHAR(100) NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`purchase_entry` 
CHANGE COLUMN `fat` `fat` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `lacto` `lacto` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `snf` `snf` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `totalmilk` `totalmilk` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `rate` `rate` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `subamount` `subamount` DOUBLE NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `totalamount` `totalamount` DOUBLE NOT NULL DEFAULT '0' COMMENT '' ,
CHANGE COLUMN `date` `date` VARCHAR(100) NOT NULL COMMENT '' ,
CHANGE COLUMN `shift` `shift` VARCHAR(100) NOT NULL COMMENT '' ,
CHANGE COLUMN `type` `type` VARCHAR(100) NOT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `addate` `addate` VARCHAR(100) NOT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `id` `id` VARCHAR(255) NOT NULL COMMENT '' ,
CHANGE COLUMN `activeflag` `activeflag` INT NULL DEFAULT 1 COMMENT '' ;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `id` `rategeneratorid` VARCHAR(255) NOT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`purchase_entry` 
CHANGE COLUMN `purchaseid` `purchaseid` VARCHAR(255) NOT NULL COMMENT '' ,
CHANGE COLUMN `id` `rategeneratorid` VARCHAR(255) NOT NULL COMMENT '' , RENAME TO  `smartdairy`.`daillycollection` ;

ALTER TABLE `smartdairy`.`daillycollection` 
ADD CONSTRAINT `fk_daillycollection_1`
  FOREIGN KEY (`rategeneratorid`)
  REFERENCES `smartdairy`.`rategenerator` (`rategeneratorid`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `smartdairy`.`rategenerator` 
ADD COLUMN `isbuffalo` INT NULL COMMENT '' AFTER `activeflag`,
ADD COLUMN `iscow` INT NULL COMMENT '' AFTER `isbuffalo`;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `isbuffalo` `isbuffalo` INT(11) NOT NULL COMMENT '' ,
CHANGE COLUMN `iscow` `iscow` INT(11) NOT NULL COMMENT '' ;

ALTER TABLE `smartdairy`.`rategenerator` 
CHANGE COLUMN `bfat2` `bfat2` DOUBLE NULL COMMENT '' ,
CHANGE COLUMN `bsnf2` `bsnf2` DOUBLE NULL COMMENT '' ,
CHANGE COLUMN `brate2` `brate2` DOUBLE NULL COMMENT '' ;

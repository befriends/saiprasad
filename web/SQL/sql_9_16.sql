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


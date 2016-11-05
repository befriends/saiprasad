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


CREATE TABLE `smartdairy`.`expence` (
  `expenceid` VARCHAR(255) NOT NULL COMMENT '',
  `date` VARCHAR(255) NOT NULL COMMENT '',
  `amount` DOUBLE NULL COMMENT '',
  `personname` VARCHAR(255) NOT NULL COMMENT '',
  `reason` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`expenceid`)  COMMENT '');


15/10/2016

 CREATE TABLE `daillycollection` (
  `purchaseid` varchar(255) NOT NULL,
  `rategeneratorid` varchar(255) NOT NULL,
  `fat` double NOT NULL DEFAULT '0',
  `lacto` double NOT NULL DEFAULT '0',
  `snf` double NOT NULL DEFAULT '0',
  `totalmilk` double NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `subamount` double DEFAULT '0',
  `deduction` varchar(100) DEFAULT '0',
  `totalamount` double NOT NULL DEFAULT '0',
  `date` varchar(100) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `milkmanid` varchar(255) NOT NULL,
  `billgenerationflag` tinyint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`purchaseid`),
  KEY `fk_daillycollection_1_idx` (`rategeneratorid`),
  KEY `fk_daillycollection_2_idx` (`milkmanid`),
  CONSTRAINT `fk_daillycollection_1` FOREIGN KEY (`rategeneratorid`) REFERENCES `rategenerator` (`rategeneratorid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_daillycollection_2` FOREIGN KEY (`milkmanid`) REFERENCES `milkmandetails` (`milkmanid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;


 CREATE TABLE `dairyregistration` (
  `dairyid` varchar(255) NOT NULL,
  `dairyname` varchar(100) NOT NULL,
  `personname` varchar(100) CHARACTER SET dec8 NOT NULL,
  `alternatename` varchar(100) DEFAULT NULL,
  `mobile` bigint(20) NOT NULL,
  `alternatemobile` bigint(20) NOT NULL,
  `accountno` bigint(255) NOT NULL,
  `branchname` varchar(100) NOT NULL,
  `tankerno` varchar(100) NOT NULL,
  `amount` bigint(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `code` varchar(100) NOT NULL,
  PRIMARY KEY (`dairyid`)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

 CREATE TABLE `expense` (
  `expenseid` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `amount` double DEFAULT NULL,
  `personname` varchar(255) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `code` varchar(255) CHARACTER SET big5 NOT NULL,
  PRIMARY KEY (`expenseid`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE `foodsell` (
  `foodsellid` int(15) NOT NULL AUTO_INCREMENT,
  `customername` varchar(100) NOT NULL,
  `foodname` varchar(100) NOT NULL,
  `sellrate` double NOT NULL,
  `date` varchar(100) NOT NULL,
  `quantity` double NOT NULL,
  `subtotal` double NOT NULL,
  `discount` double DEFAULT NULL,
  `totalamount` double NOT NULL,
  `bill` varchar(100) DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  PRIMARY KEY (`foodsellid`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;



CREATE TABLE `milkmanbillmapping` (
  `idmilkmanbillmapping` varchar(255) NOT NULL,
  `billgenerateddate` bigint(255) NOT NULL,
  `milkmanid` varchar(255) NOT NULL,
  `startdate` bigint(255) DEFAULT NULL,
  `enddate` bigint(255) DEFAULT NULL,
  PRIMARY KEY (`idmilkmanbillmapping`),
  KEY `fk_milkmanbillmapping_1_idx` (`milkmanid`),
  CONSTRAINT `fk_milkmanbillmapping_1` FOREIGN KEY (`milkmanid`) REFERENCES `milkmandetails` (`milkmanid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;



CREATE TABLE `milkmandetails` (
  `milkmanid` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `dairyname` varchar(255) DEFAULT NULL,
  `mobile` bigint(255) DEFAULT NULL,
  `accnumber` varchar(255) DEFAULT NULL,
  `accbranch` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `isdeleted` tinyint(11) NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`milkmanid`)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;



CREATE TABLE `purchasefood` (
  `purchaseid` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `companyname` varchar(100) NOT NULL,
  `foodname` varchar(100) NOT NULL,
  `quantity` double NOT NULL,
  `purchaserate` double NOT NULL,
  `sellrate` double NOT NULL,
  `subtotal` double NOT NULL,
  `discount` double NOT NULL,
  `totalamount` double NOT NULL,
  `code` varchar(45) NOT NULL,
  PRIMARY KEY (`purchaseid`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE `rategenerator` (
  `rategeneratorid` varchar(255) NOT NULL,
  `addate` varchar(100) NOT NULL,
  `bfat` double NOT NULL,
  `bsnf` double NOT NULL,
  `brate` double NOT NULL,
  `bfat2` double DEFAULT NULL,
  `bsnf2` double DEFAULT NULL,
  `brate2` double DEFAULT NULL,
  `dperfat` double NOT NULL,
  `aperfat` double NOT NULL,
  `dpersnf` double NOT NULL,
  `apersnf` double NOT NULL,
  `applieddate` varchar(100) DEFAULT NULL,
  `activeflag` int(11) DEFAULT '1',
  `isbuffalo` int(11) NOT NULL,
  `iscow` int(11) NOT NULL,
  `purchase` int(11) NOT NULL,
  `sell` int(11) NOT NULL,
  PRIMARY KEY (`rategeneratorid`)
)ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;



CREATE TABLE `sellentry` (
  `sellid` varchar(255) NOT NULL,
  `drivername` varchar(45) DEFAULT NULL,
  `tankerno` varchar(45) DEFAULT NULL,
  `fat` double DEFAULT NULL,
  `lacto` double DEFAULT NULL,
  `snf` double DEFAULT NULL,
  `totalmilk` double DEFAULT NULL,
  `protein` double DEFAULT NULL,
  `temparature` double DEFAULT NULL,
  `remark` varchar(45) DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `shift` varchar(45) DEFAULT NULL,
  `dairyname` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `rategeneratorid` varchar(255) NOT NULL,
  `totalamount` double NOT NULL,
  `rate` double NOT NULL,
  `dairyid` varchar(255) NOT NULL,
  PRIMARY KEY (`sellid`),
  KEY `fk_sellentry_1_idx` (`rategeneratorid`),
  KEY `fk_sellentry_1_idx1` (`dairyid`),
  CONSTRAINT `fk_sellentry_1` FOREIGN KEY (`dairyid`) REFERENCES `dairyregistration` (`dairyid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;


CREATE TABLE `userlogin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `roleid` int(5) DEFAULT '1',
  PRIMARY KEY (`ID`)
)  ENGINE=InnoDB DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci;

16/10/2016

CREATE TABLE `smartdairy`.`Advancepayment` (
  `Advancepaymentid` VARCHAR(255) NOT NULL COMMENT '',
  `date` VARCHAR(255) NOT NULL COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  `amount` DOUBLE NULL COMMENT '',
  `contactperson` VARCHAR(255) NULL COMMENT '',
  PRIMARY KEY (`Advancepaymentid`)  COMMENT '');


CREATE DATABASE IF NOT EXISTS PatientRegistrationDB /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE PatientRegistrationDB;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: localhost    Database: PatientRegistrationDB
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-23 11:40:06


DROP TABLE IF EXISTS access;
DROP TABLE IF EXISTS medical_logs;
DROP TABLE IF EXISTS consultation;
DROP TABLE IF EXISTS lab_history;
DROP TABLE IF EXISTS lab_appointment;
DROP TABLE IF EXISTS login;

--
-- Table structure for table patient_registration
--
DROP TABLE IF EXISTS patient_registration;
CREATE TABLE `patient_registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `ssn` varchar(45) DEFAULT NULL,
  `driving_lic` varchar(45) DEFAULT NULL,
  `current_address` varchar(100) DEFAULT NULL,
  `contact_number` varchar(45) DEFAULT NULL,
  `insurance_name` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patient_id_UNIQUE` (`patient_id`)
);




--
-- Table structure for table login
--


CREATE TABLE `login` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(50) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `auth_key` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  KEY `login_patient_FK_idx` (`patient_id`),
  CONSTRAINT `login_patient_FK` FOREIGN KEY (`patient_id`) REFERENCES `patient_registration` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Table structure for table doctor
--
DROP TABLE IF EXISTS in_network_insurance;
DROP TABLE IF EXISTS hospital_doctor_availability;
DROP TABLE IF EXISTS hospital_affilation;
DROP TABLE IF EXISTS doctor;

--
-- Table structure for table specialization
--

DROP TABLE IF EXISTS specialization;
CREATE TABLE specialization (
  id int NOT NULL AUTO_INCREMENT,
  Specialization_name varchar(100),
  PRIMARY KEY (id)
  );  


--
-- Table structure for table doctor
--

CREATE TABLE `doctor` (
  `id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `Specialization_id` int DEFAULT NULL,
  `ratings` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `special_id_idx` (`Specialization_id`),
  CONSTRAINT `special_id` FOREIGN KEY (`Specialization_id`) REFERENCES `specialization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




--
-- Table structure for table hospital
--

DROP TABLE IF EXISTS hospital;
CREATE TABLE hospital (
  id int NOT NULL AUTO_INCREMENT,
  hospital_name varchar(100) DEFAULT NULL,
  city varchar(45) DEFAULT NULL,
  zipcode varchar(45) DEFAULT NULL,
  contact varchar(45) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--
-- Table structure for table hospital_affilation
--


CREATE TABLE `hospital_affilation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` int NOT NULL,
  `hospital_id` int NOT NULL,
  `npi_type` varchar(45) DEFAULT NULL,
  `npi_status` varchar(45) DEFAULT NULL,
  `npi` varchar(45) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id_idx` (`doctor_id`),
  KEY `hospital_id_idx` (`hospital_id`),
  CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `hospital_id` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



/*insert into hospital_affilation (id,doctor_id,hoapital_name,
city,zipcode,phone) values 
(01011,833590,'Dallas Medical Center','Farmer Branch',75234,'9728887000'),
(01021,285278,'First Baptist Medical Center','Dallas',75231,'4699651626'),
(01022,084713,'UT Southwest Parkland Health & Hospital','Dallas',75235,'2145908000'),
(01031,917838,'Crescemt Regional Hospital','Lancaster',75146,'4692975321'),
(01023,815109,'Baylor University Medical Center','Dallas',75246,'2148200111');*/



--
-- Table structure for table hospital_doctor_availability
--
DROP TABLE IF EXISTS `hospital_doctor_availability`;

CREATE TABLE `hospital_doctor_availability` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hospital_affliation_id` int NOT NULL,
  `appt_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_available` varchar(10) DEFAULT 'Y',
  `create_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_aff_id_idx` (`hospital_affliation_id`),
  CONSTRAINT `hospital_aff_id` FOREIGN KEY (`hospital_affliation_id`) REFERENCES `hospital_affilation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3735940 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





/*INSERT INTO PatientRegistrationDB.hospital_doctor_availability (id, doctor_id, hospital_affliation_id, day_of_week, start_time, end_time, is_available, create_date) VALUES
 (2, 84713, 1022, 'Wednesday', '09:00:00', '12:00:00', 'Y','2022-07-25'),
  (3, 285278, 1021, 'Monday', '09:00:00', '12:00:00', 'Y', NOW());*/


--
-- Table structure for table in_network_insurance
--
CREATE TABLE `in_network_insurance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `insurance_name` varchar(100) DEFAULT NULL,
  `hospital_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_id_FK_idx` (`hospital_id`),
  CONSTRAINT `hospital_id_FK` FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





DROP TABLE IF EXISTS lab_test_availability;

--
-- Table structure for table lab
--

DROP TABLE IF EXISTS lab;
CREATE TABLE lab (
  id int NOT NULL AUTO_INCREMENT,
  lab_name varchar(100),
  city varchar(100),
  zip_code int,
  PRIMARY KEY (id)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table lab_test_master
--

DROP TABLE IF EXISTS lab_test_master;
CREATE TABLE lab_test_master (
  id int NOT NULL AUTO_INCREMENT,
  test_name varchar(100),
  create_date date,
  update_date date,
  PRIMARY KEY (id)
  )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table lab_test_availability
--

CREATE TABLE lab_test_availability (
  id int NOT NULL,
  test_id int DEFAULT NULL,
  lab_id int DEFAULT NULL,
  day_of_week varchar(15) DEFAULT NULL,
  start_time time DEFAULT NULL,
  end_time time DEFAULT NULL,
  is_available varchar(13) DEFAULT NULL,
  create_date date DEFAULT NULL,
  update_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY lab_id_idx (lab_id),
  KEY test_id_idx (test_id),
  CONSTRAINT lab_id FOREIGN KEY (lab_id) REFERENCES lab (id),
  CONSTRAINT test_id FOREIGN KEY (test_id) REFERENCES lab_test_master (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Creating Table 1 - Access

CREATE TABLE access (
id int NOT NULL AUTO_INCREMENT,
patient_id varchar(45) DEFAULT NULL,
doctor_id int DEFAULT NULL,
grant_revoke varchar(10) DEFAULT 'R',
create_date date DEFAULT NULL,
update_date date DEFAULT NULL,
PRIMARY KEY (id),
KEY patient_id (patient_id),
CONSTRAINT patient_id FOREIGN KEY (patient_id) REFERENCES patient_registration (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



--

-- Creating Table 3 - Consultation

CREATE TABLE consultation (
  id int NOT NULL AUTO_INCREMENT,
  patient_id varchar(15) DEFAULT NULL,
  hosp_doctor_availability_id int DEFAULT NULL,
  start_time time DEFAULT NULL,
  end_time time DEFAULT NULL,
  appointment_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY hosp_doct_avail_id_idx (hosp_doctor_availability_id),
  KEY pat_id_idx (patient_id),
  CONSTRAINT hosp_doct_avail_id FOREIGN KEY (hosp_doctor_availability_id) REFERENCES hospital_doctor_availability (id),
  CONSTRAINT pat_id FOREIGN KEY (patient_id) REFERENCES patient_registration (patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Creating Table 4 - Lab_appointment

CREATE TABLE lab_appointment (
  id int NOT NULL AUTO_INCREMENT,
  patient_id varchar(15) DEFAULT NULL,
  test_lab_availability_id int DEFAULT NULL,
  doctor_id int DEFAULT NULL,
  start_time time DEFAULT NULL,
  end_time time DEFAULT NULL,
  appointment_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY lab_patient_id_idx (patient_id),
  KEY lab_test_avail_id_idx (test_lab_availability_id),
  CONSTRAINT lab_patient_id FOREIGN KEY (patient_id) REFERENCES patient_registration (patient_id),
  CONSTRAINT lab_test_avail_id FOREIGN KEY (test_lab_availability_id) REFERENCES lab_test_availability (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Creating Table - Medical_logs

CREATE TABLE medical_logs (
  id int NOT NULL AUTO_INCREMENT,
  consult_id int DEFAULT NULL,
  lab_visit_id int DEFAULT NULL,
  medical_history varchar(45) DEFAULT NULL,
  medication_information varchar(45) DEFAULT NULL,
  family_history varchar(45) DEFAULT NULL,
  treatment_history varchar(45) DEFAULT NULL,
  lab_results varchar(45) DEFAULT NULL,
  progress_notes varchar(45) DEFAULT NULL,
  create_date date DEFAULT NULL,
  update_date date DEFAULT NULL,
  PRIMARY KEY (id),
  KEY consult_FK_idx (consult_id),
  KEY lab_FK_idx (lab_visit_id),
  CONSTRAINT consult_FK FOREIGN KEY (consult_id) REFERENCES consultation (id),
  CONSTRAINT lab_FK FOREIGN KEY (lab_visit_id) REFERENCES lab_appointment (id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- sequences
DROP TABLE IF EXISTS sequences;
CREATE TABLE sequences (
  id int NOT NULL AUTO_INCREMENT,
  sequence_name varchar(45) DEFAULT NULL,
  currval bigint DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO sequences(sequence_name, currval) VALUES ('PATIENT_SEQ', 1000000);


DROP TABLE IF EXISTS appointment_counter;
CREATE TABLE `appointment_counter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appointment_date` date DEFAULT NULL,
  `slot1` int DEFAULT '0',
  `slot2` int DEFAULT '0',
  `slot3` int DEFAULT '0',
  `hospital_aff_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





-- Triggers

DROP TRIGGER IF EXISTS `PatientRegistrationDB`.`patient_registration_BEFORE_INSERT`;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=root@localhost TRIGGER patient_registration_BEFORE_INSERT BEFORE INSERT ON patient_registration FOR EACH ROW
BEGIN
DECLARE vPatientId varchar(100);
DECLARE vZip varchar(5);
DECLARE vState varchar(5);
DECLARE vSeq bigint(15);
UPDATE sequences 
SET 
    currval = currval + 1
WHERE
    sequence_name = 'PATIENT_SEQ';
SELECT 
    currval
INTO vSeq FROM
    sequences
WHERE
    sequence_name = 'PATIENT_SEQ';
SELECT SUBSTRING(NEW.ZIPCODE, 1, 3) INTO vZip;
SELECT SUBSTRING(NEW.STATE, 1, 3) INTO vState;
SELECT CONCAT(vState, '-', vZip, '-', vSeq) INTO vPatientId;
SET NEW.patient_id = vPatientId;
END$$
DELIMITER ;



DROP TRIGGER IF EXISTS `PatientRegistrationDB`.`patient_registration_AFTER_INSERT`;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=root@localhost TRIGGER patient_registration_AFTER_INSERT AFTER INSERT ON patient_registration FOR EACH ROW BEGIN
DECLARE pass varchar(45);
SELECT LEFT(MD5(RAND()), 8) INTO pass;
INSERT INTO login(patient_id,password) VALUES (NEW.patient_id,pass);
END$$
DELIMITER ;


--

DROP TRIGGER IF EXISTS `PatientRegistrationDB`.`hospital_affilation_AFTER_INSERT`;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER = CURRENT_USER TRIGGER `PatientRegistrationDB`.`hospital_affilation_AFTER_INSERT` AFTER INSERT ON `hospital_affilation` FOR EACH ROW
BEGIN
 call create_appointment_timetable(NEW.id, 4);
END$$
DELIMITER ;

--

DROP TRIGGER IF EXISTS `PatientRegistrationDB`.`consultation_AFTER_INSERT`;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `consultation_AFTER_INSERT` AFTER INSERT ON `consultation` FOR EACH ROW BEGIN
call update_appointment_counter(NEW.hospital_doctor_availability_id,NEW.appointment_date);
call hospital_doctor_availability(NEW.hospital_doctor_availability_id,NEW.appointment_date);
END$$
DELIMITER ;


-- PROCEDURE 1


USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `create_appointment_timetable`;

USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `PatientRegistrationDB`.`create_appointment_timetable`;
;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_appointment_timetable`(IN hospital_aff_id int, IN days int)
BEGIN
DECLARE x INT default 0;
WHILE x <= days DO
INSERT INTO hospital_doctor_availability(hospital_affliation_id, appt_date, start_time, end_time, is_available, create_date )
VALUES
(hospital_aff_id, DATE_ADD(current_date(),interval x day),'090000','115959','Y', current_date()),
(hospital_aff_id, DATE_ADD(current_date(),interval x day),'120000','145959','Y', current_date()),
(hospital_aff_id, DATE_ADD(current_date(),interval x day),'150000','175959','Y', current_date());

INSERT INTO appointment_counter(appointment_date,hospital_aff_id,slot1,slot2,slot3)
VALUES (DATE_ADD(current_date(),interval x day),hospital_aff_id,0, 0, 0);
SET x = x + 1;
END WHILE;
END$$

DELIMITER ;
;




-- PROCEDURE 2

USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `update_hospital_doctor_timetable`;

USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `PatientRegistrationDB`.`update_hospital_doctor_timetable`;
;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_hospital_doctor_timetable`(IN hospital_aff_id int, IN days int)
BEGIN
DECLARE x INT default 0;
DECLARE cur_date DATE;
IF EXISTS (SELECT max(appt_date) from hospital_doctor_availability where hospital_affliation_id = hospital_aff_id) THEN
  BEGIN
    SELECT 
    MAX(appt_date)
INTO cur_date FROM
    hospital_doctor_availability
WHERE
    hospital_affliation_id = hospital_aff_id;
    SET x = 1;
    WHILE x <= days DO
      INSERT INTO hospital_doctor_availability(hospital_affliation_id, appt_date, start_time, end_time, is_available, create_date )
      VALUES
      (hospital_aff_id, DATE_ADD(cur_date,interval x day),'090000','115959','Y', current_date()),
      (hospital_aff_id, DATE_ADD(cur_date,interval x day),'120000','145959','Y', current_date()),
      (hospital_aff_id, DATE_ADD(cur_date,interval x day),'150000','175959','Y', current_date());
            
      INSERT INTO appointment_counter(appointment_date,hospital_aff_id,slot1,slot2,slot3)
      VALUES (DATE_ADD(cur_date,interval x day),hospital_aff_id,0, 0, 0);
      SET x = x + 1;
    END WHILE;
  END;
END IF;
END$$

DELIMITER ;
;



-- PROCEDURE 3


USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `PatientRegistrationDB`.`update_appointment_counter`;
;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_appointment_counter`(IN hospital_doctor_availability_id int, IN appt_date Date)
BEGIN
DECLARE slot_1 INT default 0;
DECLARE slot_2 INT default 0;
DECLARE slot_3 INT default 0;
DECLARE start_T time;

SELECT start_time INTO start_T FROM hospital_doctor_availability WHERE id = hospital_doctor_availability_id;

  CASE 
    WHEN start_T BETWEEN '09:00:00' AND '11:59:59' THEN 
      SET slot_1 = 1;
    WHEN start_T BETWEEN '12:00:00' AND '14:59:59' THEN 
      SET slot_2 = 1;
    WHEN start_T BETWEEN '15:00:00' AND '17:59:59' THEN 
      SET slot_3 = 1;
  END CASE;
    
UPDATE appointment_counter SET slot1 = slot1 + slot_1 , slot2 = slot2 + slot_2, slot3 = slot3 + slot_3
WHERE appointment_date = appt_date and hospital_aff_id = (SELECT hospital_affliation_id from hospital_doctor_availability WHERE id = hospital_doctor_availability_id);

END$$

DELIMITER ;
;


-- PROCEDURE 4

USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `hospital_doctor_availability`;

USE `PatientRegistrationDB`;
DROP procedure IF EXISTS `PatientRegistrationDB`.`hospital_doctor_availability`;
;

DELIMITER $$
USE `PatientRegistrationDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `hospital_doctor_availability`(IN hospital_doctor_availability_id int, IN appt_date Date)
BEGIN
DECLARE hospital_aff_id INT;
DECLARE slot_1 INT default 0;
DECLARE slot_2 INT default 0;
DECLARE slot_3 INT default 0;

SELECT hospital_affliation_id INTO hospital_aff_id FROM hospital_doctor_availability 
WHERE id = hospital_doctor_availability_id;

SELECT slot1,slot2,slot3 
INTO slot_1,slot_2,slot_3 
FROM appointment_counter 
WHERE appointment_date = appt_date AND hospital_aff_id = hospital_aff_id;

  CASE 
    WHEN slot_1 = 6 THEN
      UPDATE hospital_doctor_availability SET is_available = 'N'
            WHERE appt_date = appt_date and hospital_affliation_id = hospital_aff_id and start_time = '09:00:00';
    WHEN slot_2 = 6 THEN
      UPDATE hospital_doctor_availability SET is_available = 'N'
            WHERE appt_date = appt_date and hospital_affliation_id = hospital_aff_id and start_time = '12:00:00';
    WHEN slot_3 = 6 THEN
      UPDATE hospital_doctor_availability SET is_available = 'N'
            WHERE appt_date = appt_date and hospital_affliation_id = hospital_aff_id and start_time = '15:00:00';
    ELSE
        BEGIN 
           -- simply put this BEGIN and END for the "do nothing" on ELSE
        END;
  END CASE;
    
END$$

DELIMITER ;
;


-- Insert Queries

/*INSERT INTO PatientRegistrationDB.patient_registration (patient_id, first_name, last_name, ssn, driving_lic, current_address, contact_number, insurance_name, state, zipcode) 
VALUES ('','WILL', 'SMITH', '346465253', 'FD345643', '1000 , 14th Street , Chicago', '1234567890', 'First Care', 'Illinois', '60601'),
 ('','MARK', 'WOOD', '346445253', 'AB365643', '800 , Buffelo Street , Chicago', '1234567890', 'Blue Cross', 'Illinois', '60645'),
('','STIVE', 'SMITH', '246465253', 'CD345643', '1000 , Hill Street , St.Louis', '1234567890', 'Blue Cross', 'Missouri', '20601'),
('','ASHELEY', 'GREEN', '246464253', '78345643', '1000 , 7th Street , Denver', '1234567890', 'Cigna', 'Colorado', '21601'),
('','KUMAR', 'SWAMI', '246435251', 'HT345643', '1000 , 7th Street , Denver', '1234567890', 'Cigna', 'Colorado', '21601'),
('','JOHN', 'SENA', '123456789', 'FD345643', '1200 , Park Street , Austin', '1234567890', 'AETNA', 'Texas', '75023');*/

INSERT INTO `patient_registration` VALUES (1,'','Maggie',NULL,'Appleby','153205409','BXC153205','345 Main Street, Salem','5033635432','AETNA','LA','70116');
INSERT INTO `patient_registration` VALUES (2,'','Anna',NULL,'Allowed ','215706154','GPC215706','123 Main Street SE','2536879854','Cigna','MI','48116');
INSERT INTO `patient_registration` VALUES (3,'','Candi',NULL,'Copay','666860442','CAC666860','PO BOX 12345','2456983265','First Core','NJ','58014');
INSERT INTO `patient_registration` VALUES (4,'','Clarissa',NULL,'Lowe',NULL,'CLL586954','251 W 10th St','2345678989','Blue Cross','AK','99501');
INSERT INTO `patient_registration` VALUES (5,'','Jordan',NULL,'Lowe ','417822186','JOL417822','163 Madosion loop','2345689898','Cigna','OH','45011');
INSERT INTO `patient_registration` VALUES (6,'','Roger',NULL,'Appleby',NULL,'ROA401578','266 Jamaica Street','2345678978','First Core','OH','44805');
INSERT INTO `patient_registration` VALUES (7,'','James',NULL,'Sayers','377930595','JAS377930','6649 N Blue Gum St','4567891235','Blue Cross','IL','60632');
INSERT INTO `patient_registration` VALUES (8,'','Dad',NULL,'Test','711619667','DAT711619','4 B Blue Ridge Blvd','9940157867','Cigna','CA','95111');
INSERT INTO `patient_registration` VALUES (9,'','Fred',NULL,'Tuttle','519008436','FRT519008','8 W Cerritos Ave #54','9246297885','Cigna','SD','57105');
INSERT INTO `patient_registration` VALUES (10,'','Amber',NULL,'Cat ','373425778','AMC373425','639 Main St','9849895483','First Core','MD','21224');
INSERT INTO `patient_registration` VALUES (11,'','Doug',NULL,'Benson',NULL,'DOB895478','34 Center St','7330953462','Blue Cross','PA','19443');
INSERT INTO `patient_registration` VALUES (12,'','Chris',NULL,'Benson','459612303','CHB459612','3 Mcauley Dr','9010535542','AETNA','NY','11953');
INSERT INTO `patient_registration` VALUES (13,'','Fred',NULL,'Baggins','800294985','FRB800294','7 Eads St','5846921014','First Core','CA','90034');
INSERT INTO `patient_registration` VALUES (14,'','Bred',NULL,'Anders ','776685539','BRA776685','7 W Jackson Blvd','4696891698','Cigna','OH','44023');
INSERT INTO `patient_registration` VALUES (15,'','Nancy',NULL,'Barker','988341297','NAB988341','5 Boston Ave #88','4698187935','Blue Cross','TX','78045');
INSERT INTO `patient_registration` VALUES (16,'','Doug',NULL,'Adams','580550617','DOA580550','228 Runamuck Pl #2808','4697406985','AETNA','AZ','85013');
INSERT INTO `patient_registration` VALUES (17,'','Joe',NULL,'Smith','733095344','JOS733095','2371 Jerrold Ave','9452161425','First Core','TN','37110');
INSERT INTO `patient_registration` VALUES (18,'','Benjamin',NULL,'Eno',NULL,'BEE586349','37275 St  Rt 17m M','3474044795','Cigna','WI','53207');
INSERT INTO `patient_registration` VALUES (19,'','Victor',NULL,'Bolden','627701119','VIB627701','25 E 75th St #69','9452412598','Cigna','MI','48180');
INSERT INTO `patient_registration` VALUES (20,'','Kelvin',NULL,'Beachu','918429073','KEB918429','98 Connecticut Ave Nw','2174021386','First Core','IL','61109');
INSERT INTO `patient_registration` VALUES (21,'','Achi',NULL,'Ghassan','708395096','ACG708395','56 E Morehead St','7245785426','AETNA','PA','19014');
INSERT INTO `patient_registration` VALUES (22,'','Perry',NULL,'Chris','849895493','PEC849895','73 State Road 434 E','7245785236','Cigna','CA','95111');
INSERT INTO `patient_registration` VALUES (23,'','Smith',NULL,'Avery ','599278828','SMA599278','69734 E Carrillo St','9452176589','Cigna','TX','75062');
INSERT INTO `patient_registration` VALUES (24,'','Chadler',NULL,'Brett','246297875','CHB246297','322 New Horizon Blvd','4343869854','First Core','NY','12204');
INSERT INTO `patient_registration` VALUES (25,'','Smith',NULL,'Haley','452082650','SMH452082','1 State Route 27','9453565289','Cigna','NJ','98846');
INSERT INTO `patient_registration` VALUES (26,'','Britt',NULL,'Emma',NULL,'BRE264893','394 Manchester Blvd','5127230258','AETNA','WI','54481');
INSERT INTO `patient_registration` VALUES (27,'','King',NULL,'Jessica','153205409','KIJ153205','6 S 33rd St','9293947684','Cigna','KS','66218');
INSERT INTO `patient_registration` VALUES (28,'','Kringle',NULL,'Kriss','855505084','KRK855505','6 Greenleaf Ave','9452179583','','MD','21601');
INSERT INTO `patient_registration` VALUES (29,'','Sister',NULL,'Pam','230803837','SIP230803','618 W Yakima Ave','8006249856','Blue Cross','NY','10011');

/*INSERT INTO specialization (Specialization_name) VALUES 
('Allergy and immunology'),
('Anesthesiology'),
('Dermatology'),
('Diagnostic radiology'),
('Prostatitis'),
('Emergency medicine'),
('Family medicine'),
('Internal medicine'),
('Medical genetics'),
('Neurology'),
('Nuclear medicine'),
('Obstetrics and gynecology'),
('Ophthalmology'),
('Pathology'),
('Pediatrics'),
('Physical medicine and rehabilitation'),
('Preventive medicine'),
('Psychiatry'),
('Radiation oncology'),
('Surgery'),
('Urology');*/

INSERT INTO `specialization` VALUES (1101,'Allergy and immunology');
INSERT INTO `specialization` VALUES (1102,'Anesthesiology');
INSERT INTO `specialization` VALUES (1103,'Dermatology');
INSERT INTO `specialization` VALUES (1104,'Diagnostic radiology');
INSERT INTO `specialization` VALUES (1105,'Prostatitis');
INSERT INTO `specialization` VALUES (1106,'Emergency medicine');
INSERT INTO `specialization` VALUES (1107,'Family medicine');
INSERT INTO `specialization` VALUES (1108,'Internal medicine');
INSERT INTO `specialization` VALUES (1109,'Medical genetics');
INSERT INTO `specialization` VALUES (1110,'Neurology');
INSERT INTO `specialization` VALUES (1111,'Nuclear medicine');
INSERT INTO `specialization` VALUES (1112,'Obstetrics and gynecology');
INSERT INTO `specialization` VALUES (1113,'Ophthalmology');
INSERT INTO `specialization` VALUES (1114,'Pathology');
INSERT INTO `specialization` VALUES (1115,'Pediatrics');
INSERT INTO `specialization` VALUES (1116,'Physical medicine and rehabilitation');
INSERT INTO `specialization` VALUES (1117,'Preventive medicine');
INSERT INTO `specialization` VALUES (1118,'Psychiatry');
INSERT INTO `specialization` VALUES (1119,'Radiation oncology');
INSERT INTO `specialization` VALUES (1120,'General Surgery');

/*INSERT INTO hospital (hospital_name,city,zipcode,contact) VALUES 
('Dallas Medical Center','Farmer Branch',75234,'9728887000'),
('First Baptist Medical Center','Dallas',75231,'4699651626'),
('UT Southwest Parkland Health & Hospital','Dallas',75235,'2145908000'),
('Crescemt Regional Hospital','Lancaster',75146,'4692975321'),
('Baylor University Medical Center','Dallas',75246,'2148200111');*/

INSERT INTO `hospital` VALUES (570,'Abraham Lincoln Hospital','Lincoln','62656','7089156101');
INSERT INTO `hospital` VALUES (571,'Adventist Bolingbrook Hospital','Bolingbrook','60440','8154327967');
INSERT INTO `hospital` VALUES (572,'David Samuel Rusen Clinic','Paramount','61008','9200362125');
INSERT INTO `hospital` VALUES (573,'Adventist GlenOaks Hospital','Glendale Heights','60139','7739477581');
INSERT INTO `hospital` VALUES (574,'Adventist Hinsdale Hospital','Hinsdale','60521','6184988300');
INSERT INTO `hospital` VALUES (575,'Adventist La Grange Memorial Hospital','La Grange','60525','312 8647198');
INSERT INTO `hospital` VALUES (576,'Advocate BroMenn Medical Center','Normal','61761','8152855501');
INSERT INTO `hospital` VALUES (577,'Ryan A Stanton Clinic','Granada Hills','62568','9402541433');
INSERT INTO `hospital` VALUES (578,'Advocate Christ Medical Center','Oak lawn','60453','7734815709');
INSERT INTO `hospital` VALUES (579,'Advocate Condell Medical Center','Libertyville','60048','7732792684');
INSERT INTO `hospital` VALUES (580,'Advocate Eureka Hospital','Eureka','60035','7083458100');
INSERT INTO `hospital` VALUES (581,'Elyn V Bowers Clinic','Menlo Park','60613','9012111661');
INSERT INTO `hospital` VALUES (582,'Advocate Good Samaritan Hospital','Downers Grove','60515','8158952144');
INSERT INTO `hospital` VALUES (583,'Advocate Good Shepherd Hospital','Barrington','60010','3096801501');
INSERT INTO `hospital` VALUES (584,'Advocate Illinois Masonic Medical Center','Chicago','60657','2177622115');
INSERT INTO `hospital` VALUES (585,'Inglewood Family Medical Clinic Corp','El Dorado Hills','61201','9576291348');
INSERT INTO `hospital` VALUES (586,'Advocate Lutheran General Hospital','Park Ridge','60068','7733636700');
INSERT INTO `hospital` VALUES (587,'Advocate Sherman Hospital','Elgin','60123','6189437200');
INSERT INTO `hospital` VALUES (588,'Advocate South Suburban Hospital','Hazel Crest','60429','2175851180');
INSERT INTO `hospital` VALUES (589,'David Ross Field Clinic','Inglewood','62906','9600221321');
INSERT INTO `hospital` VALUES (590,'University Of Chicago Medical Center','Anna','62906','7737028908');
INSERT INTO `hospital` VALUES (591,'University of Illinois Hospital at Chicago','Moline','61265','3124139446');
INSERT INTO `hospital` VALUES (592,'Leslie J Andrews Clinic','Redding','62207','9031032810');
INSERT INTO `hospital` VALUES (593,'Van Matre Rehabilitation Hospital','Rock Island','61201','8153818548');
INSERT INTO `hospital` VALUES (594,'VHS West Suburban Medical Center','Chicago','60637','7087632254');


INSERT INTO `doctor` VALUES (201,'James','Butt','5046218927',1101,'5');
INSERT INTO `doctor` VALUES (202,'Josephine','Darakjy','8102929388',1102,'4');
INSERT INTO `doctor` VALUES (203,'Art','Venere','8566368749',1103,'5');
INSERT INTO `doctor` VALUES (204,'Lenna','Paprocki','9073854412',1104,'5');
INSERT INTO `doctor` VALUES (205,'Donette','Foller','5135701893',1105,'5');
INSERT INTO `doctor` VALUES (206,'Simona','Morasca','4195032484',1106,'4');
INSERT INTO `doctor` VALUES (207,'Mitsue','Tollner','7735736914',1107,'4');
INSERT INTO `doctor` VALUES (208,'Leota','Dilliard','4087523500',1105,'3');
INSERT INTO `doctor` VALUES (209,'Sage','Wieser','6054142147',1109,'4');
INSERT INTO `doctor` VALUES (210,'Kris','Marrier','4106558723',1110,'5');
INSERT INTO `doctor` VALUES (211,'Minna','Amigon','2158741229',1111,'4');
INSERT INTO `doctor` VALUES (212,'Abel','Maclead','6313353414',1112,'4');
INSERT INTO `doctor` VALUES (213,'Kiley','Caldarera','3104985651',1101,'4');
INSERT INTO `doctor` VALUES (214,'Graciela','Ruta','4407808425',1118,'5');
INSERT INTO `doctor` VALUES (215,'Cammy','Albares','9565376195',1115,'5');
INSERT INTO `doctor` VALUES (216,'Mattie','Poquette','6022774385',1110,'3');
INSERT INTO `doctor` VALUES (217,'Meaghan','Garufi','9313139635',1102,'3');
INSERT INTO `doctor` VALUES (218,'Gladys','Rim','4146619598',1118,'5');
INSERT INTO `doctor` VALUES (219,'Yuki','Whobrey','3132887937',1110,'5');

INSERT INTO `hospital_affilation` VALUES (401,201,570,'Organization','Active','1002556777',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (402,202,571,'Organization','Active','1007688763',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (403,203,572,'Individual','Active','1107788633',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (404,204,573,'Organization','Active','1002263738',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (405,205,574,'Organization','Active','1003734457',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (406,206,575,'Organization','Active','1004736278',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (407,207,576,'Organization','Active','1003892356',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (408,208,577,'Individual','Active','1104322287',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (409,209,578,'Organization','Active','1009993264',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (410,210,579,'Organization','Active','1007477793',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (411,211,580,'Organization','Active','1000837456',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (412,212,581,'Individual','Active','1103227846',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (413,213,582,'Organization','Active','1004374883',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (414,214,583,'Organization','Active','1003732322',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (415,215,584,'Organization','Active','1009992235',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (416,216,585,'Organization','Active','1001100176',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (417,217,586,'Organization','Active','1002992992',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (418,218,587,'Organization','Active','1003687322',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (419,219,588,'Organization','Active','1003763762',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (420,203,584,'Organization','Active','1003333627',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (421,206,585,'Organization','Active','1002722332',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (422,208,586,'Organization','Active','1003888832',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (423,212,587,'Organization','Active','1003778778',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (424,216,588,'Organization','Active','1002888827',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (425,202,575,'Organization','Active','1003776762',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (426,216,570,'Organization','Active','1002227777',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (427,211,571,'Organization','Active','1003611110',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (428,215,572,'Individual','Active','1107899117',NULL,NULL);
INSERT INTO `hospital_affilation` VALUES (429,201,573,'Organization','Active','1003788811',NULL,NULL);

INSERT INTO `in_network_insurance` VALUES (1,'AETNA',570);
INSERT INTO `in_network_insurance` VALUES (7,'Blue Cross',571);
INSERT INTO `in_network_insurance` VALUES (8,'Cigna',572);
INSERT INTO `in_network_insurance` VALUES (9,'First Care',573);
INSERT INTO `in_network_insurance` VALUES (10,'First Care',574);
INSERT INTO `in_network_insurance` VALUES (11,'AETNA',575);
INSERT INTO `in_network_insurance` VALUES (12,'AETNA',576);
INSERT INTO `in_network_insurance` VALUES (13,'AETNA',577);
INSERT INTO `in_network_insurance` VALUES (14,'Blue Cross',578);
INSERT INTO `in_network_insurance` VALUES (15,'AETNA',579);
INSERT INTO `in_network_insurance` VALUES (16,'AETNA',580);
INSERT INTO `in_network_insurance` VALUES (17,'Cigna',581);
INSERT INTO `in_network_insurance` VALUES (18,'Cigna',582);
INSERT INTO `in_network_insurance` VALUES (19,'Cigna',583);
INSERT INTO `in_network_insurance` VALUES (20,'First Care',584);
INSERT INTO `in_network_insurance` VALUES (21,'Cigna',585);
INSERT INTO `in_network_insurance` VALUES (22,'AETNA',586);
INSERT INTO `in_network_insurance` VALUES (23,'First Care',587);
INSERT INTO `in_network_insurance` VALUES (24,'Blue Cross',588);
INSERT INTO `in_network_insurance` VALUES (25,'Blue Cross',589);
INSERT INTO `in_network_insurance` VALUES (26,'Cigna',590);
INSERT INTO `in_network_insurance` VALUES (27,'Cigna',591);
INSERT INTO `in_network_insurance` VALUES (28,'AETNA',592);
INSERT INTO `in_network_insurance` VALUES (29,'First Care',593);
INSERT INTO `in_network_insurance` VALUES (30,'AETNA',594);

/*INSERT INTO in_network_insurance(insurance_name,hospital_id) VALUES
('AETNA', 6),
('Blue Cross', 7),
('Cigna',6),
('Cigna',10),
('First Care',8),
('AETNA', 9);*/


INSERT INTO `lab` VALUES (11,'My labs Direct','Lincoln',62656);
INSERT INTO `lab` VALUES (12,'Any Lab Test Now','Bolingbrook',60440);
INSERT INTO `lab` VALUES (13,'Labcorp','Glendale Heights',60139);
INSERT INTO `lab` VALUES (14,'Harmone Labs','Hinsdale',60521);
INSERT INTO `lab` VALUES (15,'Aria Diagnostics','La Grange',60525);
INSERT INTO `lab` VALUES (16,'Quest Diagnostics','Normal',61761);
INSERT INTO `lab` VALUES (17,'Centra Laboratory Services','Oak lawn',60453);
INSERT INTO `lab` VALUES (18,'KindredDiagnostics','Libertyville',60048);
INSERT INTO `lab` VALUES (19,'  Masonic Medlab','Eureka',60035);
INSERT INTO `lab` VALUES (20,'LaRabida Labs','Downers Grove',60515);
INSERT INTO `lab` VALUES (21,'Carle Foundation Labs','Barrington',60010);
INSERT INTO `lab` VALUES (22,'Genesis Diagnostics','Chicago',60657);
INSERT INTO `lab` VALUES (23,'Linden Oaks Labs','Park Ridge',60068);
INSERT INTO `lab` VALUES (24,' Lutheran GeneralLabs','Elgin',60123);
INSERT INTO `lab` VALUES (25,'Loretto Diagnostics','Hazel Crest',60429);
INSERT INTO `lab` VALUES (26,' Sherman Testing centre','Anna',62906);
INSERT INTO `lab` VALUES (27,'Loyola Testing centre','Moline',61265);
INSERT INTO `lab` VALUES (28,'MacNeal Diagnostics','Rock Island',61201);
INSERT INTO `lab` VALUES (29,'Advocate Good Shepherd Diagnostics','Chicago',60637);
INSERT INTO `lab` VALUES (30,'','',0);
INSERT INTO `lab` VALUES (31,'','',0);
INSERT INTO `lab` VALUES (32,'','',0);
INSERT INTO `lab` VALUES (33,'','',0);
INSERT INTO `lab` VALUES (34,'','',0);



INSERT INTO `lab_test_master` VALUES (1,'Blood grouping',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (2,'D3 Total',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (3,'Covid 19 Antibody IGG',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (4,'Complete Blood count',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (5,'Hemoglobin',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (6,'Red cell count',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (7,'Total Leucocyte',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (8,'Liver function test',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (9,'Lipid profile',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (10,'HCV ELFA',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (11,'Serum Creatinine',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (12,'Ultra Sound',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (13,'Thyroid profile',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (14,'Vitamin B12',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (15,'Fasting Blood sugar',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (16,'Total cholesterol /HDL',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (17,'Bilurubin total blood',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (18,'CT scan',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (19,'MRI scan',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (20,'X ray',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (21,'Kidney function test',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (22,'Dengue NS1 Antigen',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (23,'Hepatitis Bs Antigen',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (24,'Calcium',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (25,'Urine routine test',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (26,'CT angiography chest',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (27,'Pulmonary function test',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (28,'Blood urea nitrogen',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (29,'Potassium',NULL,NULL);
INSERT INTO `lab_test_master` VALUES (30,'Tuberculosis DNA PCR',NULL,NULL);


INSERT INTO `lab_test_availability` VALUES (1,1,11,'Wednesday','10:00:30','11:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (2,2,21,'Tuesday','14:00:00','15:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (3,3,12,'Monday','12:00:00','13:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (4,4,29,'Thursday','09:30:00','10:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (5,5,13,'Friday','15:00:00','15:30:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (6,6,23,'Tuesday','10:00:30','11:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (7,7,14,'Friday','12:00:00','13:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (8,8,15,'Thursday','16:00:00','16:30:00','N',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (9,9,20,'Tuesday','10:30:00','11:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (10,10,19,'Wednesday','11:30:00','12:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (11,11,16,'Monday','15:00:00','15:30:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (12,12,26,'Wednesday','09:30:00','10:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (13,13,17,'Monday','12:00:00','13:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (14,14,27,'Wednesday','10:30:00','11:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (15,15,28,'Friday','10:00:30','11:00:00','N',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (16,16,18,'Thursday','11:30:00','12:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (17,17,19,'Monday','14:00:00','15:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (18,18,22,'Tuesday','09:30:00','10:00:00','Y',NULL,NULL);
INSERT INTO `lab_test_availability` VALUES (19,19,24,'Wednesday','10:00:30','11:00:00','Y',NULL,NULL);


###############################some queries############################
####query1:find doctor and specialization information--choose right doctor and get contact information############
show databases;
use patientregistrationdb;
show tables;
SELECT doctor.id, doctor.first_name,doctor.last_name,phone_number,specialization_id,specialization_name
FROM doctor
INNER JOIN specialization
ON doctor.specialization_id = specialization.id
where specialization_name = 'joint effusion';

SELECT doctor.id, doctor.first_name,doctor.last_name,phone_number,specialization_id,specialization_name,hospital_id,hospital.hospital_name,contact
FROM doctor
INNER JOIN specialization
ON doctor.specialization_id = specialization.id
inner join hospital_affilation
on hospital_affilation.doctor_id=doctor.id
inner join hospital
on hospital.id=hospital_affilation.hospital_id;

########check the schedule and make appointments#############
####query2:find the doctors who are available########
SELECT  doctor.id, doctor.first_name,doctor.last_name,phone_number
FROM doctor
WHERE doctor.id IN 
(SELECT doctor_id FROM hospital_affilation
WHERE hospital_affilation.id IN 
(SELECT hospital_affliation_id FROM hospital_doctor_availability 
WHERE hospital_doctor_availability.is_available = 'TRUE'));

####query3:find the labs which are available########
SELECT lab_test_availability.id,lab_test_availability.test_id,lab_test_availability.lab_id,lab_name,day_of_week,start_time,end_time, city,zip_code 
FROM  lab_test_availability
LEFT JOIN lab ON lab_test_availability.lab_id = lab.id
WHERE  is_available = 'TRUE'
Order BY lab_id;

######query4:find patient medcial information-for doctors reference##########
###for lab doctor
SELECT patient_registration.patient_id,patient_name, medication_information,medical_history,family_history,treatment_history
current_address, contact_number,appointment_date 
FROM patient_registration,lab_appointment,medical_logs where patient_registration.patient_id=lab_appointment.patient_id
and lab_visit_id = lab_appointment.id;

##for consultation doctor---（similarto_the above query) 

########query5:find insurance information-#########
SELECT hospital.id as hospital_id,hospital_name,in_network_insurance.id as insurance_id,insurance_name FROM hospital right join 
 in_network_insurance on hospital.id=in_network_insurance.hospital_id;
 
 ######stored function##########
 Set global
log_bin_trust_function_creators = 1;
#A function that returns the patient ID that matches a patient’s name DELIMITER //#
DELIMITER //
CREATE FUNCTION get_patient_id(patient_name_param VARCHAR(50))
RETURNS int
BEGIN
	DECLARE patient_id_var INT;
	SELECT patient_id INTO patient_id_var FROM patient_registration
	WHERE patient_name = patient_name_param; 
	RETURN(patient_id_var);
END //

#A SELECT statement that uses the function -find the patient's appointment details#
SELECT start_time,end_time, appointment_date FROM appointment
WHERE patient_id = get_patient_id('John. M .Smith')


#A function that calculates lab test availability#
DELIMITER //
CREATE FUNCTION get_lab_availability
(
 lab_id_param INT
)
RETURNS DECIMAL(9,2)
BEGIN
 DECLARE lab_availability_var time;
 SELECT end_time - start_time
 INTO lab_availability_var
 FROM lab_test_availability
 WHERE lab_id = lab_id_param;
 RETURN lab_availability_var;
END//

#A statement that calls the function-find the lab test availbability#
SELECT id, lab_name, get_lab_availability(id) AS lab_availability
FROM lab
WHERE id = 3;

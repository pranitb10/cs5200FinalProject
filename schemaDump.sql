CREATE DATABASE  IF NOT EXISTS `airbnb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `airbnb`;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: airbnb
-- ------------------------------------------------------
-- Server version	8.0.32

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

--
-- Table structure for table `airbnb_unavailable`
--

DROP TABLE IF EXISTS `airbnb_unavailable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airbnb_unavailable` (
  `house_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`house_id`,`start_date`,`end_date`),
  CONSTRAINT `airbnb_unavailable_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `airbnbs` (`house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airbnb_unavailable`
--

LOCK TABLES `airbnb_unavailable` WRITE;
/*!40000 ALTER TABLE `airbnb_unavailable` DISABLE KEYS */;
INSERT INTO `airbnb_unavailable` VALUES (1001,'2023-06-01','2023-06-07'),(1001,'2023-08-15','2023-08-20'),(1003,'2023-05-12','2023-05-18'),(1004,'2023-07-21','2023-07-24'),(1004,'2023-09-12','2023-09-15'),(1005,'2023-04-08','2023-04-10'),(1005,'2023-10-02','2023-10-08'),(1005,'2023-11-20','2023-11-25'),(1006,'2023-12-18','2023-12-24'),(1010,'2023-08-01','2023-08-06');
/*!40000 ALTER TABLE `airbnb_unavailable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airbnbs`
--

DROP TABLE IF EXISTS `airbnbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airbnbs` (
  `house_id` int NOT NULL,
  `host_id` int DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `city_id` int DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `num_of_rooms` int DEFAULT NULL,
  `num_of_beds` int DEFAULT NULL,
  `num_parking` int DEFAULT NULL,
  `average_rating` decimal(3,2) DEFAULT NULL,
  `rating_times` int DEFAULT '0',
  `description` varchar(10000) DEFAULT NULL,
  `current_price` decimal(10,2) DEFAULT NULL,
  `current_cleaning_fee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`house_id`),
  KEY `host_id` (`host_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `airbnbs_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `hosts` (`id`),
  CONSTRAINT `airbnbs_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `world_cities` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airbnbs`
--

LOCK TABLES `airbnbs` WRITE;
/*!40000 ALTER TABLE `airbnbs` DISABLE KEYS */;
INSERT INTO `airbnbs` VALUES (1001,1001,'Cozy Apartment in the Heart of the City',1276974738,'123 Main St.',2,1,1,2.20,10,'This charming apartment is located in the heart of the city and is perfect for a romantic getaway or a small family vacation.',80.00,10.00),(1002,1002,'Spacious Loft with Stunning City Views',1076094869,'456 Elm St.',1,2,0,1.60,5,'Experience urban living at its finest in this spacious loft with breathtaking city views.',120.00,15.00),(1003,1003,'Luxury Condo with Pool and Gym Access',1752708772,'789 Oak St.',3,3,2,3.00,15,'Treat yourself to the ultimate luxury experience in this beautiful condo with access to a pool and gym.',250.00,20.00),(1004,1004,'Coastal Cottage with Ocean Views',1218680506,'321 Beach Rd.',2,2,1,4.70,8,'Escape to the coast and enjoy breathtaking ocean views from this charming cottage.',150.00,15.00),(1005,1005,'Historic Home with Modern Amenities',1356213628,'987 Main St.',4,3,2,4.30,12,'Experience the best of both worlds in this beautifully restored historic home with all the modern amenities you need for a comfortable stay.',200.00,20.00),(1006,1006,'Charming Bungalow in a Quiet Neighborhood',1250008059,'567 Maple St.',2,1,1,5.00,6,'This charming bungalow is the perfect place to relax and unwind in a quiet neighborhood.',100.00,10.00),(1007,1007,'Stylish Studio Apartment in Downtown',1380805860,'246 Market St.',1,1,0,3.50,7,'Experience city living in style in this modern and chic studio apartment located in the heart of downtown.',90.00,10.00),(1008,1008,'Spacious Townhouse with Private Patio',1840010109,'789 Oak St.',3,3,1,3.20,10,'This spacious townhouse with a private patio is the perfect home away from home for your next family vacation.',180.00,20.00),(1009,1009,'Modern Apartment with Stunning Views',1036216956,'357 Hilltop Rd.',1,2,1,4.70,4,'Enjoy breathtaking views from this modern and stylish apartment located on a hilltop.',120.00,15.00),(1010,1010,'Beautifully Furnished Apartment in the City',1840019682,'123 Main St.',2,2,1,3.80,9,'This beautifully furnished apartment is located in the heart of the city and is perfect for a comfortable and convenient stay.',80.00,15.00);
/*!40000 ALTER TABLE `airbnbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `id` int NOT NULL,
  `host_name` varchar(150) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Others','Not to tell') DEFAULT 'Not to tell',
  `language_code` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `hosts_ibfk_1` FOREIGN KEY (`language_code`) REFERENCES `languages` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (1001,'John Smith','john.smith@gmail.com','555-555-1234','Male','en'),(1002,'Mary Johnson','mary.johnson@yahoo.com','555-555-5678','Female','en'),(1003,'David Lee','david.lee@hotmail.com',NULL,'Male','ko'),(1004,'Anna Garcia','anna.garcia@gmail.com','555-555-2345','Female','es'),(1005,'Mohammed Ahmed','mohammed.ahmed@yahoo.com','555-555-6789','Male','ar'),(1006,'Lena Nguyen','lena.nguyen@gmail.com',NULL,'Female','vi'),(1007,'Javier Hernandez','javier.hernandez@yahoo.com','555-555-3456','Male','es'),(1008,'Sara Kim','sara.kim@hotmail.com','555-555-7890','Female','ko'),(1009,'Ahmed Hassan','ahmed.hassan@gmail.com','555-555-4567','Male','ar'),(1010,'Jasmine Wong','jasmine.wong@yahoo.com','555-555-8901','Female','zh');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `name` varchar(50) NOT NULL,
  `code` char(2) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES ('Afrikaans','AF'),('Arabic','AR'),('Bulgarian','BG'),('Bengali','BN'),('Tibetan','BO'),('Catalan','CA'),('Czech','CS'),('Welsh','CY'),('Danish','DA'),('German','DE'),('Greek','EL'),('English','EN'),('Spanish','ES'),('Estonian','ET'),('Basque','EU'),('Persian','FA'),('Finnish','FI'),('Fiji','FJ'),('French','FR'),('Irish','GA'),('Gujarati','GU'),('Hebrew','HE'),('Hindi','HI'),('Croatian','HR'),('Hungarian','HU'),('Armenian','HY'),('Indonesian','ID'),('Icelandic','IS'),('Italian','IT'),('Japanese','JA'),('Javanese','JW'),('Georgian','KA'),('Cambodian','KM'),('Korean','KO'),('Latin','LA'),('Lithuanian','LT'),('Latvian','LV'),('Maori','MI'),('Macedonian','MK'),('Malayalam','ML'),('Mongolian','MN'),('Marathi','MR'),('Malay','MS'),('Maltese','MT'),('Nepali','NE'),('Dutch','NL'),('Norwegian','NO'),('Punjabi','PA'),('Polish','PL'),('Portuguese','PT'),('Quechua','QU'),('Romanian','RO'),('Russian','RU'),('Slovak','SK'),('Slovenian','SL'),('Samoan','SM'),('Albanian','SQ'),('Serbian','SR'),('Swedish','SV'),('Swahili','SW'),('Tamil','TA'),('Telugu','TE'),('Thai','TH'),('Tonga','TO'),('Turkish','TR'),('Tatar','TT'),('Ukrainian','UK'),('Urdu','UR'),('Uzbek','UZ'),('Vietnamese','VI'),('Xhosa','XH'),('Chinese (Mandarin)','ZH');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_num` varchar(10) NOT NULL,
  `tenant` int NOT NULL,
  `house_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `price_per_day` decimal(10,2) DEFAULT NULL,
  `cleaning_fee` decimal(10,2) DEFAULT NULL,
  `states` enum('wait to comfired','cencaled','processing','completed') DEFAULT NULL,
  PRIMARY KEY (`order_num`),
  KEY `tenant` (`tenant`),
  KEY `house_id` (`house_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`tenant`) REFERENCES `tenants` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`house_id`) REFERENCES `airbnbs` (`house_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('ORD001',1001,1003,'2023-06-01','2023-06-07',150.00,30.00,'wait to comfired'),('ORD002',1001,1007,'2023-08-15','2023-08-20',100.00,20.00,'processing'),('ORD003',1003,1009,'2023-05-12','2023-05-18',120.00,25.00,'completed'),('ORD004',1004,1008,'2023-07-21','2023-07-24',80.00,15.00,'processing'),('ORD005',1005,1001,'2023-04-08','2023-04-10',90.00,20.00,'wait to comfired'),('ORD006',1005,1005,'2023-10-02','2023-10-08',110.00,30.00,'processing'),('ORD007',1005,1006,'2023-11-20','2023-11-25',100.00,25.00,'processing'),('ORD008',1004,1010,'2023-09-12','2023-09-15',70.00,20.00,'cencaled'),('ORD009',1006,1002,'2023-12-18','2023-12-24',130.00,35.00,'wait to comfired'),('ORD010',1010,1003,'2023-08-01','2023-08-06',95.00,20.00,'completed');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenants`
--

DROP TABLE IF EXISTS `tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenants` (
  `id` int NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Others','Not to tell') DEFAULT 'Not to tell',
  `language_code` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `language_code` (`language_code`),
  CONSTRAINT `tenants_ibfk_1` FOREIGN KEY (`language_code`) REFERENCES `languages` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenants`
--

LOCK TABLES `tenants` WRITE;
/*!40000 ALTER TABLE `tenants` DISABLE KEYS */;
INSERT INTO `tenants` VALUES (1001,'John Smith','john.smith@gmail.com','555-1234','Not to tell','EN'),(1002,'Mary Johnson','mary.johnson@outlook.com','555-5678','Not to tell','FR'),(1003,'John Doe','jdoe@gmail.com','555-2345','Not to tell','ZH'),(1004,'Linda Lee','linda.lee@gmail.com','555-6789','Female','EL'),(1005,'Michael Kim','michael.kim@outlook.com','555-3456','Male','JA'),(1006,'Emily Chen','emily.chen@gmail.com','555-7890','Female','EN'),(1007,'John Lee','jlee@NEU.edu','555-4321','Others','ZH'),(1008,'Emily Chen','emily.chen@outlook.com','555-8765','Female','FR'),(1009,'Mary Johnson','mjohnson@NEU.edu','555-2198','Others','EL'),(1010,'David Kim','dkim@outlook.com','555-7654','Male','JA');
/*!40000 ALTER TABLE `tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `world_cities`
--

DROP TABLE IF EXISTS `world_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `world_cities` (
  `city_id` int NOT NULL,
  `city` varchar(225) NOT NULL,
  `country` varchar(225) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `world_cities`
--

LOCK TABLES `world_cities` WRITE;
/*!40000 ALTER TABLE `world_cities` DISABLE KEYS */;
INSERT INTO `world_cities` VALUES (1004993580,'Kabul','Afghanistan'),(1012973369,'Algiers','Algeria'),(1024949724,'Luanda','Angola'),(1031946365,'Baku','Azerbaijan'),(1032717330,'Buenos Aires','Argentina'),(1032803249,'Cordoba','Argentina'),(1036074917,'Sydney','Australia'),(1036178956,'Perth','Australia'),(1036192929,'Brisbane','Australia'),(1036533631,'Melbourne','Australia'),(1040261752,'Vienna','Austria'),(1050424421,'Narayanganj','Bangladesh'),(1050529279,'Dhaka','Bangladesh'),(1050667339,'Khulna','Bangladesh'),(1050830722,'Chattogram','Bangladesh'),(1056469830,'Brussels','Belgium'),(1068000064,'La Paz','Bolivia'),(1068129363,'Santa Cruz','Bolivia'),(1076033299,'Santos','Brazil'),(1076034054,'Goiania','Brazil'),(1076137337,'Recife','Brazil'),(1076144436,'Brasilia','Brazil'),(1076532519,'Sao Paulo','Brazil'),(1076567885,'Fortaleza','Brazil'),(1076607274,'Manaus','Brazil'),(1076646823,'Belem','Brazil'),(1076658221,'Porto Alegre','Brazil'),(1076701712,'Curitiba','Brazil'),(1076730420,'Guarulhos','Brazil'),(1076887657,'Rio de Janeiro','Brazil'),(1076923789,'Salvador','Brazil'),(1076967355,'Belo Horizonte','Brazil'),(1100762037,'Sofia','Bulgaria'),(1104468217,'Mandalay','Myanmar'),(1104616656,'Rangoon','Myanmar'),(1112348503,'Minsk','Belarus'),(1116260534,'Phnom Penh','Cambodia'),(1120298240,'Yaounde','Cameroon'),(1120494607,'Douala','Cameroon'),(1120909610,'Bamenda','Cameroon'),(1124279679,'Toronto','Canada'),(1124586170,'Montreal','Canada'),(1124825478,'Vancouver','Canada'),(1144251314,'Colombo','Sri Lanka'),(1152554349,'Santiago','Chile'),(1156002290,'Xiaoganzhan','China'),(1156006600,'Liaocheng','China'),(1156010654,'Loudi','China'),(1156012979,'Longyan','China'),(1156018927,'Bijie','China'),(1156019650,'Wuxi','China'),(1156023354,'Zigong','China'),(1156025536,'Sanzhou','China'),(1156029196,'Suzhou','China'),(1156032582,'Qinbaling','China'),(1156032751,'Baotou','China'),(1156032841,'Rizhao','China'),(1156035381,'Xinpu','China'),(1156036420,'Chuzhou','China'),(1156038165,'Jingdezhen','China'),(1156041962,'Zhuzhou','China'),(1156044130,'Lincang','China'),(1156045365,'Nantong','China'),(1156046704,'Lianshan','China'),(1156046916,'Xushan','China'),(1156051276,'Urumqi','China'),(1156051957,'Shuyangzha','China'),(1156052493,'Wenling','China'),(1156057251,'Yunfu','China'),(1156057944,'Changzhi','China'),(1156063295,'Siping','China'),(1156066465,'Pingxiang','China'),(1156069315,'Luoyang','China'),(1156072884,'Zhangjiajie','China'),(1156073548,'Shanghai','China'),(1156078103,'Changchun','China'),(1156081448,'Xining','China'),(1156084562,'Guangyuan','China'),(1156086320,'Linyi','China'),(1156089994,'Tieling','China'),(1156091093,'Qinhuangdao','China'),(1156091241,'Shangzhou','China'),(1156095188,'Tai\'an','China'),(1156097909,'Benxi','China'),(1156101096,'Baojishi','China'),(1156104017,'Qincheng','China'),(1156105613,'Jiangmen','China'),(1156106507,'Kuaidamao','China'),(1156106602,'Qinzhou','China'),(1156107325,'Xiangyang','China'),(1156107603,'Yibin','China'),(1156109017,'Langfang','China'),(1156112588,'Qingdao','China'),(1156114238,'Pizhou','China'),(1156114258,'Hebi','China'),(1156117184,'Wuhan','China'),(1156119229,'Taizhou','China'),(1156120117,'Xianyang','China'),(1156123172,'Yangjiang','China'),(1156127147,'Deyang','China'),(1156127660,'Nangandao','China'),(1156131504,'Chizhou','China'),(1156135890,'Qingyuan','China'),(1156139322,'Wuzhong','China'),(1156140738,'Baiyin','China'),(1156141954,'Fuxin','China'),(1156142626,'Huaibei','China'),(1156157078,'Pingdu','China'),(1156157151,'Jinzhou','China'),(1156157844,'Yangquan','China'),(1156157854,'Jiaozuo','China'),(1156158707,'Shenzhen','China'),(1156163376,'Jincheng','China'),(1156165517,'Guiping','China'),(1156167204,'Hechi','China'),(1156170144,'Zhaoqing','China'),(1156170787,'Ningbo','China'),(1156173813,'Ximeicun','China'),(1156174046,'Tianjin','China'),(1156175472,'Dalian','China'),(1156178316,'Dandong','China'),(1156183137,'Zhengzhou','China'),(1156183327,'Haikou','China'),(1156184822,'Zhumadian','China'),(1156185501,'Meishan','China'),(1156185511,'Changzhou','China'),(1156188037,'Fuzhou','China'),(1156188829,'Wenzhou','China'),(1156192287,'Nanyang','China'),(1156195684,'Xiangtan','China'),(1156198356,'Huanglongsi','China'),(1156198892,'Nanchang','China'),(1156200037,'Huanggang','China'),(1156202749,'Liaoyang','China'),(1156203000,'Yangshe','China'),(1156203130,'Leshan','China'),(1156203268,'Huizhou','China'),(1156206041,'Jiujiang','China'),(1156210167,'Hohhot','China'),(1156212349,'Suqian','China'),(1156212809,'Xiamen','China'),(1156216904,'Pingliang','China'),(1156217114,'Yanjiang','China'),(1156217541,'Shijiazhuang','China'),(1156218615,'Yiyang','China'),(1156225008,'Heze','China'),(1156227167,'Shuozhou','China'),(1156228865,'Beijing','China'),(1156229590,'Yichun','China'),(1156234290,'Huangshi','China'),(1156235364,'Guilin','China'),(1156235493,'Suihua','China'),(1156235735,'Jiangguanchi','China'),(1156237133,'Guangzhou','China'),(1156238875,'Anqing','China'),(1156241528,'Harbin','China'),(1156241637,'Zhangzhou','China'),(1156241678,'Tongshan','China'),(1156244079,'Xi\'an','China'),(1156245000,'Yushan','China'),(1156245904,'Shuangyashan','China'),(1156248008,'Fuyang','China'),(1156249698,'Mudanjiang','China'),(1156255711,'Ankang','China'),(1156256829,'Baoding','China'),(1156257074,'Yingkou','China'),(1156260378,'Jieyang','China'),(1156271365,'Bazhou','China'),(1156272098,'Zhoukou','China'),(1156273372,'Qingyang','China'),(1156273453,'Xinyang','China'),(1156275243,'Hangzhou','China'),(1156277458,'Chifeng','China'),(1156278215,'Ji\'an','China'),(1156280566,'Lanzhou','China'),(1156280672,'Yulinshi','China'),(1156291915,'Chenzhou','China'),(1156294429,'Sanming','China'),(1156294952,'Xingtai','China'),(1156309382,'Shenyang','China'),(1156310366,'Shaoyang','China'),(1156315512,'Wuhu','China'),(1156322307,'Taizhou','China'),(1156330876,'Luohe','China'),(1156332710,'Hefei','China'),(1156335543,'Huzhou','China'),(1156339225,'Heihe','China'),(1156350864,'Jiamusi','China'),(1156353465,'Huaihua','China'),(1156356860,'Bozhou','China'),(1156358686,'Tongliao','China'),(1156359072,'Yinchuan','China'),(1156360785,'Liuzhou','China'),(1156361028,'Meizhou','China'),(1156366507,'Liangshi','China'),(1156377302,'Guang\'an','China'),(1156381094,'Zibo','China'),(1156382678,'Hanzhong','China'),(1156383921,'Shiyan','China'),(1156393765,'Jixi','China'),(1156403962,'Daqing','China'),(1156405492,'Shangrao','China'),(1156415948,'Anshun','China'),(1156416074,'Linfen','China'),(1156417758,'Mianyang','China'),(1156421449,'Beihai','China'),(1156421555,'Chengdu','China'),(1156424311,'Xuanzhou','China'),(1156431924,'Puyang','China'),(1156435764,'Baicheng','China'),(1156438670,'Chongzuo','China'),(1156440668,'Bengbu','China'),(1156449091,'Changde','China'),(1156457499,'Shantou','China'),(1156459799,'Hezhou','China'),(1156473300,'Weihai','China'),(1156477539,'Kunming','China'),(1156478242,'Dongguan','China'),(1156491661,'Jiaxing','China'),(1156499624,'Lu\'an','China'),(1156502170,'Zhanjiang','China'),(1156504601,'Jining','China'),(1156516335,'Neijiang','China'),(1156518274,'Dingxi','China'),(1156522457,'Gaoping','China'),(1156524080,'Dezhou','China'),(1156527426,'Huangshan','China'),(1156529682,'Sanmenxia','China'),(1156539782,'Zunyi','China'),(1156545200,'Jianguang','China'),(1156546342,'Yan\'an','China'),(1156546994,'Baoshan','China'),(1156547188,'Jinhua','China'),(1156549118,'Chaozhou','China'),(1156564962,'Binzhou','China'),(1156568722,'Maoming','China'),(1156579621,'Zhongshan','China'),(1156580218,'Huludao','China'),(1156582079,'Luzhou','China'),(1156592042,'Yutan','China'),(1156605439,'Nanning','China'),(1156617066,'Shaoguan','China'),(1156617534,'Xinzhou','China'),(1156620133,'Wuzhou','China'),(1156632014,'Taiyuan','China'),(1156633259,'Longba','China'),(1156634228,'Huai\'an','China'),(1156644065,'Nanjing','China'),(1156644508,'Pudong','China'),(1156646448,'Jilin','China'),(1156655650,'Suining','China'),(1156665165,'Heyuan','China'),(1156672254,'Shengli','China'),(1156680279,'Gulou','China'),(1156682309,'Yuxi','China'),(1156694479,'Yongzhou','China'),(1156696884,'Hengyang','China'),(1156698069,'Cangzhou','China'),(1156705644,'Yuncheng','China'),(1156706927,'Chaoyang','China'),(1156722242,'Zhuhai','China'),(1156735124,'Pingdingshan','China'),(1156738403,'Foshan','China'),(1156747998,'Qujing','China'),(1156756494,'Puning','China'),(1156760291,'Wuwei','China'),(1156761230,'Xintai','China'),(1156762337,'Nanchong','China'),(1156764447,'Xiaoxita','China'),(1156775905,'Qiqihar','China'),(1156785303,'Gaozhou','China'),(1156796454,'Zaozhuang','China'),(1156796734,'Huazhou','China'),(1156800221,'Zhangjiakou','China'),(1156803028,'Hengshui','China'),(1156803442,'Tongren','China'),(1156805441,'Shangqiu','China'),(1156811601,'Putian','China'),(1156817119,'Yucheng','China'),(1156817541,'Guyuan','China'),(1156818601,'Yangzhou','China'),(1156829655,'Quanzhou','China'),(1156832475,'Ganzhou','China'),(1156834076,'Dazhou','China'),(1156847452,'Ma\'anshan','China'),(1156857743,'Fushun','China'),(1156858793,'Lishui','China'),(1156863840,'Leizhou','China'),(1156871297,'Suzhou','China'),(1156877299,'Huainan','China'),(1156883901,'Chengtangcun','China'),(1156893449,'Shaoxing','China'),(1156893569,'Fuqing','China'),(1156895251,'Guigang','China'),(1156898522,'Xiping','China'),(1156901312,'Yulin','China'),(1156901538,'Changshu','China'),(1156901825,'Anshan','China'),(1156903687,'Weinan','China'),(1156904299,'Tangshan','China'),(1156909802,'Ningde','China'),(1156912965,'Weifang','China'),(1156915325,'Fuzhou','China'),(1156924687,'Zhaotong','China'),(1156925734,'Laibin','China'),(1156927445,'Nanping','China'),(1156932620,'Guiyang','China'),(1156932948,'Yantai','China'),(1156934125,'Zhenjiang','China'),(1156936556,'Chongqing','China'),(1156939010,'Shanwei','China'),(1156944106,'Lianjiang','China'),(1156957080,'Handan','China'),(1156961497,'Changsha','China'),(1156972469,'Jinan','China'),(1156981113,'Baicheng','China'),(1156993705,'Rui\'an','China'),(1156995410,'Yancheng','China'),(1158025380,'Zhongli','Taiwan'),(1158061376,'Tainan','Taiwan'),(1158331334,'Kaohsiung','Taiwan'),(1158689622,'Taichung','Taiwan'),(1158881289,'Taipei','Taiwan'),(1170179113,'Barranquilla','Colombia'),(1170417589,'Cali','Colombia'),(1170483426,'Bogota','Colombia'),(1170680389,'Medellin','Colombia'),(1170815311,'Timbio','Colombia'),(1178340306,'Brazzaville','Congo (Brazzaville)'),(1180000363,'Kinshasa','Congo (Kinshasa)'),(1180172460,'Kananga','Congo (Kinshasa)'),(1180399586,'Mbuji-Mayi','Congo (Kinshasa)'),(1180506234,'Lubumbashi','Congo (Kinshasa)'),(1188749877,'San Jose','Costa Rica'),(1192752771,'Havana','Cuba'),(1203744823,'Prague','Czechia'),(1208763942,'Copenhagen','Denmark'),(1214636202,'Santo Domingo','Dominican Republic'),(1214985348,'Santiago','Dominican Republic'),(1218441993,'Quito','Ecuador'),(1218802178,'Guayaquil','Ecuador'),(1231824991,'Addis Ababa','Ethiopia'),(1250015082,'Paris','France'),(1276041799,'Hamburg','Germany'),(1276171358,'Stuttgart','Germany'),(1276451290,'Berlin','Germany'),(1276692352,'Munich','Germany'),(1288164978,'Boankra','Ghana'),(1288181103,'Kumasi','Ghana'),(1288299415,'Accra','Ghana'),(1300715560,'Athens','Greece'),(1320197916,'Guatemala City','Guatemala'),(1324568159,'Conakry','Guinea'),(1340344059,'Tegucigalpa','Honduras'),(1344538284,'Kowloon','Hong Kong'),(1344982653,'Hong Kong','Hong Kong'),(1348611435,'Budapest','Hungary'),(1356013205,'Faridabad','India'),(1356060520,'Kolkata','India'),(1356081074,'Pune','India'),(1356151564,'Agwar','India'),(1356187395,'Agra','India'),(1356226629,'Mumbai','India'),(1356257289,'Madurai','India'),(1356293537,'Jaipur','India'),(1356304381,'Ahmedabad','India'),(1356317190,'Rajkot','India'),(1356365743,'Nagpur','India'),(1356374944,'Chennai','India'),(1356402812,'Indore','India'),(1356410365,'Bangalore','India'),(1356427908,'Mirzapur','India'),(1356475483,'Chinchvad','India'),(1356501259,'Jamshedpur','India'),(1356562598,'Nasik','India'),(1356575238,'Cawnpore','India'),(1356681152,'Thane','India'),(1356691871,'Ghaziabad','India'),(1356692563,'Vishakhapatnam','India'),(1356705249,'Vadodara','India'),(1356718332,'Prayagraj','India'),(1356734039,'Bhopal','India'),(1356758738,'Surat','India'),(1356820491,'Bilaspur','India'),(1356821429,'Patna','India'),(1356840670,'Aurangabad','India'),(1356871768,'Hyderabad','India'),(1356872604,'Delhi','India'),(1356891790,'Lucknow','India'),(1356929498,'Ludhiana','India'),(1360002844,'Tangerang','Indonesia'),(1360006015,'Bekasi','Indonesia'),(1360029147,'Sangereng','Indonesia'),(1360051337,'Makassar','Indonesia'),(1360141408,'Malang','Indonesia'),(1360484663,'Surabaya','Indonesia'),(1360543171,'Medan','Indonesia'),(1360745537,'Semarang','Indonesia'),(1360771077,'Jakarta','Indonesia'),(1360848527,'Denpasar','Indonesia'),(1360902897,'Palembang','Indonesia'),(1360962899,'Depok','Indonesia'),(1364006067,'Kashan','Iran'),(1364023865,'Esfahan','Iran'),(1364123206,'Mashhad','Iran'),(1364141756,'Tabriz','Iran'),(1364258511,'Karaj','Iran'),(1364305026,'Tehran','Iran'),(1364432238,'Shiraz','Iran'),(1368194914,'Mosul','Iraq'),(1368596238,'Baghdad','Iraq'),(1368714645,'Al Basrah','Iraq'),(1376401542,'Tel Aviv-Yafo','Israel'),(1380382862,'Rome','Italy'),(1380724377,'Milan','Italy'),(1392000195,'Sapporo','Japan'),(1392003356,'Kawasaki','Japan'),(1392017719,'Saitama','Japan'),(1392118339,'Yokohama','Japan'),(1392407472,'Nagoya','Japan'),(1392419823,'Osaka','Japan'),(1392576294,'Fukuoka','Japan'),(1392622735,'Kyoto','Japan'),(1392685764,'Tokyo','Japan'),(1392978082,'Kobe','Japan'),(1398351701,'Almaty','Kazakhstan'),(1400522593,'Amman','Jordan'),(1404000661,'Nairobi','Kenya'),(1404588252,'Meru','Kenya'),(1408738594,'Pyongyang','North Korea'),(1410000087,'Gwangju','South Korea'),(1410095252,'Daegu','South Korea'),(1410160313,'Incheon','South Korea'),(1410601465,'Busan','South Korea'),(1410836482,'Seoul','South Korea'),(1410993875,'Daejeon','South Korea'),(1414102075,'Kuwait City','Kuwait'),(1450978461,'Antananarivo','Madagascar'),(1454145012,'Blantyre','Malawi'),(1458988644,'Kuala Lumpur','Malaysia'),(1466367944,'Balandougou','Mali'),(1466965925,'Bamako','Mali'),(1484003694,'Ecatepec','Mexico'),(1484198680,'Zapopan','Mexico'),(1484247881,'Mexico City','Mexico'),(1484416394,'Puebla','Mexico'),(1484559591,'Monterrey','Mexico'),(1484708778,'Tijuana','Mexico'),(1484811199,'Leon de los Aldama','Mexico'),(1484840083,'Juarez','Mexico'),(1484950208,'Guadalajara','Mexico'),(1496024767,'Ulaanbaatar','Mongolia'),(1504175315,'Casablanca','Morocco'),(1504846488,'El Kelaa des Srarhna','Morocco'),(1512035506,'Muscat','Oman'),(1528355309,'Amsterdam','Netherlands'),(1554435911,'Auckland','New Zealand'),(1566070649,'Port Harcourt','Nigeria'),(1566262000,'Aba','Nigeria'),(1566342270,'Abuja','Nigeria'),(1566366407,'Ibadan','Nigeria'),(1566422868,'Kano','Nigeria'),(1566593483,'Onitsha','Nigeria'),(1566593751,'Lagos','Nigeria'),(1586129469,'Karachi','Pakistan'),(1586185019,'Hyderabad City','Pakistan'),(1586256291,'Multan','Pakistan'),(1586323916,'Faisalabad','Pakistan'),(1586344001,'Rawalpindi','Pakistan'),(1586400472,'Gujranwala','Pakistan'),(1586619596,'Saidu Sharif','Pakistan'),(1586801463,'Lahore','Pakistan'),(1586851102,'Peshawar','Pakistan'),(1591672475,'Panama City','Panama'),(1604728603,'Lima','Peru'),(1608618140,'Manila','Philippines'),(1608897690,'Caloocan City','Philippines'),(1608906877,'Davao','Philippines'),(1608974097,'Quezon City','Philippines'),(1616024847,'Warsaw','Poland'),(1620619017,'Lisbon','Portugal'),(1630035577,'San Juan','Puerto Rico'),(1642414442,'Bucharest','Romania'),(1643318494,'Moscow','Russia'),(1643399240,'Novosibirsk','Russia'),(1643582706,'Yekaterinburg','Russia'),(1643616350,'Saint Petersburg','Russia'),(1682169241,'Mecca','Saudi Arabia'),(1682926944,'Jeddah','Saudi Arabia'),(1682999334,'Riyadh','Saudi Arabia'),(1686604760,'Dakar','Senegal'),(1688374696,'Belgrade','Serbia'),(1702341327,'Singapore','Singapore'),(1704000623,'Haiphong','Vietnam'),(1704413791,'Hanoi','Vietnam'),(1704774326,'Ho Chi Minh City','Vietnam'),(1706054548,'Boosaaso','Somalia'),(1706893395,'Mogadishu','Somalia'),(1710550792,'Johannesburg','South Africa'),(1716196799,'Harare','Zimbabwe'),(1724594040,'Barcelona','Spain'),(1724616994,'Madrid','Spain'),(1729268475,'Khartoum','Sudan'),(1729912179,'Omdurman','Sudan'),(1752425602,'Stockholm','Sweden'),(1760366651,'Aleppo','Syria'),(1760685964,'Damascus','Syria'),(1764068610,'Bangkok','Thailand'),(1784176710,'Abu Dhabi','United Arab Emirates'),(1784736618,'Dubai','United Arab Emirates'),(1792014004,'Konya','Turkey'),(1792169057,'Samsun','Turkey'),(1792520282,'Mersin','Turkey'),(1792536241,'Diyarbakir','Turkey'),(1792572891,'Ankara','Turkey'),(1792725579,'Izmir','Turkey'),(1792756324,'Istanbul','Turkey'),(1792783772,'Adana','Turkey'),(1792903330,'Bursa','Turkey'),(1792911843,'Gaziantep','Turkey'),(1792937570,'Sanliurfa','Turkey'),(1792945815,'Kayseri','Turkey'),(1792988434,'Antalya','Turkey'),(1800406299,'Kampala','Uganda'),(1804382913,'Kyiv','Ukraine'),(1804588111,'Kharkiv','Ukraine'),(1818253931,'Cairo','Egypt'),(1818695837,'Alexandria','Egypt'),(1818925479,'Giza','Egypt'),(1826246335,'Manchester','United Kingdom'),(1826423213,'Birmingham','United Kingdom'),(1826645935,'London','United Kingdom'),(1834843853,'Dar es Salaam','Tanzania'),(1840000455,'Boston','United States'),(1840000494,'Chicago','United States'),(1840000596,'Cleveland','United States'),(1840000673,'Philadelphia','United States'),(1840001254,'Pittsburgh','United States'),(1840001592,'Baltimore','United States'),(1840001651,'St. Louis','United States'),(1840003046,'Milwaukee','United States'),(1840003760,'Columbus','United States'),(1840003814,'Cincinnati','United States'),(1840003871,'Virginia Beach','United States'),(1840003971,'Detroit','United States'),(1840006060,'Washington','United States'),(1840007830,'Minneapolis','United States'),(1840008535,'Kansas City','United States'),(1840013660,'Atlanta','United States'),(1840014557,'Charlotte','United States'),(1840015099,'Orlando','United States'),(1840015149,'Miami','United States'),(1840015982,'Tampa','United States'),(1840018789,'Denver','United States'),(1840019440,'Dallas','United States'),(1840019590,'Austin','United States'),(1840019941,'Portland','United States'),(1840020364,'Las Vegas','United States'),(1840020491,'Los Angeles','United States'),(1840020551,'Riverside','United States'),(1840020568,'Phoenix','United States'),(1840020925,'Houston','United States'),(1840021117,'Seattle','United States'),(1840021491,'Sacramento','United States'),(1840021543,'San Francisco','United States'),(1840021570,'San Jose','United States'),(1840021990,'San Diego','United States'),(1840022220,'San Antonio','United States'),(1840030084,'Indianapolis','United States'),(1840033999,'Bronx','United States'),(1840034000,'Manhattan','United States'),(1840034002,'Queens','United States'),(1840034016,'New York','United States'),(1840034030,'Brooklyn','United States'),(1854029208,'Ouagadougou','Burkina Faso'),(1858107000,'Montevideo','Uruguay'),(1860331871,'Tashkent','Uzbekistan'),(1862072711,'Maracaibo','Venezuela'),(1862309871,'Valencia','Venezuela'),(1862748204,'Caracas','Venezuela'),(1887750814,'Sanaa','Yemen'),(1894157390,'Lusaka','Zambia');
/*!40000 ALTER TABLE `world_cities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-09 23:33:02

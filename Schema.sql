CREATE DATABASE IF NOT EXISTS Airbnb;
SET FOREIGN_KEY_CHECKS=0;
use Airbnb;

-- the values in table languages and gender_pronouse are not changable

CREATE TABLE IF NOT EXISTS languages (
  `name` VARCHAR(50) NOT NULL,
  `code` CHAR(2),
  PRIMARY KEY (`code`)
);


DROP TABLE IF EXISTS  tenants;
CREATE TABLE tenants (
	id INT PRIMARY KEY,
	`name`  VARCHAR(20) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	phone VARCHAR(20) UNIQUE,
    gender ENUM("Male", "Female", "Others", "Not to tell") DEFAULT "Not to tell",
    language_code CHAR(2),

	FOREIGN KEY (language_code) REFERENCES languages(`code`) 
    -- FOREIGN KEY (gender) REFERENCES gender_pronous(id)
);

-- INSERT tenants(id, `name`, email, language_code)
-- Value(10, "Ellen", "eell_ww@124.com", "EN");

DROP TABLE IF EXISTS hosts;
CREATE TABLE `hosts`(
    id INT,
    host_name VARCHAR(150) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    gender ENUM("Male", "Female", "Others", "Not to tell") DEFAULT "Not to tell",
	language_code CHAR(2),
    PRIMARY KEY(id),
    FOREIGN KEY (language_code) REFERENCES languages(`code`)
);


DROP TABLE IF EXISTS world_cities;
CREATE TABLE IF NOT EXISTS world_cities(
    city_id INT PRIMARY KEY,
    city VARCHAR(225) NOT NULL,
    country VARCHAR(225) NOT NULL
);


DROP TABLE IF EXISTS airbnbs;
CREATE TABLE airbnbs(
    house_id INT,
	host_id INT,
    title VARCHAR(100) NOT NULL,
    city_id INT,
    address VARCHAR(100),  -- Specific address
    num_of_rooms INT(3),
    num_of_beds INT(3),
    num_parking INT(2),
    average_rating DECIMAL(3,2) DEFAULT NULL,
    rating_times INT DEFAULT 0,
    `description` varchar(10000) DEFAULT NULL,
    current_price DECIMAL(10,2),
    current_cleaning_fee DECIMAL(10,2),
    PRIMARY KEY (house_id),
    FOREIGN KEY (host_id) REFERENCES hosts(id),
    FOREIGN KEY (city_id) REFERENCES world_cities(city_id)
);


DROP TABLE IF EXISTS airbnb_unavailable;
CREATE TABLE airbnb_unavailable(
	house_id int,
	start_date DATE,
    end_date DATE,
    PRIMARY KEY (house_id, start_date, end_date),
	FOREIGN KEY (house_id) REFERENCES airbnbs(house_id)
);
    
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_num VARCHAR(10),
    tenant INT NOT NULL,
    house_id INT NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    price_per_day DECIMAL(10,2),
    cleaning_fee  DECIMAL(10,2),
    states ENUM("wait to comfired", "cencaled", "processing", "completed"),
    primary key (order_num),
    FOREIGN KEY (tenant) REFERENCES tenants(id),
    FOREIGN KEY (house_id) REFERENCES airbnbs(house_id) 
);

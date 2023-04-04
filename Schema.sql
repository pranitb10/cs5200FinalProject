CREATE DATABASE IF NOT EXISTS Airbnb;
SET FOREIGN_KEY_CHECKS=0;
use Airbnb;

-- the values in table languages and gender_pronouse are not changable

CREATE TABLE IF NOT EXISTS gender_pronous(
  id INT NOT NULL,
  pronous VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS languages (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS  tenantes;
CREATE TABLE tenantes (
	id INT PRIMARY KEY,
	name  VARCHAR(20) NOT NULL,
	email VARCHAR(50) UNIQUE,
	phone INT,
    gender INT,
    language_id INT(4),
    FOREIGN KEY (language_id) REFERENCES languages(id),
    FOREIGN KEY (gender) REFERENCES gender_pronous(id)
);


DROP TABLE IF EXISTS hosts;
CREATE TABLE `hosts`(
    id INT,
    host_name VARCHAR(150),
    email VARCHAR(50) UNIQUE,
	language_id INT(4),
    PRIMARY KEY(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);

DROP TABLE IF EXISTS airbnbs;
CREATE TABLE airbnbs(
    house_id INT,
	host_id INT,
    title VARCHAR(100) NOT NULL,
    country CHAR(60),
    city CHAR(60),
    neighbor CHAR(60),
    street CHAR(60),
    num_of_rooms INT,
    num_of_beds INT,
    PRIMARY KEY (house_id),
    FOREIGN KEY (host_id) REFERENCES hosts(id)
);

DROP TABLE IF EXISTS airbnb_unavailable;
CREATE TABLE airbnb_unavailable(
	house_id INT,
	start_date DATE,
    end_date DATE,
  FOREIGN KEY (house_id) REFERENCES airbnbs(house_id)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_num INT,
    check_in_date date,
    check_out_date date,
    price_per_day float,
    cleaning_fee  float,
    states ENUM("wait to comfired", "cencaled", "processing", "completed"),
    primary key (order_num)
);


-- complex relationship table book
DROP TABLE IF EXISTS book;
CREATE TABLE book(
	tenante INT,
    airbnb INT,
    order_num INT,
    FOREIGN KEY (tenante) REFERENCES tenantes(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (airbnb) REFERENCES airbnbs(house_id),
    FOREIGN KEY (order_num) REFERENCES orders(order_num)
)

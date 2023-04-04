CREATE DATABASE IF NOT EXISTS Airbnb;

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
	id INT(12) PRIMARY KEY,
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
    id INT(12),
    host_name VARCHAR(150),
    email VARCHAR(50) UNIQUE,
	language_id INT(4),
    PRIMARY KEY(id),
    FOREIGN KEY (language_id) REFERENCES languages(id)
);

DROP TABLE IF EXISTS airbnbs;
CREATE TABLE airbnbs(
    house_id INT(20),
    `host` INT(12),
    title VARCHAR(100) NOT NULL,
    country CHAR(60),
    city CHAR(60),
    neighbor CHAR(60),
    street CHAR(60),
    host_id INT(12),
    PRIMARY KEY (house_id),
    FOREIGN KEY (host_id) REFERENCES hosts(id)
);

CREATE TABLE airbnb_unavailable(
	house_id int(20),
  unavailable DATE
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_num INT(40),
    check_in_date datetime,
    check_out_date datetime,
    price_per_day float,
    cleaning_fee  float,
    states ENUM("wait to comfired", "cencaled", "processing", "completed"),
    primary key (order_num)
);


-- complex relationship table book
DROP TABLE IF EXISTS book;
CREATE TABLE book(
	tenante int(12),
    airbnb int(20),
    order_num int(40),
    FOREIGN KEY (tenante) REFERENCES tenantes(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (airbnb) REFERENCES airbnbs(house_id),
    FOREIGN KEY (order_num) REFERENCES orders(order_num)
)

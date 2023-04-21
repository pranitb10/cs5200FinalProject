USE airbnb;

-- sign up as an tenenate
/*
creat_tenenate([name, email, phone, [gender], [language_id])
create a new id inside of the procedure.
gender as default "not to tell", language as NULL,
user can update this information in edite_tenate
*/

DROP PROCEDURE IF EXISTS create_tenant;
DELIMITER //
CREATE PROCEDURE create_tenant(
    IN p_name VARCHAR(20),
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(20),
    IN p_gender ENUM("Male", "Female", "Others", "Not to tell"),
    IN p_language_code CHAR(2)
)
BEGIN
    -- Insert the new tenant into the tenants table
    INSERT INTO tenants (name, email, phone, gender, language_code)
    VALUES (p_name, p_email, p_phone, p_gender, p_language_code);
END //
	DELIMITER  ;



-- setting the account
/*
edite_tenenate(id, gender_p, language_p)
check whether the language_p is in the languages schema before insert
*/

DROP PROCEDURE IF EXISTS edit_tenant;

DELIMITER $$
CREATE PROCEDURE edit_tenant(
    IN p_email VARCHAR(50),
    IN p_gender ENUM('Male', 'Female', 'Others', 'Not to tell'),
    IN p_language CHAR(2)
)
BEGIN
    UPDATE tenants
    SET gender = p_gender, language_code = p_language
    WHERE email = p_email;
END $$

DELIMITER ;



-- Sign up host
/*
creat_host(name, email, [phone])
phomne can be NULL
gender as default "not to tell", language as NULL,
host can update this information in edite_tenate
*/
DROP PROCEDURE IF EXISTS create_host;
DELIMITER //

CREATE PROCEDURE create_host(
    IN p_host_name VARCHAR(150),
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(20),
    IN p_gender ENUM("Male", "Female", "Others", "Not to tell"),
    IN p_language_code CHAR(2)
)
BEGIN
    -- Insert the new host into the hosts table
    INSERT INTO hosts (host_name, email, phone, gender, language_code)
    VALUES (p_host_name, p_email, p_phone, p_gender, p_language_code);
END //

DELIMITER ;


-- setting the account
/*
edite_tenenate(id, gender_p, language_p)
check whether the language_p is in the languages schema before insert
*/

DROP PROCEDURE IF EXISTS edit_host;

DELIMITER $$
CREATE PROCEDURE edit_host(
	IN p_email VARCHAR(50),
    IN p_gender ENUM('Male', 'Female', 'Others', 'Not to tell'),
    IN p_language CHAR(2)
)
BEGIN
	UPDATE hosts SET gender = p_gender, language_code = p_language WHERE email = p_email;
END $$

DELIMITER ;



-- display all the airbnb under the host
/*
display_airbnb(host_email_p)
*/

DROP PROCEDURE IF EXISTS display_airbnb;

DELIMITER $$
CREATE PROCEDURE display_airbnb(
	host_email_p VARCHAR(50)
)
BEGIN
	SELECT * FROM airbnbs
    WHERE `host` = host_email_p;
END$$
DELIMITER ;


-- Display countries
/*
display all countries, coutries()
*/

DROP PROCEDURE IF EXISTS countries;

DELIMITER $$
	CREATE PROCEDURE countries()
	BEGIN
    SELECT country FROM world_cities GROUP BY country;
    END $$
DELIMITER ;


-- Display cities by country
/*
display_cities(country_p)
*/
DROP PROCEDURE IF EXISTS display_cities;

DELIMITER $$
	CREATE PROCEDURE display_cities(
		country_p VARCHAR(225)
	)
	BEGIN
    SELECT city_id, city FROM world_cities WHERE country = country_p;
    END $$
DELIMITER ;



-- Create a new airbnb
/*
house_id is auto general in the procedure, which is max_id + 1
average_rating, rating_times are as defulte
airbnbs (host_p, title_p, city_id_p, address,
		num_of_rooms, num_of_beds, num_parking,
        description_p, current_price_p, current_cleaning_fee_p)
*/

DROP FUNCTION IF EXISTS create_airbnb;

DELIMITER $$
CREATE FUNCTION create_airbnb(
	host_p VARCHAR(50),
    title_p VARCHAR(100),
    city_id_p INT,
    address_p VARCHAR(100),  -- Specific address
    num_of_rooms_p INT(3),
    num_of_beds_p INT(3),
    num_parking_p INT(2),
    description_p varchar(10000),
    current_price_p DECIMAL(10,2),
    current_cleaning_fee_p DECIMAL(10,2)
)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE new_house_id, city_p INT;
    SELECT MAX(house_id) into new_house_id FROM airbnbs;
    SET new_house_id = new_house_id +1;
    INSERT INTO airbnbs(house_id, `host`, title, city_id, address, num_of_rooms,
						num_of_beds, num_parking, `description`, current_price, current_cleaning_fee)
	VALUES(new_house_id, host_p, title_p, city_id_p, address_p, num_of_rooms_p, num_of_beds_p,
			num_parking_p, description_p, current_price_p, current_cleaning_fee_p);
	return new_house_id;
END$$
DELIMITER ;



-- Withdraw the airbnb, let the airbnb unavailable
/*
Host withdraw an aribnb in a period by add it to the unavailable table
add_unavailable(house_id_p, start_date_p, end_date_p);
*/

DROP PROCEDURE IF EXISTS add_unavailable;

DELIMITER $$
	CREATE PROCEDURE add_unavailable(
		house_id_p int,
		start_date_p DATE,
		end_date_p DATE
	)
	BEGIN
--     SELECT COUNT(*) FROM airbnb_unavailable WHERE (house_id = house_id_p)
-- 		and (start_date <= end_date_p AND end_date >=
    INSERT INTO airbnb_unavailable(house_id, start_date, end_date)
    VALUES (house_id_p, start_date_p, end_date_p);
    END $$
DELIMITER ;



-- remove the airbnb a priod of time when the airbnb is unvailable
/*
Because every unvaileble for each airbnb has unique start date and end date,
so we only need one of the dates to filter.
remove_unavailable(house_id_p, start_date_p)
*/

DROP PROCEDURE IF EXISTS remove_unavailable;

DELIMITER //
	CREATE PROCEDURE remove_unavailable(
		house_id_p int,
		start_date_p DATE
	)
	BEGIN
    declare state VARCHAR(50);
	SELECT states into state FROM airbnb_unavailable AS U
    LEFT JOIN orders AS O using(house_id)
    WHERE  house_id = house_id_p
    AND start_date = start_date_p;
    
    IF state = 'processing' THEN
    -- Report error
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Invalid genre provided.';
	ELSE
		DELETE FROM airbnb_unavailable
		WHERE house_id = house_id_p AND start_date = start_date_p;
		
	END IF;
    END $$
DELIMITER ; 


-- Edite price
/*
edite_price(house_id_p, price_p, clean_p)
*/

DROP PROCEDURE IF EXISTS edite_price;

DELIMITER $$
	CREATE PROCEDURE edite_price(
		house_id_p int,
		price_p DECIMAL(10,2),
		clean_p DECIMAL(10,2)
	)
	BEGIN
	UPDATE airbnbs SET current_price = price_p, current_cleaning_fee = clean_p
    WHERE house_id = house_id_p;
    END $$
DELIMITER ;




-- update_orders_currentdate
/*
When the check_out_date <= current date
Update the states to "completed" for orders which is "processing"

Update the states to "cencaled" for orders which is "wait to comfired"

*/
SET SQL_SAFE_UPDATES = 0;
DROP procedure IF EXISTS update_orders_currentdate;

DELIMITER $$
CREATE procedure update_orders_currentdate()
	BEGIN
	  UPDATE orders SET states = 'completed'
	  WHERE states = 'processing' AND check_out_date <= CURDATE();
      UPDATE orders SET states = 'cancelled'
	  WHERE states = 'wait to comfired' AND check_out_date <= CURDATE();
END $$
DELIMITER ;



-- Show all date of house date host can remove the unabailable
/*

*/
DROP PROCEDURE IF EXISTS dislay_removable_date;

DELIMITER $$
	CREATE PROCEDURE dislay_removable_date(
		host_id_p VARCHAR(50),
        house_id_p int
	)
	BEGIN
    SELECT 	house_id, start_date, end_date, states FROM airbnb_unavailable AS U
    LEFT JOIN airbnbs AS A USING(house_id)
    LEFT JOIN orders AS O using(house_id)
    WHERE  host = host_id_p
    AND house_id = house_id_p
    AND end_date >= CURDATE();
    END $$
DELIMITER ;


/*
A procedure to return the name of the host based on the email provided.
*/
DELIMITER $$

CREATE PROCEDURE get_host_name(
    IN p_email VARCHAR(50),
    OUT p_name VARCHAR(150)
)
BEGIN
    -- Select the host's name from the hosts table
    SELECT host_name
    INTO p_name
    FROM hosts
    WHERE email = p_email;
END $$

DELIMITER ;

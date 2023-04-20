USE airbnb;


/*
A procedure to search for hosts during login.
*/
DROP PROCEDURE IF EXISTS `login_host`;
DELIMITER //

CREATE PROCEDURE login_host(
    IN p_email VARCHAR(50),
    OUT p_result VARCHAR(150)
)
BEGIN
    DECLARE v_name VARCHAR(150);
    
    -- Check if the email and phone match a record in the hosts table
    SELECT host_name INTO v_name
    FROM hosts
    WHERE email = p_email;
    
    -- If a matching record is found, log the host in
    IF v_name IS NOT NULL THEN
        SET p_result = 1;
    ELSE
        SET p_result = 0;
    END IF;
END //

DELIMITER ;

-- Test the procedure:
-- Call the procedure with a valid email
CALL login_host('john@example.com', @result);
SELECT @result; -- Expected output: "Welcome, John Doe!"

-- Call the procedure with an invalid email
CALL login_host('invalid@example.com', @result);
SELECT @result; -- Expected output: "Invalid login credentials."




/*
A procedure to search for tenants during login.
*/
DROP PROCEDURE IF EXISTS `login_tenant`;
DELIMITER //

CREATE PROCEDURE login_tenant(
    IN p_email VARCHAR(50),
    OUT p_result VARCHAR(150)
)
BEGIN
    DECLARE v_name VARCHAR(20);
    
    -- Check if the email matches a record in the tenants table
    SELECT name INTO v_name
    FROM tenants
    WHERE email = p_email;
    
    -- If a matching record is found, log the tenant in
    IF v_name IS NOT NULL THEN
        SET p_result = 1;
    ELSE
        SET p_result = 0;
    END IF;
END //


DELIMITER ;

-- Test the procedure:
-- Call the procedure with a valid email
CALL login_tenant('jane@example.com', @result);
SELECT @result; -- Expected output: "Welcome, Jane!"

-- Call the procedure with an invalid email
CALL login_tenant('invalid@example.com', @result);
SELECT @result; -- Expected output: "Invalid login credentials."




/*
A procedure to display all the orders placed by different tenants for all the airbnbs owned by a host.
*/
DROP PROCEDURE IF EXISTS `get_host_orders`;
DELIMITER //

CREATE PROCEDURE `get_host_orders` (IN `in_host_email` VARCHAR(50))
BEGIN
    SELECT o.order_num, o.check_in_date, o.check_out_date, o.price_per_day, o.cleaning_fee, o.states,
           t.name AS tenant_name, t.email AS tenant_email, t.phone AS tenant_phone,
           a.title AS airbnb_title, a.address AS airbnb_address, a.current_price AS airbnb_price
    FROM orders o
    INNER JOIN tenants t ON o.tenant = t.email
    INNER JOIN airbnbs a ON o.house_id = a.house_id
    WHERE a.host = in_host_email
    ORDER BY o.check_in_date DESC;
END //

DELIMITER ;

-- Test the procedure:
CALL `get_host_orders`('example@gmail.com');



/*
A procedure to confirm an order, change the status of the order to confirmed, and then add that airbnb to airbnb_unavailable table for 
the period of start_date and end_date.
*/
DROP PROCEDURE IF EXISTS `confirm_order`;
DELIMITER //

CREATE PROCEDURE `confirm_order` (IN `in_order_num` VARCHAR(10), IN `in_start_date` DATE, IN `in_end_date` DATE)
BEGIN
    UPDATE orders SET states = 'processing' WHERE order_num = in_order_num;
    INSERT INTO airbnb_unavailable (house_id, start_date, end_date) 
    SELECT house_id, in_start_date, in_end_date FROM orders WHERE order_num = in_order_num;
END //

DELIMITER ;

-- Test the procedure:
CALL `confirm_order`('1234567890', '2023-05-01', '2023-05-05');




/*
A procedure to reject an order by a host when the order is placed by a tenant.
*/
DROP PROCEDURE IF EXISTS `reject_order`;
DELIMITER //

CREATE PROCEDURE `reject_order` (IN `in_order_num` VARCHAR(10))
BEGIN
    UPDATE orders SET states = 'cancelled' WHERE order_num = in_order_num;
END //

DELIMITER ;

-- Test the procedure:
CALL `reject_order`('1234567890');




/*
A procedure to change the status of the order to wait_to_confirmed by a host for an order.
*/
DROP PROCEDURE IF EXISTS `change_order_status_wait_to_confirmed`;
DELIMITER //

CREATE PROCEDURE `change_order_status_wait_to_confirmed` (IN `in_order_num` VARCHAR(10))
BEGIN
    UPDATE orders SET states = 'wait_to_confirmed' WHERE order_num = in_order_num;
END //

DELIMITER ;

-- Test the procedure:
CALL `change_order_status_wait_to_confirmed`('1234567890');



/*
A procedure to show a list of all the completed orders by a tenant so that they can rate an order from that list.
*/
DROP PROCEDURE IF EXISTS `get_completed_orders_to_rate`;
DELIMITER //

CREATE PROCEDURE `get_completed_orders_to_rate` (IN `in_tenant_email` VARCHAR(50))
BEGIN
    SELECT o.order_num, o.check_in_date, o.check_out_date, o.price_per_day, o.cleaning_fee, o.states,
           a.title AS airbnb_title, a.address AS airbnb_address, a.current_price AS airbnb_price
    FROM orders o
    INNER JOIN airbnbs a ON o.house_id = a.house_id
    WHERE o.tenant = in_tenant_email AND o.states = 'completed'
    ORDER BY o.check_out_date DESC;
END //

DELIMITER ;

-- Test the procedure:
CALL `get_completed_orders_to_rate`('example@gmail.com');




/*
A procedure to select an order from a list of completed orders generated previously and give a rating to that order.
*/
DROP PROCEDURE IF EXISTS `rate_order_and_update_airbnb`;
DELIMITER //

CREATE PROCEDURE `rate_order_and_update_airbnb` (IN `in_order_num` VARCHAR(10), IN `in_rating` INT)
BEGIN
    UPDATE orders SET rate = in_rating WHERE order_num = in_order_num AND states = 'completed';
    UPDATE airbnbs SET rating_times = rating_times + 1, 
        average_rating = ((average_rating * rating_times) + in_rating) / (rating_times + 1)
    WHERE house_id = (SELECT house_id FROM orders WHERE order_num = in_order_num);
END //

DELIMITER ;

-- Test the procedure:
CALL `rate_order_and_update_airbnb`('1234567890', 4);


/*
A procedure to ask the tenant to enter a country and look it up in the database if it exists and provide a response back accordingly.
*/
DROP PROCEDURE IF EXISTS `check_country`;
DELIMITER //

CREATE PROCEDURE `check_country` (IN `in_country` VARCHAR(225), OUT `out_response` VARCHAR(225))
BEGIN
    IF EXISTS(SELECT 1 FROM world_cities WHERE country = in_country) THEN
        SET out_response = 1;
    ELSE
        SET out_response = 0;
    END IF;
END //

DELIMITER ;

-- Test the procedure:
CALL `check_country`('France', @response);
SELECT @response;



/*
A procedure to ask the tenant to enter a city and look it up in the database if it exists and provide a response back accordingly.
*/

DROP PROCEDURE IF EXISTS `check_city`;
DELIMITER //

CREATE PROCEDURE `check_city` (IN `in_city` VARCHAR(225), OUT `out_response` VARCHAR(225))
BEGIN
    IF EXISTS(SELECT 1 FROM world_cities WHERE city = in_city) THEN
        SET out_response = 1;
    ELSE
        SET out_response = 0;
    END IF;
END //

DELIMITER ;

-- Test the procedure:
CALL `check_city`('Paris', @response);
SELECT @response;




/*
A procedure to ask for a start_date and an end_date and return a list of all the available Airbnbs based on the provided country, city, 
start_date, and end_date.
*/
DELIMITER //

CREATE PROCEDURE `search_airbnbs` (
    IN `in_country` VARCHAR(225),
    IN `in_city` VARCHAR(225),
    IN `in_start_date` DATE,
    IN `in_end_date` DATE
)
BEGIN
    SELECT a.title, a.address, a.current_price
    FROM airbnbs a
    INNER JOIN world_cities wc ON a.city_id = wc.city_id
    WHERE wc.country = in_country AND wc.city = in_city
        AND a.house_id NOT IN (
            SELECT au.house_id FROM airbnb_unavailable au
            WHERE ((in_start_date BETWEEN au.start_date AND au.end_date)
                    OR (in_end_date BETWEEN au.start_date AND au.end_date)
                    OR (in_start_date < au.start_date AND in_end_date > au.end_date))
                AND au.house_id = a.house_id
        );
END //

DELIMITER ;


-- Test the procedure:
CALL `search_airbnbs`('France', 'Paris', '2023-06-01', '2023-06-07');



/*
A procedure to ask the user to select an Airbnb from the list of provided available airbnbs and create an order in the orders table based 
on the tenant, house_id, start_date, end_date, price_per_day, cleaning_fee, status, and rating for that Airbnb.
*/
DROP PROCEDURE IF EXISTS `create_order`;
DELIMITER //

CREATE PROCEDURE `create_order` (
    IN `in_tenant_email` VARCHAR(50),
    IN `in_house_id` INT,
    IN `in_start_date` DATE,
    IN `in_end_date` DATE,
    OUT `out_order_num` VARCHAR(10)
)
BEGIN
    DECLARE order_count INT;
    SELECT COUNT(*) INTO order_count FROM orders;
    SET out_order_num = CONCAT('ORD', LPAD(order_count + 1, 4, '0'));
    INSERT INTO orders (order_num, tenant, house_id, check_in_date, check_out_date, price_per_day, cleaning_fee, states)
    VALUES (out_order_num, in_tenant_email, in_house_id, in_start_date, in_end_date, in_price_per_day, in_cleaning_fee, 'wait to comfired');
END //

DELIMITER ;


-- Test the procedure:
CALL `create_order`('johndoe@example.com', 1234, '2023-05-01', '2023-05-08', @order_num);
SELECT @order_num;



/*
A trigger to update all the other pending orders' status to rejected if an order is confirmed by the host for which the start_date and end_date 
overlaps with other orders for the same airbnb and they all have a status of wait to confirmed.
*/
DELIMITER //

CREATE TRIGGER `update_orders_status` AFTER UPDATE ON `orders`
FOR EACH ROW
BEGIN
    IF NEW.states = 'processing' AND OLD.states = 'wait to confirmed' THEN
        UPDATE orders
        SET states = 'cancelled'
        WHERE house_id = NEW.house_id
        AND states = 'wait to confirmed'
        AND (NEW.check_in_date BETWEEN check_in_date AND check_out_date
             OR NEW.check_out_date BETWEEN check_in_date AND check_out_date
             OR (NEW.check_in_date <= check_in_date AND NEW.check_out_date >= check_out_date));
    END IF;
END //

DELIMITER ;



/*
A procedure to take start_date from a tenant as an input.
*/
DROP PROCEDURE IF EXISTS `validate_start_date`;
DELIMITER //

CREATE PROCEDURE validate_start_date(
	IN input_date VARCHAR(10),
	OUT p_result VARCHAR(150)
)
BEGIN
  DECLARE valid_date DATE;
  SET valid_date = STR_TO_DATE(input_date, '%Y-%m-%d');

  IF valid_date IS NULL THEN
    SET p_result = 0;
  ELSEIF input_date < CURDATE() THEN
    SET p_result = -1;
  ELSE
    SET p_result = 1;
  END IF;
END //

DELIMITER ;



/*
A procedure to take end_date from a tenant as an input.
*/
DROP PROCEDURE IF EXISTS `validate_end_dat`;
DELIMITER //

CREATE PROCEDURE validate_end_date(
	IN input_date VARCHAR(10),
	OUT p_result VARCHAR(150)
)
BEGIN
  DECLARE valid_date DATE;
  SET valid_date = STR_TO_DATE(input_date, '%Y-%m-%d');

  IF valid_date IS NULL THEN
    SET p_result = 0;
  ELSEIF input_date < CURDATE() THEN
    SET p_result = -1;
  ELSE
    SET p_result = 1;
  END IF;
END //

DELIMITER ;



/*
A procedure to produce a list of all orders made by a tenant.
*/
DELIMITER //

CREATE PROCEDURE list_orders_by_tenant(IN tenant_email VARCHAR(50))
BEGIN
  SELECT o.order_num, h.title, c.city, c.country, o.check_in_date, o.check_out_date, o.price_per_day, o.cleaning_fee, o.states, o.rate
  FROM orders o
  JOIN airbnbs h ON o.house_id = h.house_id
  JOIN world_cities c ON h.city_id = c.city_id
  WHERE o.tenant = tenant_email;
END //

DELIMITER ;

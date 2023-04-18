/*
A procedure to search for hosts during login.
*/
DELIMITER //

CREATE PROCEDURE `check_host_login` (IN `in_email` VARCHAR(50), IN `in_password` VARCHAR(50), OUT `out_result` INT)
BEGIN
    DECLARE password_hash CHAR(60);

    SELECT `password` INTO password_hash FROM `hosts` WHERE `email` = in_email;

    IF (password_hash IS NOT NULL AND BINARY in_password = password_hash) THEN
        SET out_result = 1;
    ELSE
        SET out_result = 0;
    END IF;
END //

DELIMITER ;

-- Test the procedure:
CALL `check_host_login`('example@gmail.com', 'userpassword', @result);
SELECT @result;



/*
A procedure to search for tenants during login.
*/
DELIMITER //

CREATE PROCEDURE `check_tenant_login` (IN `in_email` VARCHAR(50), IN `in_password` VARCHAR(50), OUT `out_result` INT)
BEGIN
    DECLARE password_hash CHAR(60);

    SELECT `password` INTO password_hash FROM `tenants` WHERE `email` = in_email;

    IF (password_hash IS NOT NULL AND BINARY in_password = password_hash) THEN
        SET out_result = 1;
    ELSE
        SET out_result = 0;
    END IF;
END //

DELIMITER ;

-- Test the procedure:
CALL `check_tenant_login`('example@gmail.com', 'userpassword', @result);
SELECT @result;



/*
A procedure to display all the orders placed by different tenants for all the airbnbs owned by a host.
*/
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
DELIMITER //

CREATE PROCEDURE `change_order_status_wait_to_confirmed` (IN `in_order_num` VARCHAR(10))
BEGIN
    UPDATE orders SET states = 'wait_to_confirmed' WHERE order_num = in_order_num;
END //

DELIMITER ;

-- Test the procedure:
CALL `change_order_status_wait_to_confirmed`('1234567890');




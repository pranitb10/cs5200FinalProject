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

*/
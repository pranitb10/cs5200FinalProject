-- TEST edit_tenant
CALL edit_tenant(@email_t, "Female", "Arabic");
SELECT * FROM tenants where email = @email_t;
delete FROM tenants where email = @email_t;

-- TEST create_host
SET @email_h = "rubbybb@gmail.com";
CALL create_host("Rubby", @email_h, "711-342-9329");
SELECT * FROM hosts where email  = @email_h;
-- delete FROM hosts where email = @email_h;

-- TEST edit_host
CALL edit_host(@email_h, "Others", "Japanese");
SELECT * FROM hosts where email = @email_h;
delete FROM hosts where email = @email_h;

-- TEST display_airbnb
SET @real_hemail = 'lena.nguyen@gmail.com';
CALL display_airbnb(@real_hemail);

-- Test display_cities
CALL display_cities("United States");


-- Test create_airbnb
SET @house_id_p =  create_airbnb('mary.johnson@yahoo.com', 'Near by NEU studio', 
					'1840000455','222 Hemenway St', 0, 1, 0, NULL, 80.00, 15.00);
SELECT * FROM airbnbs WHERE house_id = @house_id_p;
DELETE FROM airbnbs WHERE house_id = @house_id_p;

-- Test add/remove_unavailable
CALL add_unavailable(1001, '2023-07-01', '2023-07-02');
SELECT * FROM airbnb_unavailable WHERE house_id = 1001;
-- DELETE FROM airbnb_unavailable WHERE house_id = 1001 AND start_date = '2023-07-01';

CALL remove_unavailable(1001, '2023-07-01');
SELECT * FROM airbnb_unavailable WHERE house_id = 1001;

-- TEST edite_price
CALL edite_price(@house_id_p, 200.00, 0);
SELECT current_price, current_cleaning_fee FROM airbnbs WHERE house_id = @house_id_p;

-- Test update_orders_currentdate
INSERT INTO orders (order_num, tenant, house_id, check_in_date, check_out_date, price_per_day, cleaning_fee, states, rate) VALUES
('ORD011', 'john.smith@gmail.com', 1003, '2023-02-01', '2023-03-07', 150.00, 30.00, 'processing', NULL);

INSERT INTO orders (order_num, tenant, house_id, check_in_date, check_out_date, price_per_day, cleaning_fee, states, rate) VALUES
('ORD012', 'john.smith@gmail.com', 1004, '2023-02-01', '2023-03-07', 150.00, 30.00, 'processing', NULL);
SELECT * FROM orders;
CALL update_orders_currentdate;
SELECT * FROM orders;

DELETE FROM orders WHERE order_num = 'ORD012';


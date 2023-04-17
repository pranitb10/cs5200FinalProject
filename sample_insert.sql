INSERT INTO tenants (`name`, email, phone, gender, language_code) VALUES
  ('John Smith', 'john.smith@gmail.com', '555-1234', 'Not to tell', 'EN'),
  ('Mary Johnson', 'mary.johnson@outlook.com', '555-5678', 'Not to tell', 'FR'),
  ('John Doe', 'jdoe@gmail.com', '555-2345', 'Not to tell', 'ZH'),
  ('Linda Lee', 'linda.lee@gmail.com', '555-6789', 'Female', 'EL'),
  ('Michael Kim', 'michael.kim@outlook.com', '555-3456', 'Male', 'JA'),
  ('Emily Chen', 'emily.chen@gmail.com', '555-7890', 'Female', 'EN'),
  ('John Lee', 'jlee@NEU.edu', '555-4321', 'Others', 'ZH'),
  ('Emily Chen', 'emily.chen@outlook.com', '555-8765', 'Female', 'FR'),
  ('Mary Johnson', 'mjohnson@NEU.edu', '555-2198', 'Others', 'EL'),
  ('David Kim', 'dkim@outlook.com', '555-7654', 'Male', 'JA');

INSERT INTO hosts (host_name, email, phone, gender, language_code) VALUES
('John Smith', 'john.smith@gmail.com', '555-555-1234', 'Male', 'en'),
('Mary Johnson', 'mary.johnson@yahoo.com', '555-555-5678', 'Female', 'en'),
('David Lee', 'david.lee@hotmail.com', NULL, 'Male', 'ko'),
('Anna Garcia', 'anna.garcia@gmail.com', '555-555-2345', 'Female', 'es'),
('Mohammed Ahmed', 'mohammed.ahmed@yahoo.com', '555-555-6789', 'Male', 'ar'),
('Lena Nguyen', 'lena.nguyen@gmail.com', NULL, 'Female', 'vi'),
('Javier Hernandez', 'javier.hernandez@yahoo.com', '555-555-3456', 'Male', 'es'),
('Sara Kim', 'sara.kim@hotmail.com', '555-555-7890', 'Female', 'ko'),
('Ahmed Hassan', 'ahmed.hassan@gmail.com', '555-555-4567', 'Male', 'ar'),
('Jasmine Wong', 'jasmine.wong@yahoo.com', '555-555-8901', 'Female', 'zh');


INSERT INTO airbnbs (house_id, `host`, title, city_id, address, num_of_rooms, num_of_beds, num_parking, average_rating, rating_times, description, current_price, current_cleaning_fee)
VALUES
(1001, 'john.smith@gmail.com', 'Cozy Apartment in the Heart of the City', 1276974738, '123 Main St.', 2, 1, 1, 2.2, 10, 'This charming apartment is located in the heart of the city and is perfect for a romantic getaway or a small family vacation.', 80.00, 10.00),
(1002, 'mary.johnson@yahoo.com', 'Spacious Loft with Stunning City Views', 1076094869, '456 Elm St.', 1, 2, 0, 1.6, 5, 'Experience urban living at its finest in this spacious loft with breathtaking city views.', 120.00, 15.00),
(1003, 'david.lee@hotmail.com', 'Luxury Condo with Pool and Gym Access', 1752708772, '789 Oak St.', 3, 3, 2, 3.0, 15, 'Treat yourself to the ultimate luxury experience in this beautiful condo with access to a pool and gym.', 250.00, 20.00),
(1004, 'anna.garcia@gmail.com', 'Coastal Cottage with Ocean Views', 1218680506, '321 Beach Rd.', 2, 2, 1, 4.7, 8, 'Escape to the coast and enjoy breathtaking ocean views from this charming cottage.', 150.00, 15.00),
(1005, 'mohammed.ahmed@yahoo.com', 'Historic Home with Modern Amenities', 1356213628, '987 Main St.', 4, 3, 2, 4.3, 12, 'Experience the best of both worlds in this beautifully restored historic home with all the modern amenities you need for a comfortable stay.', 200.00, 20.00),
(1006, 'lena.nguyen@gmail.com', 'Charming Bungalow in a Quiet Neighborhood', 1250008059, '567 Maple St.', 2, 1, 1, 5, 6, 'This charming bungalow is the perfect place to relax and unwind in a quiet neighborhood.', 100.00, 10.00),
(1007, 'lena.nguyen@gmail.com', 'Stylish Studio Apartment in Downtown', 1380805860, '246 Market St.', 1, 1, 0, 3.5, 7, 'Experience city living in style in this modern and chic studio apartment located in the heart of downtown.', 90.00, 10.00),
(1008, 'sara.kim@hotmail.com', 'Spacious Townhouse with Private Patio', 1840010109, '789 Oak St.', 3, 3, 1, 3.2, 10, 'This spacious townhouse with a private patio is the perfect home away from home for your next family vacation.', 180.00, 20.00),
(1009, 'ahmed.hassan@gmail.com', 'Modern Apartment with Stunning Views', 1036216956, '357 Hilltop Rd.', 1, 2, 1, 4.7, 4, 'Enjoy breathtaking views from this modern and stylish apartment located on a hilltop.', 120.00, 15.00),
(1010, 'jasmine.wong@yahoo.com', 'Beautifully Furnished Apartment in the City', 1840019682, '123 Main St.', 2, 2, 1, 3.8, 9, 'This beautifully furnished apartment is located in the heart of the city and is perfect for a comfortable and convenient stay.', 80.00, 15.00);


INSERT INTO airbnb_unavailable (house_id, start_date, end_date)
VALUES
	(1001, '2023-06-01', '2023-06-07'),
	(1001, '2023-08-15', '2023-08-20'),
	(1003, '2023-05-12', '2023-05-18'),
	(1004, '2023-07-21', '2023-07-24'),
	(1005, '2023-04-08', '2023-04-10'),
	(1005, '2023-10-02', '2023-10-08'),
	(1005, '2023-11-20', '2023-11-25'),
	(1004, '2023-09-12', '2023-09-15'),
	(1006, '2023-12-18', '2023-12-24'),
	(1010, '2023-08-01', '2023-08-06');


INSERT INTO orders (order_num, tenant, house_id, check_in_date, check_out_date, price_per_day, cleaning_fee, states, rate) VALUES
('ORD001', 'john.smith@gmail.com', 1003, '2023-06-01', '2023-06-07', 150.00, 30.00, 'wait to comfired', NULL),
('ORD002', 'john.smith@gmail.com', 1007, '2023-08-15', '2023-08-20', 100.00, 20.00, 'processing', NULL),
('ORD003',  'jdoe@gmail.com', 1009, '2023-05-12', '2023-05-18', 120.00, 25.00, 'completed', 4),
('ORD004', 'linda.lee@gmail.com', 1008, '2023-07-21', '2023-07-24', 80.00, 15.00, 'processing', NULL),
('ORD005', 'michael.kim@outlook.com', 1001, '2023-04-08', '2023-04-10', 90.00, 20.00, 'wait to comfired', NULL),
('ORD006', 'michael.kim@outlook.com', 1005, '2023-10-02', '2023-10-08', 110.00, 30.00, 'processing', NULL),
('ORD007', 'michael.kim@outlook.com', 1006, '2023-11-20', '2023-11-25', 100.00, 25.00, 'processing', NULL),
('ORD008', 'linda.lee@gmail.com', 1010, '2023-09-12', '2023-09-15', 70.00, 20.00, 'cencaled', NULL),
('ORD009', 'emily.chen@gmail.com', 1002, '2023-12-18', '2023-12-24', 130.00, 35.00, 'wait to comfired', NULL),
('ORD010', 'dkim@outlook.com', 1003, '2023-08-01', '2023-08-06', 95.00, 20.00, 'completed', NULL);

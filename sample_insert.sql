INSERT INTO tenants (id, name, email, phone, gender, language_code) VALUES
  (1001, 'John Smith', 'john.smith@gmail.com', '555-1234', 'Not to tell', 'EN'),
  (1002, 'Mary Johnson', 'mary.johnson@outlook.com', '555-5678', 'Not to tell', 'FR'),
  (1003, 'John Doe', 'jdoe@gmail.com', '555-2345', 'Not to tell', 'ZH'),
  (1004, 'Linda Lee', 'linda.lee@gmail.com', '555-6789', 'Female', 'EL'),
  (1005, 'Michael Kim', 'michael.kim@outlook.com', '555-3456', 'Male', 'JA'),
  (1006, 'Emily Chen', 'emily.chen@gmail.com', '555-7890', 'Female', 'EN'),
  (1007, 'John Lee', 'jlee@NEU.edu', '555-4321', 'Others', 'ZH'),
  (1008, 'Emily Chen', 'emily.chen@outlook.com', '555-8765', 'Female', 'FR'),
  (1009, 'Mary Johnson', 'mjohnson@NEU.edu', '555-2198', 'Others', 'EL'),
  (1010, 'David Kim', 'dkim@outlook.com', '555-7654', 'Male', 'JA');

INSERT INTO hosts (id, host_name, email, phone, gender, language_code) VALUES 
(1001, 'John Smith', 'john.smith@gmail.com', '555-555-1234', 'Male', 'en'),
(1002, 'Mary Johnson', 'mary.johnson@yahoo.com', '555-555-5678', 'Female', 'en'),
(1003, 'David Lee', 'david.lee@hotmail.com', NULL, 'Male', 'ko'),
(1004, 'Anna Garcia', 'anna.garcia@gmail.com', '555-555-2345', 'Female', 'es'),
(1005, 'Mohammed Ahmed', 'mohammed.ahmed@yahoo.com', '555-555-6789', 'Male', 'ar'),
(1006, 'Lena Nguyen', 'lena.nguyen@gmail.com', NULL, 'Female', 'vi'),
(1007, 'Javier Hernandez', 'javier.hernandez@yahoo.com', '555-555-3456', 'Male', 'es'),
(1008, 'Sara Kim', 'sara.kim@hotmail.com', '555-555-7890', 'Female', 'ko'),
(1009, 'Ahmed Hassan', 'ahmed.hassan@gmail.com', '555-555-4567', 'Male', 'ar'),
(1010, 'Jasmine Wong', 'jasmine.wong@yahoo.com', '555-555-8901', 'Female', 'zh');


INSERT INTO airbnbs (house_id, host_id, title, city_id, address, num_of_rooms, num_of_beds, num_parking, average_rating, rating_times, description, current_price, current_cleaning_fee) 
VALUES 
(1001, 1001, 'Cozy Apartment in the Heart of the City', 1276974738, '123 Main St.', 2, 1, 1, 2.2, 10, 'This charming apartment is located in the heart of the city and is perfect for a romantic getaway or a small family vacation.', 80.00, 10.00),
(1002, 1002, 'Spacious Loft with Stunning City Views', 1076094869, '456 Elm St.', 1, 2, 0, 1.6, 5, 'Experience urban living at its finest in this spacious loft with breathtaking city views.', 120.00, 15.00),
(1003, 1003, 'Luxury Condo with Pool and Gym Access', 1752708772, '789 Oak St.', 3, 3, 2, 3.0, 15, 'Treat yourself to the ultimate luxury experience in this beautiful condo with access to a pool and gym.', 250.00, 20.00),
(1004, 1004, 'Coastal Cottage with Ocean Views', 1218680506, '321 Beach Rd.', 2, 2, 1, 4.7, 8, 'Escape to the coast and enjoy breathtaking ocean views from this charming cottage.', 150.00, 15.00),
(1005, 1005, 'Historic Home with Modern Amenities', 1356213628, '987 Main St.', 4, 3, 2, 4.3, 12, 'Experience the best of both worlds in this beautifully restored historic home with all the modern amenities you need for a comfortable stay.', 200.00, 20.00),
(1006, 1006, 'Charming Bungalow in a Quiet Neighborhood', 1250008059, '567 Maple St.', 2, 1, 1, 5, 6, 'This charming bungalow is the perfect place to relax and unwind in a quiet neighborhood.', 100.00, 10.00),
(1007, 1007, 'Stylish Studio Apartment in Downtown', 1380805860, '246 Market St.', 1, 1, 0, 3.5, 7, 'Experience city living in style in this modern and chic studio apartment located in the heart of downtown.', 90.00, 10.00),
(1008, 1008, 'Spacious Townhouse with Private Patio', 1840010109, '789 Oak St.', 3, 3, 1, 3.2, 10, 'This spacious townhouse with a private patio is the perfect home away from home for your next family vacation.', 180.00, 20.00),
(1009, 1009, 'Modern Apartment with Stunning Views', 1036216956, '357 Hilltop Rd.', 1, 2, 1, 4.7, 4, 'Enjoy breathtaking views from this modern and stylish apartment located on a hilltop.', 120.00, 15.00),
(1010, 1010, 'Beautifully Furnished Apartment in the City', 1840019682, '123 Main St.', 2, 2, 1, 3.8, 9, 'This beautifully furnished apartment is located in the heart of the city and is perfect for a comfortable and convenient stay.', 80.00, 15.00);


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

INSERT INTO orders (order_num, tenante, house_id, check_in_date, check_out_date, price_per_day, cleaning_fee, states) VALUES
('ORD001', 1001, 1003, '2023-06-01', '2023-06-07', 150.00, 30.00, 'wait to comfired'),
('ORD002', 1001, 1007, '2023-08-15', '2023-08-20', 100.00, 20.00, 'processing'),
('ORD003', 1003, 1009, '2023-05-12', '2023-05-18', 120.00, 25.00, 'completed'),
('ORD004', 1004, 1008, '2023-07-21', '2023-07-24', 80.00, 15.00, 'processing'),
('ORD005', 1005, 1001, '2023-04-08', '2023-04-10', 90.00, 20.00, 'wait to comfired'),
('ORD006', 1005, 1005, '2023-10-02', '2023-10-08', 110.00, 30.00, 'processing'),
('ORD007', 1005, 1006, '2023-11-20', '2023-11-25', 100.00, 25.00, 'processing'),
('ORD008', 1004, 1010, '2023-09-12', '2023-09-15', 70.00, 20.00, 'cencaled'),
('ORD009', 1006, 1002, '2023-12-18', '2023-12-24', 130.00, 35.00, 'wait to comfired'),
('ORD010', 1010, 1003, '2023-08-01', '2023-08-06', 95.00, 20.00, 'completed');

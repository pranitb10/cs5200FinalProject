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


INSERT INTO airbnbs (house_id, host_id, title, city_id, address, num_of_rooms, num_of_beds, num_parking, average_rating, rating_times, description) VALUES 
(1, 1001, 'Cozy Apartment in the Heart of the City', 1276974738, '123 Main St.', 2, 1, 1, 2.2, 10, 'This charming apartment is located in the heart of the city and is perfect for a romantic getaway or a small family vacation.'),
(2, 1002, 'Spacious Loft with Stunning City Views', 1076094869, '456 Elm St.', 1, 2, 0, 1.6, 5, 'Experience urban living at its finest in this spacious loft with breathtaking city views.'),
(3, 1003, 'Luxury Condo with Pool and Gym Access', 1752708772, '789 Oak St.', 3, 3, 2, 3.0, 15, 'Treat yourself to the ultimate luxury experience in this beautiful condo with access to a pool and gym.'),
(4, 1004, 'Coastal Cottage with Ocean Views', 1218680506, '321 Beach Rd.', 2, 2, 1, 4.7, 8, 'Escape to the coast and enjoy breathtaking ocean views from this charming cottage.'),
(5, 1005, 'Historic Home with Modern Amenities', 1356213628, '987 Main St.', 4, 3, 2, 4.3, 12, 'Experience the best of both worlds in this beautifully restored historic home with all the modern amenities you need for a comfortable stay.'),
(6, 1006, 'Charming Bungalow in a Quiet Neighborhood', 1250008059, '567 Maple St.', 2, 1, 1, 5, 6, 'This charming bungalow is the perfect place to relax and unwind in a quiet neighborhood.'),
(7, 1007, 'Stylish Studio Apartment in Downtown', 1380805860, '246 Market St.', 1, 1, 0, 3.5, 7, 'Experience city living in style in this modern and chic studio apartment located in the heart of downtown.'),
(8, 1008, 'Spacious Townhouse with Private Patio', 1840010109, '789 Oak St.', 3, 3, 1, 3.2, 10, 'This spacious townhouse with a private patio is the perfect home away from home for your next family vacation.'),
(9, 1009, 'Modern Apartment with Stunning Views', 1036216956, '357 Hilltop Rd.', 1, 2, 1, 4.7, 4, 'Enjoy breathtaking views from this modern and stylish apartment located on a hilltop.'),
(10, 1010, 'Beautifully Furnished Apartment in the City', 1840019682, '123 Main St.', 2, 2, 1, 3.8, 9, 'This beautifully furnished apartment is located in the heart of the city and is perfect for a comfortable and convenient stay.');


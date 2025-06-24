-- Renableing foreign key checks after schema creation
SET FOREIGN_KEY_CHECKS = 1;


-- Data for table `User`

INSERT INTO User (Email, FullName, RegistrationDate, LastLogin) VALUES
('alice@example.com', 'Alice Smith', '2023-01-15', '2025-06-20 10:00:00'),
('bob@example.com', 'Bob Johnson', '2022-03-20', '2025-06-19 15:30:00'),
('charlie@example.com', 'Charlie Brown', '2023-05-10', '2025-06-18 09:15:00'),
('diana@example.com', 'Diana Prince', '2021-11-01', '2025-03-01 11:45:00'), -- Inactive user
('eve@example.com', 'Eve Adams', '2024-02-28', '2025-06-21 14:00:00'),
('frank@example.com', 'Frank White', '2023-08-05', '2025-06-17 18:00:00'),
('grace@example.com', 'Grace Lee', '2022-06-12', '2025-02-01 08:30:00'), -- Inactive user
('heidi@example.com', 'Heidi Miller', '2024-01-01', '2025-06-22 20:00:00'),
('ivan@example.com', 'Ivan Petrov', '2023-04-03', '2025-06-16 12:00:00'),
('judy@example.com', 'Judy Garland', '2022-09-25', '2025-02-10 09:00:00'); -- Inactive user


-- Data for table `Destination`

INSERT INTO Destination (Name, Description, Availability, DestinationType, Pricing, DateAdded, Region) VALUES
('Eiffel Tower', 'Iconic wrought-iron lattice tower in Paris.', 'Year-round', 'Attraction', 25.00, '2023-01-01', 'Europe'),
('Grand Hyatt', 'Luxury hotel in New York City.', 'Year-round', 'Hotel', 350.00, '2023-02-15', 'North America'),
('Kyoto Temple', 'Historic Buddhist temple in Kyoto.', 'Year-round', 'Attraction', 10.00, '2023-03-20', 'Asia'),
('Santorini', 'Beautiful island in Greece with stunning sunsets.', 'Seasonal', 'City', 120.00, '2025-04-10', 'Europe'), -- Made recent
('Amazon Rainforest', 'Vast rainforest in South America, rich in biodiversity.', 'Year-round', 'Nature', 500.00, '2023-05-01', 'South America'),
('Burj Khalifa', 'Tallest building in the world, located in Dubai.', 'Year-round', 'Attraction', 40.00, '2025-05-25', 'Middle East'), -- Made recent
('Swiss Alps', 'Majestic mountain range in Switzerland, popular for skiing.', 'Seasonal', 'Nature', 180.00, '2023-06-18', 'Europe'),
('Tokyo Skytree', 'Broadcasting and observation tower in Tokyo.', 'Year-round', 'Attraction', 28.00, '2025-06-01', 'Asia'), -- Made recent
('Great Barrier Reef', 'World\'s largest coral reef system, off the coast of Queensland, Australia.', 'Year-round', 'Nature', 200.00, '2023-07-30', 'Oceania'),
('Colosseum', 'Ancient amphitheatre in Rome, Italy.', 'Year-round', 'Attraction', 16.00, '2025-06-15', 'Europe'); -- Made recent


-- Data for table `Preference`

INSERT INTO Preference (Category, Region) VALUES
('Adventure', 'Europe'),
('Relaxation', 'Asia'),
('Cultural', 'Europe'),
('Nature', 'South America'),
('Luxury', 'Middle East'),
('City Break', 'North America'),
('Adventure', 'Oceania'),
('Relaxation', 'Europe'),
('Cultural', 'Asia'),
('Nature', 'Europe');


-- Data for table `HasPreference`

INSERT INTO HasPreference (UserEmail, PreferenceCategory, PreferenceRegion) VALUES
('alice@example.com', 'Adventure', 'Europe'),
('bob@example.com', 'Relaxation', 'Asia'),
('charlie@example.com', 'Cultural', 'Europe'),
('diana@example.com', 'Nature', 'South America'),
('eve@example.com', 'Luxury', 'Middle East'), -- Matches recent Burj Khalifa
('frank@example.com', 'City Break', 'North America'),
('grace@example.com', 'Adventure', 'Oceania'),
('heidi@example.com', 'Relaxation', 'Europe'), -- Matches recent Santorini, Colosseum
('ivan@example.com', 'Cultural', 'Asia'), -- Matches recent Tokyo Skytree
('judy@example.com', 'Nature', 'Europe'),
('alice@example.com', 'City Break', 'North America'); -- Additional preference for Alice


-- Data for table `Review`

INSERT INTO Review (UserEmail, DestinationName, DestinationType, Rating, ReviewText, DateOfVisit, ExperienceType, Recommendation) VALUES
('alice@example.com', 'Eiffel Tower', 'Attraction', 5, 'Absolutely breathtaking!', '2025-05-01', 'Romantic', 'Highly recommend for couples.'),
('bob@example.com', 'Kyoto Temple', 'Attraction', 4, 'Peaceful and beautiful.', '2025-04-10', 'Solo', 'Great for quiet reflection.'),
('charlie@example.com', 'Grand Hyatt', 'Hotel', 3, 'Decent stay, but a bit pricey.', '2025-03-05', 'Business', 'Good for business travelers.'),
('alice@example.com', 'Santorini', 'City', 5, 'The best sunsets I have ever seen!', '2025-05-15', 'Romantic', 'A must-visit for honeymooners.'),
('eve@example.com', 'Burj Khalifa', 'Attraction', 4, 'Amazing views from the top.', '2025-06-01', 'Family', 'Worth the ticket price.'),
('frank@example.com', 'Swiss Alps', 'Nature', 5, 'Stunning scenery and great hiking.', '2025-06-10', 'Solo', 'Perfect for nature lovers.'),
('heidi@example.com', 'Tokyo Skytree', 'Attraction', 4, 'Impressive structure, great city views.', '2025-06-05', 'Family', 'Good for a family outing.'),
('ivan@example.com', 'Great Barrier Reef', 'Nature', 5, 'Unforgettable diving experience!', '2025-05-20', 'Adventure', 'A true wonder of the world.'),
('diana@example.com', 'Eiffel Tower', 'Attraction', 3, 'Too crowded for my taste.', '2024-10-20', 'Solo', 'Visit early in the morning.'),
('judy@example.com', 'Colosseum', 'Attraction', 5, 'Incredible history and architecture.', '2025-01-05', 'Cultural', 'Essential for history buffs.'),
('bob@example.com', 'Burj Khalifa', 'Attraction', 5, 'Absolutely stunning!', '2025-05-31', 'Solo', 'A must-see!'); -- Added for similar user recommendation


-- Data for table `Itinerary`

INSERT INTO Itinerary (ItineraryName, UserEmail, Title, IsPublic) VALUES
('Paris Adventure', 'alice@example.com', 'My Dream Trip to Paris', TRUE),
('Japan Culture Tour', 'bob@example.com', 'Exploring Ancient Japan', FALSE),
('NYC Business Trip', 'charlie@example.com', 'Business & Leisure in NYC', FALSE),
('Greece Honeymoon', 'alice@example.com', 'Romantic Getaway to Greece', TRUE),
('Dubai Extravaganza', 'eve@example.com', 'Luxury Tour of Dubai', TRUE),
('Swiss Alps Hiking', 'frank@example.com', 'High Altitude Adventures', FALSE),
('Tokyo Delights', 'heidi@example.com', 'A Week in Tokyo', TRUE),
('Australia Dive', 'ivan@example.com', 'Underwater Wonders of Australia', TRUE),
('Rome History', 'judy@example.com', 'Ancient Rome Exploration', TRUE),
('Amazon Discovery', 'diana@example.com', 'Wildlife Expedition', FALSE);


-- Data for table `IncludesDestinationType`

INSERT INTO IncludesDestinationType (ItineraryName, UserEmail, DestinationName, DestinationType) VALUES
('Paris Adventure', 'alice@example.com', 'Eiffel Tower', 'Attraction'),
('Japan Culture Tour', 'bob@example.com', 'Kyoto Temple', 'Attraction'),
('NYC Business Trip', 'charlie@example.com', 'Grand Hyatt', 'Hotel'),
('Greece Honeymoon', 'alice@example.com', 'Santorini', 'City'),
('Dubai Extravaganza', 'eve@example.com', 'Burj Khalifa', 'Attraction'),
('Swiss Alps Hiking', 'frank@example.com', 'Swiss Alps', 'Nature'),
('Tokyo Delights', 'heidi@example.com', 'Tokyo Skytree', 'Attraction'),
('Australia Dive', 'ivan@example.com', 'Great Barrier Reef', 'Nature'),
('Rome History', 'judy@example.com', 'Colosseum', 'Attraction'),
('Amazon Discovery', 'diana@example.com', 'Amazon Rainforest', 'Nature');


-- Data for table `VisitedDestination`

INSERT INTO VisitedDestination (UserEmail, DestinationName, DestinationType, DateOfVisit) VALUES
('alice@example.com', 'Eiffel Tower', 'Attraction', '2025-05-01'),
('bob@example.com', 'Kyoto Temple', 'Attraction', '2025-04-10'),
('charlie@example.com', 'Grand Hyatt', 'Hotel', '2025-03-05'),
('alice@example.com', 'Santorini', 'City', '2025-05-15'),
('eve@example.com', 'Burj Khalifa', 'Attraction', '2025-06-01'),
('frank@example.com', 'Swiss Alps', 'Nature', '2025-06-10'),
('heidi@example.com', 'Tokyo Skytree', 'Attraction', '2025-06-05'),
('ivan@example.com', 'Great Barrier Reef', 'Nature', '2025-05-20'),
('diana@example.com', 'Eiffel Tower', 'Attraction', '2024-10-20'),
('judy@example.com', 'Colosseum', 'Attraction', '2025-01-05'),
('bob@example.com', 'Eiffel Tower', 'Attraction', '2025-05-05'), -- Added for similar user recommendation
('bob@example.com', 'Burj Khalifa', 'Attraction', '2025-05-30'); -- Added for similar user recommendation


-- Data for table `ItineraryItem`

INSERT INTO ItineraryItem (ItineraryName, UserEmail, ItemID, ItemType, VisitDate) VALUES
('Paris Adventure', 'alice@example.com', 1, 'Flight', '2025-04-30'),
('Paris Adventure', 'alice@example.com', 2, 'Accommodation', '2025-05-01'),
('Japan Culture Tour', 'bob@example.com', 3, 'Activity', '2025-04-11'),
('NYC Business Trip', 'charlie@example.com', 4, 'Flight', '2025-03-04'),
('Greece Honeymoon', 'alice@example.com', 5, 'Accommodation', '2025-05-15'),
('Dubai Extravaganza', 'eve@example.com', 6, 'Activity', '2025-06-02'),
('Swiss Alps Hiking', 'frank@example.com', 7, 'Activity', '2025-06-11'),
('Tokyo Delights', 'heidi@example.com', 8, 'Transportation', '2025-06-06'),
('Australia Dive', 'ivan@example.com', 9, 'Accommodation', '2025-05-19'),
('Rome History', 'judy@example.com', 10, 'Activity', '2025-01-06');
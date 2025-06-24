use abeer;

SET FOREIGN_KEY_CHECKS = 0;

-- Droping tables if they already exist to ensure a clean slate for schema creation
DROP TABLE IF EXISTS ItineraryItem;
DROP TABLE IF EXISTS VisitedDestination;
DROP TABLE IF EXISTS IncludesDestinationType;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS HasPreference;
DROP TABLE IF EXISTS Itinerary;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Destination;
DROP TABLE IF EXISTS Preference;


-
-- This table stores information about the users of the platform.
CREATE TABLE User (
    Email VARCHAR(150) NOT NULL PRIMARY KEY, -- User's email, used as primary key. Reduced length to avoid key length issues.
    FullName VARCHAR(255) NOT NULL,         -- User's full name
    RegistrationDate DATE NOT NULL,         -- Date when the user registered
    LastLogin DATETIME                      -- Timestamp of the user's last login
);


-- This table stores information about various travel destinations, accommodations, and attractions.
CREATE TABLE Destination (
    Name VARCHAR(100) NOT NULL,             -- Name of the destination/accommodation/attraction. Reduced length.
    Description TEXT,                       -- Detailed description of the destination
    Availability VARCHAR(255),              -- Availability information (e.g., "Year-round", "Seasonal")
    DestinationType VARCHAR(100) NOT NULL,  -- Type of destination (e.g., "Hotel", "Attraction", "City"). Reduced length.
    Pricing DECIMAL(10, 2),                 -- Average pricing for the destination
    DateAdded DATE NOT NULL,                -- Date when the destination was added to the platform
    Region VARCHAR(100),                    -- Geographical region of the destination. Reduced length.
    PRIMARY KEY (Name, DestinationType)     -- Composite primary key to uniquely identify destinations
);


-- This table stores user preferences for travel categories and regions.
CREATE TABLE Preference (
    Category VARCHAR(100) NOT NULL,        -- Preferred travel category (e.g., "Adventure", "Relaxation"). Reduced length.
    Region VARCHAR(100) NOT NULL,          -- Preferred geographical region. Reduced length.
    PRIMARY KEY (Category, Region)         -- Composite primary key for unique preferences
);


-- This table links users to their preferences, representing a many-to-many relationship.
CREATE TABLE HasPreference (
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing User.Email. Length adjusted to match User.Email.
    PreferenceCategory VARCHAR(100) NOT NULL, -- Foreign key referencing Preference.Category. Length adjusted.
    PreferenceRegion VARCHAR(100) NOT NULL,   -- Foreign key referencing Preference.Region. Length adjusted.
    PRIMARY KEY (UserEmail, PreferenceCategory, PreferenceRegion), -- Composite primary key
    FOREIGN KEY (UserEmail) REFERENCES User(Email) ON DELETE CASCADE,
    FOREIGN KEY (PreferenceCategory, PreferenceRegion) REFERENCES Preference(Category, Region) ON DELETE CASCADE
);


-- This table stores user-submitted reviews for destinations.
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each review
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing User.Email (who wrote the review). Length adjusted.
    DestinationName VARCHAR(100) NOT NULL, -- Foreign key referencing Destination.Name (what was reviewed). Length adjusted.
    DestinationType VARCHAR(100) NOT NULL, -- Foreign key referencing Destination.DestinationType. Length adjusted.
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 5), -- Rating from 1 to 5
    ReviewText TEXT,                        -- The actual text of the review
    DateOfVisit DATE NOT NULL,              -- Date when the user visited the place
    ExperienceType VARCHAR(255),            -- Type of experience (e.g., "Solo", "Family", "Romantic")
    Recommendation TEXT,                    -- User's recommendation text
    FOREIGN KEY (UserEmail) REFERENCES User(Email) ON DELETE CASCADE,
    FOREIGN KEY (DestinationName, DestinationType) REFERENCES Destination(Name, DestinationType) ON DELETE CASCADE
);


-- This table stores user-created travel itineraries.
CREATE TABLE Itinerary (
    ItineraryName VARCHAR(100) NOT NULL,    -- Name of the itinerary, part of primary key. Reduced length.
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing User.Email (who created it). Length adjusted.
    Title VARCHAR(255) NOT NULL,            -- Title of the itinerary
    IsPublic BOOLEAN NOT NULL,              -- Whether the itinerary is public or private
    PRIMARY KEY (ItineraryName, UserEmail), -- Composite primary key for unique itineraries
    FOREIGN KEY (UserEmail) REFERENCES User(Email) ON DELETE CASCADE
);


-- This table represents the relationship between an Itinerary and the types of Destinations it includes.
CREATE TABLE IncludesDestinationType (
    ItineraryName VARCHAR(100) NOT NULL,    -- Foreign key referencing Itinerary.ItineraryName. Reduced length.
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing Itinerary.UserEmail. Reduced length.
    DestinationName VARCHAR(100) NOT NULL,  -- Foreign key referencing Destination.Name. Reduced length.
    DestinationType VARCHAR(100) NOT NULL,  -- Foreign key referencing Destination.DestinationType. Reduced length.
    PRIMARY KEY (ItineraryName, UserEmail, DestinationName, DestinationType), -- Composite primary key
    FOREIGN KEY (ItineraryName, UserEmail) REFERENCES Itinerary(ItineraryName, UserEmail) ON DELETE CASCADE,
    FOREIGN KEY (DestinationName, DestinationType) REFERENCES Destination(Name, DestinationType) ON DELETE CASCADE
);


-- This table tracks which destinations a user has visited.
CREATE TABLE VisitedDestination (
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing User.Email. Reduced length.
    DestinationName VARCHAR(100) NOT NULL,  -- Foreign key referencing Destination.Name. Reduced length.
    DestinationType VARCHAR(100) NOT NULL,  -- Foreign key referencing Destination.DestinationType. Reduced length.
    DateOfVisit DATE NOT NULL,              -- Date when the user visited this specific destination
    PRIMARY KEY (UserEmail, DestinationName, DestinationType), -- Composite primary key
    FOREIGN KEY (UserEmail) REFERENCES User(Email) ON DELETE CASCADE,
    FOREIGN KEY (DestinationName, DestinationType) REFERENCES Destination(Name, DestinationType) ON DELETE CASCADE
);


-- This table details individual items within an itinerary.
CREATE TABLE ItineraryItem (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each itinerary item
    ItineraryName VARCHAR(100) NOT NULL,    -- Foreign key referencing Itinerary.ItineraryName. Reduced length.
    UserEmail VARCHAR(150) NOT NULL,       -- Foreign key referencing Itinerary.UserEmail. Reduced length.
    ItemType VARCHAR(255) NOT NULL,         -- Type of item (e.g., "Flight", "Accommodation", "Activity")
    VisitDate DATE NOT NULL,                -- Date planned for this item in the itinerary
    FOREIGN KEY (ItineraryName, UserEmail) REFERENCES Itinerary(ItineraryName, UserEmail) ON DELETE CASCADE
);

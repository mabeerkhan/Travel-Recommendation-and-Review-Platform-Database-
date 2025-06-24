SELECT
    D.Name AS TrendingLocation,
    D.DestinationType AS LocationType,
    D.Region,
    COUNT(DISTINCT CASE WHEN R.Rating >= 4 THEN R.UserEmail END) AS NumberOfUsersWhoRatedHighly,
    AVG(R.Rating) AS AverageRating,
    COUNT(DISTINCT CASE WHEN R.DateOfVisit >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) THEN R.UserEmail END) AS NumberOfRecentReviews
FROM
    Destination AS D
JOIN
    Review AS R ON D.Name = R.DestinationName AND D.DestinationType = R.DestinationType
WHERE
    D.DestinationType IN ('Attraction', 'City', 'Nature') -- Included common destination types for trending
GROUP BY
    D.Name, D.DestinationType, D.Region
HAVING
    NumberOfUsersWhoRatedHighly >= 1 -- At least one user has rated it highly
    AND NumberOfRecentReviews >= 1   -- At least one user has reviewed it recently within the last 6 months
ORDER BY
    NumberOfRecentReviews DESC, AverageRating DESC;
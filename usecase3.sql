SELECT
    U.FullName AS InactiveUser,
    U.Email AS UserEmail,
    U.LastLogin,
    'Last Review' AS ActivityType,
    R.DestinationName AS ActivityDetail,
    R.DateOfVisit AS ActivityDate
FROM
    User AS U
LEFT JOIN
    Review AS R ON U.Email = R.UserEmail
WHERE
    U.LastLogin <= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) OR U.LastLogin IS NULL
GROUP BY
    U.Email, U.FullName, U.LastLogin, ActivityType, ActivityDetail, ActivityDate -- Grouping for MAX(R.DateOfVisit)
HAVING
    R.DateOfVisit = (SELECT MAX(R2.DateOfVisit) FROM Review R2 WHERE R2.UserEmail = U.Email) OR R.DateOfVisit IS NULL -- Get most recent review if exists
UNION
SELECT
    U.FullName AS InactiveUser,
    U.Email AS UserEmail,
    U.LastLogin,
    'Last Visited Destination' AS ActivityType,
    VD.DestinationName AS ActivityDetail,
    VD.DateOfVisit AS ActivityDate
FROM
    User AS U
LEFT JOIN
    VisitedDestination AS VD ON U.Email = VD.UserEmail
WHERE
    U.LastLogin <= DATE_SUB(CURDATE(), INTERVAL 3 MONTH) OR U.LastLogin IS NULL
GROUP BY
    U.Email, U.FullName, U.LastLogin, ActivityType, ActivityDetail, ActivityDate -- Grouping for MAX(VD.DateOfVisit)
HAVING
    VD.DateOfVisit = (SELECT MAX(VD2.DateOfVisit) FROM VisitedDestination VD2 WHERE VD2.UserEmail = U.Email) OR VD.DateOfVisit IS NULL
ORDER BY
    InactiveUser, ActivityDate DESC;

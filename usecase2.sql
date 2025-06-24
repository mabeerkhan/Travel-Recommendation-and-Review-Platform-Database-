SELECT
    U.FullName AS UserName,
    U.Email AS UserEmail,
    P.Category AS PreferredCategory,
    P.Region AS PreferredRegion,
    D.Name AS NewDestinationName,
    D.DestinationType,
    D.DateAdded,
    D.Description
FROM
    User AS U
JOIN
    HasPreference AS HP ON U.Email = HP.UserEmail
JOIN
    Preference AS P ON HP.PreferenceCategory = P.Category AND HP.PreferenceRegion = P.Region
JOIN
    Destination AS D ON (D.Region = P.Region OR D.DestinationType = P.Category) -- Consider destinations in preferred region OR category
WHERE
    D.DateAdded >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
ORDER BY
    U.FullName, D.DateAdded DESC;
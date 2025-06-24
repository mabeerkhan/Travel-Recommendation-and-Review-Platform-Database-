SELECT
    U.FullName AS UserName,
    R.UserEmail,
    R.DestinationName,
    R.DestinationType,
    R.Rating,
    R.ReviewText
FROM
    Review AS R
JOIN
    User AS U ON R.UserEmail = U.Email
WHERE
    R.Rating >= 4
ORDER BY
    U.FullName, R.Rating DESC;
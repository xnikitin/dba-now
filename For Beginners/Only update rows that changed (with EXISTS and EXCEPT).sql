--get all records in #Customer which do not have matching records in #Updates
SELECT *
FROM #Customer c
    JOIN #Updates u ON u.CustomerID = c.CustomerID
WHERE EXISTS (
    SELECT c.FirstName, c.MiddleName, c.LastName, c.DateOfBirth
    EXCEPT
    SELECT u.FirstName, u.MiddleName, u.LastName, u.DateOfBirth
)

--UPDATE
UPDATE c
    SET c.FirstName   = u.FirstName,
        c.MiddleName  = u.MiddleName,
        c.LastName    = u.LastName,
        c.DateOfBirth = u.DateOfBirth
FROM #Customer c
    JOIN #Updates u ON u.CustomerID = c.CustomerID
WHERE EXISTS (
    SELECT c.FirstName, c.MiddleName, c.LastName, c.DateOfBirth
    EXCEPT
    SELECT u.FirstName, u.MiddleName, u.LastName, u.DateOfBirth
)

--MERGE
MERGE INTO #Customer c
USING #Updates u ON u.CustomerID = c.CustomerID
WHEN MATCHED AND EXISTS (
                    SELECT c.FirstName, c.MiddleName, c.LastName, c.DateOfBirth
                    EXCEPT
                    SELECT u.FirstName, u.MiddleName, u.LastName, u.DateOfBirth
                )
THEN
    UPDATE SET c.FirstName    = u.FirstName,
                c.MiddleName  = u.MiddleName,
                c.LastName    = u.LastName,
                c.DateOfBirth = u.DateOfBirth
WHEN NOT MATCHED BY TARGET
THEN
    INSERT (CustomerID, FirstName, MiddleName, LastName, DateOfBirth)
    VALUES (u.CustomerID, u.FirstName, u.MiddleName, u.LastName, u.DateOfBirth)
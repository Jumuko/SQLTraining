
CREATE TABLE ProductDimension (
    ProductID INT,
    ProductName NVARCHAR(100),
    Price DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE,
    IsCurrent CHAR(1), -- 'Y' for current, 'N' for historical
    PRIMARY KEY (ProductID, StartDate)
);
CREATE TABLE ProductSource (
    ProductID INT,
    ProductName NVARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO ProductDimension (ProductID, ProductName, Price, StartDate, EndDate, IsCurrent)
VALUES
(1, 'Widget A', 10.00, '2023-01-01', NULL, 'Y'), -- Current record
(2, 'Widget B Old', 15.00, '2023-01-01', NULL, 'Y'), -- Current record
(3, 'Widget C', 30.00, '2023-01-01', '2024-01-01', 'N'); -- Historical record

INSERT INTO ProductSource (ProductID, ProductName, Price)
VALUES
(1, 'Widget A', 10.00), -- Same as current in ProductDimension
(2, 'Widget B', 20.00), -- Updated record
(3, 'Widget C', 30.00), -- No change, historical
(4, 'Widget D', 40.00); -- New record


SELECT * FROM ProductDimension
SELECT * FROM ProductSource

-- Step 1: Mark existing records as inactive if there are changes
UPDATE Target
SET EndDate = GETDATE(),
    IsCurrent = 'N'
FROM ProductDimension AS Target
INNER JOIN ProductSource AS Source
    ON Target.ProductID = Source.ProductID
WHERE Target.IsCurrent = 'Y'
  AND (
      Target.ProductName <> Source.ProductName
      OR Target.Price <> Source.Price
  );

-- Step 2: Insert new records for updated or new products
INSERT INTO ProductDimension (ProductID, ProductName, Price, StartDate, EndDate, IsCurrent)
SELECT 
    Source.ProductID,
    Source.ProductName,
    Source.Price,
    GETDATE() AS StartDate,
    NULL AS EndDate,
    'Y' AS IsCurrent
FROM ProductSource AS Source
LEFT JOIN ProductDimension AS Target
    ON Source.ProductID = Target.ProductID
    AND Target.IsCurrent = 'Y'
WHERE Target.ProductID IS NULL -- New Product
   OR Target.ProductName <> Source.ProductName
   OR Target.Price <> Source.Price; -- Updated Product


MERGE INTO ProductDimension AS Target
USING ProductSource AS Source
ON Target.ProductID = Source.ProductID AND Target.IsCurrent = 'Y'
WHEN MATCHED AND 
     (Target.ProductName <> Source.ProductName OR Target.Price <> Source.Price) THEN
    -- Update the current record to mark it as historical
    UPDATE SET 
        Target.EndDate = GETDATE(),
        Target.IsCurrent = 'N'
WHEN NOT MATCHED BY TARGET THEN
    -- Insert new records for new or updated data
    INSERT (ProductID, ProductName, Price, StartDate, EndDate, IsCurrent)
    VALUES (Source.ProductID, Source.ProductName, Source.Price, GETDATE(), NULL, 'Y')
OUTPUT $ACTION AS ActionTaken,
       INSERTED.ProductID AS InsertedID,
       INSERTED.ProductName AS InsertedName,
       INSERTED.Price AS InsertedPrice;

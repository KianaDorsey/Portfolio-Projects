*/
Source: https://www.kaggle.com/datasets/htagholdings/property-sales?select=raw_sales.csv
*/

Select *
From PortfolioProject..PropertySales

-- Removing the blank timestamp from the DateSold column
Select CONVERT(DATE, DateSold) AS DateSold
From PortfolioProject..PropertySales

-- Updating the table to reflect DateSold column as date only
ALTER TABLE PortfolioProject..PropertySales
ALTER COLUMN DateSold DATE;

-- Total Properties sold
Select APPROX_COUNT_DISTINCT(DateSold) AS TotalPropertiesSold
From PortfolioProject..PropertySales

-- Looking for Inappropiate values
Select DISTINCT PropertyType
From PortfolioProject..PropertySales

Select DISTINCT Bedrooms
From PortfolioProject..PropertySales

-- Some properties sold would be assumed as a Studio Home
Select DateSold, PropertyType, Bedrooms
From PortfolioProject..PropertySales
Where Bedrooms = 0

Select COUNT(*) AS StudioProperty
From PortfolioProject..PropertySales
Where Bedrooms = 0

-- DateSold with the Highest Number of Sales
Select TOP 1 DateSold AS Date, COUNT(*) AS TotalSales
From PortfolioProject..PropertySales
Group by DateSold
Order by TotalSales DESC

-- PostCode with the Highest Average Price per sale
Select TOP 1 Postcode, AVG(price) AS AvgPrice
From PortfolioProject..PropertySales
Group by Postcode
Order by AVG(price) DESC

-- Year with the lowest number of sales
SELECT TOP 1 YEAR(datesold) AS year, COUNT(*) AS TotalSales
FROM PortfolioProject..PropertySales
GROUP BY YEAR(datesold)
ORDER BY TotalSales ASC



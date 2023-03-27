*/
Global Mental Health Disorder Averages
*/

-- Displaying the entire table --

Select *
From PortfolioProject..MentalHealth

-- Query to find the total number of records in the dataset --
SELECT COUNT(*) AS Total_Records
FROM PortfolioProject..MentalHealth

-- Shows the Total Count for each Entity --
Select DISTINCT(Entity), COUNT(Entity) as TotalEntityCount
From PortfolioProject..MentalHealth
Group by Entity
Order by 1

-- Shows the AveragePercentage of each Mental Health Disorders prevalence grouped by Entity, rounded the nearest whole number --
Select Entity
, ROUND(AVG(Schizophrenia),0) as AvgPercentSchizophrenia
, ROUND(AVG([Bipolar disorder]),0) as AvgPercentBipolarDisorder
, ROUND(AVG([Eating disorders]),0) as AvgPercentEatingDisorder
, ROUND(AVG([Anxiety disorders]),0) as AvgPercentAnxietyDisorder
, ROUND(AVG([Drug use disorders]),0) as AvgPercentDrugUseDisorder
, ROUND(AVG([Depression]),0) as AvgPercentDepression
, ROUND(AVG([Alcohol use]),0) as AvgPercentAlcoholUse
From PortfolioProject..MentalHealth
Group by Entity
Order by 1

Select *
FROM [PortfolioProject].[dbo].[EarthquakeData]

 -- Reviewing missing data in Date_Time --
  Select DISTINCT date_time
  FROM [PortfolioProject].[dbo].[EarthquakeData]


  -- Removing NULLS from Date_Time to provide better analysis --
  UPDATE [PortfolioProject].[dbo].[EarthquakeData]
SET date_time = ''
WHERE date_time IS NULL


-- Reviewing the Earthquakes' Magnitude and Date_Time occured --
SELECT title, magnitude, date_time
FROM [PortfolioProject].[dbo].[EarthquakeData]


-- Viewing all Earthquakes with a magnitude greater than 7.0 --
SELECT title, magnitude
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE magnitude > 7.0
Order by magnitude DESC


-- Viewing all Earthquakes with a Tsunami alert --
SELECT *
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE tsunami = 1


-- Viewing all Earthquakes with an orange or red alert --
SELECT *
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE alert = 'orange' OR alert = 'red'

SELECT COUNT(*) as TotalRedAlerts
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE alert = 'red'


-- Avg Magnitude of Earthquakes in each Continent --
SELECT continent, AVG(magnitude) as AvgMagnitude
FROM [PortfolioProject].[dbo].[EarthquakeData]
Where continent IS NOT Null
GROUP BY continent


-- Showing the Top 10 Countries with the highest number of Earthquakes --
SELECT TOP 10 country, COUNT(*) as TotalEarthquakeCount
FROM [PortfolioProject].[dbo].[EarthquakeData]
Where country IS NOT NULL
GROUP BY country
ORDER BY COUNT(*) DESC


-- Viewing Earthquakes with NSI greater than 20 and MMI greater than 5 --
SELECT *
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE nst > 20 AND mmi > 5


-- Calculating the average Magnitude and maximum MMI for Earthquakes with an Alert level of orange/red, grouped by Continent and sorted by average Magnitude --
SELECT continent, AVG(magnitude) AS avg_magnitude, MAX(mmi) AS max_mmi
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE alert IN ('orange', 'red') AND continent IS NOT NULL
GROUP BY continent
ORDER BY avg_magnitude DESC


-- Calculating the average Depth and Magnitude of Earthquakes for each Country that has had at least 10 Earthquakes recorded
SELECT country, ROUND(AVG(depth), 2) AS avg_depth, ROUND(AVG(magnitude), 2) AS avg_magnitude
FROM [PortfolioProject].[dbo].[EarthquakeData]
WHERE country IN (SELECT country FROM [PortfolioProject].[dbo].[EarthquakeData]
                  GROUP BY country
                  HAVING COUNT(*) >= 10)
GROUP BY country











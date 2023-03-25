/*
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4


-- Select Data to explore

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order By 1,2


-- Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract Covid-19 in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
and continent is not null
Order By 1,2


-- Total Cases vs Population
-- Shows the percentage of population infected with Covid-19

Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Order By 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population
Order By PercentPopulationInfected desc


-- Countries with Highest Death Count per Population grouped by Location

Select Location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Location
Order By TotalDeathCount desc



-- BREAKING DATA DOWN BY CONTINENT --

-- Continents with Highest Death Count per Population grouped by Continent

Select continent, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
Order By TotalDeathCount desc



-- GLOBAL NUMBERS --

Select Date, SUM(new_cases) as TotalNewCases, SUM(new_deaths) as TotalNewDeaths, SUM(NULLIF(new_deaths,0))/SUM(NULLIF(new_cases,0))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null
Group by date
Order By 1,2


-- Total Population vs Vaccinations
-- Shows the Percentage of Population that has received at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.Location, dea.date)
as RollingPeopleVaccinated
, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3



-- USING CTE TO PERFORM CALCULATION ON PARTITION BY IN PREV QUERY --

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.Location, dea.date)
as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- CREATING TEMP TABLE TO PERFORM CALCULATION ON PARTITION BY IN PREV QUERY --

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert Into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.Location, dea.date)
as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS --

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.Location, dea.date)
as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

-- SHOWCASEING VIEW CREATED --

Select *
FROM PercentPopulationVaccinated

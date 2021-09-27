select location, date, total_cases, total_deaths, population
from CovidData.CovidDeaths
order by 1,2
 
-- Progressive Infection Rates (Likelihood of getting infected at a given period in each country)
select location, date, population, total_cases, (total_cases/population)*100 as Infection_Rate
from CovidData.CovidDeaths
where location like '%Nigeria%'
ORDER BY 1,2

--Progressive Death Rates (Livelihood of dying after infection at a given period in each country)
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Death_Rate
from CovidData.CovidDeaths
order by 1,2

--Country with Highest Infection Rate
select location, max((total_cases/population)*100) as Highest_Infection_Rates, max(population) as Population, max(total_cases) as Infections
from CovidData.CovidDeaths
group by location
order by Highest_Infection_Rates desc

--Country with Highest Death Rate
select location, max((total_deaths/total_cases)*100) as Highest_Death_Rates, max(total_cases) as Cases, max(total_deaths) as Deaths
from CovidData.CovidDeaths
group by location
order by Highest_Death_Rates desc

--Country with the Highest Death Count
select location, max(total_deaths) as Deaths, max(population) as Population
from CovidData.CovidDeaths 
where continent is null 
group by location
order by Deaths desc 

--Total Cases, Total Deaths and Overall Death Rates by country 2021-09-19
select location, sum(new_cases) as Total_Cases, sum(new_deaths) as Total_Deaths
from CovidData.CovidDeaths 
where continent is not null 
group by location
order by 2 desc

--Cases, Deaths, Tests and Vaccinations
select Deaths.location, Deaths.date, vacs.new_vaccinations
from CovidData.CovidDeaths Deaths
join CovidData.CovidVacs Vacs on Deaths.location = Vacs.location and Deaths.date = Vacs.date
where Deaths.continent is not null
order by 1,2

--Rolling Vaccinations
select Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vacs.new_vaccinations, sum(Vacs.new_vaccinations) over (PARTITION BY Deaths.location order by Deaths.location, Deaths.date) as Total_Vaccinated
from CovidData.CovidDeaths Deaths
join CovidData.CovidVacs Vacs on Deaths.location = Vacs.location and Deaths.date = Vacs.date 
where Deaths.continent is not null
order by 2,3

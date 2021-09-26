--Cases, Deaths, Tests and Vaccinations
select Deaths.location, Deaths.date, vacs.new_vaccinations
from CovidData.CovidDeaths Deaths
join CovidData.CovidVacs Vacs 
on Deaths.location = Vacs.location
and Deaths.date = Vacs.date
where Deaths.continent is not null
order by 1,2
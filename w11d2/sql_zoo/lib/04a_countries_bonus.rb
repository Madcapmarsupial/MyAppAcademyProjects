# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE countries.continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      a.continent,
      a.name,
      a.area
    FROM
      countries as a
    WHERE a.continent = continent
      AND a.area = (
        SELECT
          MAX(area)
        FROM
          countries
        WHERE
         a.continent = continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT DISTINCT
      name,
      continent
    FROM
      countries
    WHERE population / 3 > ALL (
      SELECT
        sub_countries.population
      FROM
        countries AS sub_countries
      WHERE countries.continent = sub_countries.continent
        AND countries.name <> sub_countries.name
    ) 
  SQL
end

-- Create Table indian_population with the columns below:
DROP TABLE IF EXISTS indian_population;
CREATE TABLE indian_population (
City TEXT PRIMARY KEY,
Population TEXT,
State TEXT
);

-- Create Table indian_pollution with the columns below:
DROP TABLE IF EXISTS indian_pollution;
CREATE TABLE indian_pollution (
State TEXT,
City TEXT PRIMARY KEY,
Average_ppb FLOAT
);

SELECT * FROM indian_pollution;
SELECT * FROM indian_population;


-- Create a join between indian_population and indian_pollution on "city" using the columns below:
SELECT indian_population.city, indian_population.population, indian_population.state, indian_pollution.average_ppb
FROM indian_population
JOIN indian_pollution ON
indian_population.city = indian_pollution.city;
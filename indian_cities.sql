DROP TABLE IF EXISTS indian_population;
CREATE TABLE indian_population (
City TEXT PRIMARY KEY,
Population TEXT,
State TEXT
);


DROP TABLE IF EXISTS indian_pollution;
CREATE TABLE indian_polluation (
State TEXT,
City TEXT PRIMARY KEY,
Average_ppb FLOAT
);

SELECT * FROM indian_population;
SELECT * FROM indian_pollution;

SELECT indian_population.city, indian_population.population, indian_population.state, indian_pollution.average_ppb
FROM indian_population
JOIN indian_pollution ON
indian_population.city = indian_pollution.city;
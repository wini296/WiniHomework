USE outbreak_db;

-- Query to check successful load
SELECT * FROM food_data;

SELECT * FROM temperature;

-- Join tables on yearmonth and state. Sum up the number of illnesses, hospitalizations and deaths.
SELECT 
    food_data.yearmonth,
    food_data.state,
    SUM(IFNULL(food_data.illnesses, 0)) AS total_illnesses,
    SUM(IFNULL(food_data.hospitalizations, 0)) AS total_hospitalizations,
    SUM(IFNULL(food_data.deaths, 0)) AS total_deaths,
    ANY_VALUE(temperature.average_temp) AS avg_temp
FROM
    food_data
        INNER JOIN
    temperature ON food_data.yearmonth = temperature.yearmonth
        AND food_data.state = temperature.state
GROUP BY food_data.yearmonth , food_data.state;

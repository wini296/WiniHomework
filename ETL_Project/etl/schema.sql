-- Drops the outbreak_db if it already exists --
DROP DATABASE IF EXISTS outbreak_db;
-- Create and use outbreak_db
CREATE DATABASE outbreak_db;
USE outbreak_db;

-- Create Two Tables
CREATE TABLE food_data (
    id INT(10) PRIMARY KEY NOT NULL,
    yearmonth DATE,
    state VARCHAR(50),
    genus_species VARCHAR(500),
    etiology_status VARCHAR(250),
    location_of_preparation VARCHAR(250),
    illnesses INT,
    hospitalizations INT,
    deaths INT,
    food_vehicle VARCHAR(500)
);


CREATE TABLE temperature (
    id INT(10) PRIMARY KEY NOT NULL,
    yearmonth DATE,
    state VARCHAR(50),
    average_temp FLOAT
);
    
    
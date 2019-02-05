# ETL_Project

Team: Wini, Muhlis, DG and Bharath


We prepared data to analyze average temperature with foodborne outbreaks across US. 



## **E**xtract

* We used two diferent datasets from [data.world](https://data.world/) and [Kaggle](https://www.kaggle.com/).

* One of the dataset was US foodborne outbreak database between 1998 to 2015 from United States Department of Agriculture. 

* Other dataset was historical monthly average temperature data from 1750 to 2013, for all states and countries across the world.  

* Both of our sources were flat files (CSV).

* We imported each CSV into pandas DataFrames.


## **T**ransform

* Used python libraries : pandas, numpy, datetime etc. to clean up raw data.

* Dropped some unrelated columns from our raw data. 

* Copied only the columns needed into a new DataFrame.

* Filtered data to include years 2007 to 2013 for US states only. 


## **L**oad

* We chose to load the data into MySQL database because it is easier to do complicated operations like filter, join, groupby etc.  compared to MongoDB

* Created schema in MySQL Workbench for the database and tables to be loaded. 

* Created a config file to store information like user name, password, port name etc. to import in notebook to connect to database.

* Used SQLAlchemy to connect to the database from notebook.

* Checked for a successful connection to the database and confirm that the tables have been created.

* Uploaded Dataframes to MySQL tables.

* Ran SQL queries in MySQL Workbench to check all rows of both tables loaded succesfully. 

* Also created a query to join tables on yearmonth and state columns to display : Average Temperature, Total number of illnesses, hospitalizations and deaths by states and months.


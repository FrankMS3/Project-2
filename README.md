# Project-2  
**Investigating Air Quality in Indian Cities**  
  
Before beginning, create a file named "config.py" within the main folder (the one "data_etl.ipynb" is located in). In this file, include your PostgreSQL username and password in the format:  
pg_username = "YOUR USERNAME HERE"  
pg_password = "YOUR PASSWORD HERE"  
  
To get started, create a database in PostgreSQL named "indian_cities_db". In this database, use the queries found in "indian_cities.sql" to create the necessary empty tables.  
Next, open and run the code within the file named "data_etl_.ipynb". This will load the .csv files located within the "Resources" folder into Pandas dataframes, clean and transform them, then connect to the "indian_cities_db" database and load the two cleaned datasets into their respective tables.  
Also included in both the "indian_cities.sql" and "data_etl.ipynb" files is a join statement, for joining the two tables.  
  
------------------------------------------------------------------------------  
  
# Proposal:  
  
**Background:**  
As the use of fossil fuels and petrol cars increases in our modern society, air quality is becoming more of a concern in daily life. With air pollution having links to numerous respiratory conditions, as well as causing strain to cardiovascular systems resulting in health problems after sustained exposure, we consider investigations into air quality of vital importance.  
  
Due to this, the dataset regarding air quality across Indian cities was of interest to us and warranted a closer look. India is often regarded as having poor air quality, ranking in the top 5 most polluted countries for 2021.  
  
For this project, we used two datasets taken from different authors on Kaggle: one regarding the air quality of Indian cities, and the second regarding background information for those cities, such as population in 2001 and 2011. Although the plan wasn't to use all the data contained in these files, it was more practical to have more data than we required and to decide what we would use once we were able to organise them further. From this, we aimed to look how each city compares in terms of air quality, as well as discover at potential causes for poor air quality.  
  
This project was achieved through the use of Jupyter notebooks, Pandas and PostgreSQL databases, as they seemed the most appropriate for transforming the data we found in the CSV files, which were then used to create a final relational database that was able to be moulded for our purposes.  
  
We set out to answer the following questions with our database:  
 	Does population affect pollution levels?  
	Are some states more affected by pollution than others?  
	If there is a correlation - which cities are the most populous and polluted, and the least populous and polluted?  
	If there isn't a correlation - what are the most and least polluted cities?  
  
**Findings:**  
Using the database we created, we found that the more populated a city was, the higher the average PPB (Parts Per Billion) of air pollution was, with Mumbai and Delhi ranking much higher than any other city in both population and rate of air pollution. However, when it came to the less populated cities, there were many instances of a city (such as Buxar or Motihari) having much higher levels of pollution than a significantly more populated city (like Ahmedabad), illustrating that population size is not the only factor we need to take into account. These cases warrant further investigation, which we were not able to do during the scope of this project. It was clear from the database that pollution level is not even across Indian cities, with vast variations in PPB. So while population does seem to have an effect on pollution levels, the correlation is not by any means wholly established.  
  
Below is a more detailed approach to the data manipulation performed, demonstrating how we arrived at these conclusions and the steps you can take to reproduce the code.  
  
Datasets:  
	- https://www.kaggle.com/datasets/kkhandekar/carbon-monoxide-concentration-indian-cities  
	- https://www.kaggle.com/datasets/meeratif/indian-cities-by-population-dataset  
  
  
-------------------------------------------------------------------------  
  
# Report:  
  
**Extract:**  
The two datasets used were obtained from Kaggle at the aforementioned web addresses.  
  
The first dataset, “Indian Cities by Population”, is a comparison of the population of Indian cities in 2001 and 2011. There are five columns: “Rank” contains an integer for each city, indicating how it compares to other Indian cities, with “1” being the highest population. The “City” column contains the name of the city in the form of a string. The “Population (2011)” column contains the population of the city in the year 2011. Similarly, the “Population (2001)” column contains the population of the city in 2001, both of these contain commas every three digits and so they are stored as strings. The last column, “State or Union Territory”, indicates the name of either the state or union territory that the city is located in, stored as a string.  
  
The second dataset is “Carbon Monoxide Concentration - Indian Cities”, which contains data on the air carbon monoxide concentration in Indian cities. The columns here are: “State” - the name of the state (or union territory) that the city is in, as a string. “City”, the name of the city, as a string. The last three columns “Avg(ppb)”, “Max(ppb)”, and “Min(ppb)” provide the average, maximum, and minimum air carbon monoxide concentrations in parts per billion, respectively.  
  
These were downloaded as .csv files, then read into Pandas dataframes in a Jupyter notebook file.  
  
**Transform:**  
Once loaded into dataframes, data cleaning began. First, column names were changed to be simpler and more SQL-friendly, and the less useful columns were dropped. The dropped columns were “Population (2001)” from the population data, and the “Max(ppb)” and “Min(ppb)” from the pollution data. Next, rows with missing data were dropped. Then, some of the city names in the population dataset had what appears to be citations at the end of them (e.g. “Bettiah[30]”), these would get in the way of any joins between these datasets on their “city” column. So, a str.replace() statement was used to remove these. Finally, duplicate rows were removed from both dataframes. This was the extent of the cleaning that was needed, as the datasets were already of a decent quality.  
  
Refer to the “data_etl.ipynb” file for the exact code used for this section.  
  
**Load:**  
A database named indian_cities_db was created in PostgreSQL, then queries were used to create two empty tables with column names and data types matching those used in the cleaned dataframes, one named “indian_population” and the other named “indian_pollution”. Refer to the “indian_cities.sql” file for the exact queries used here, as well as the final join query used to join the two tables on the “city” column.  
  
SQLAlchemy was used to connect the “data_etl.ipynb” file containing the dataframes to the indian_cities_db database. From there, Pandas was used to load the dataframes into their respective tables in the database. Pandas’ “read_sql_query()” function was then used to query the database to confirm that this had been successful, and then finally to join these two tables via their “city” column; this is featured in the last cell of the notebook file. As this was an inner join, cities not matching between the two were dropped.  
  
So, the final schemata was two tables in a PostgreSQL database. The first, “indian_population”, contained the columns: “city”, “population”, and “state”, all data types were text. The second, “indian_pollution”, contained the columns: “state”, “city”, and “average_ppb”, with the first two being text and “average_ppb” using the float data type.  
  
These datasets were chosen because, though we weren’t actually required to perform analysis for this project, we wanted to use the ETL process to prepare datasets that could actually be used to answer interesting questions. So, we decided to investigate if there is a correlation between the population of a city and its pollution levels. The motivation behind choosing Indian cities was to look into another country, one which we aren’t very familiar with. Also, there is far more data for this sort of thing for Indian cities than Australian, as well as there of course being far more cities in India too, making for a larger dataset.  

# Global COVID-19 Vaccination Rates

Team Members: Walter Wilson and Rolly Costillas

## Project Proposal
	
For this project, we will be extracting data involving COVID-19 vaccination rates, cleaning the data and loading it into a SQL Database for further analysis. We believe that this will be valuable data to have and analyze as it will allow us to gain further insights into which countries could use more support in getting their populations vaccinated. In particular, the following insights could be gained through the database that we will create.

1. How does the country's GDP impact the rate of vaccination for its population?
2. Does a nation’s population density and/or level of urbanization have an effect on the rate of vaccination?
3. Does higher unemployment lead to lower rates of vaccinations in countries?

We will be using two data sources for this project. The first is this set of [COVID-19 Data](https://www.kaggle.com/datasets/taranvee/covid-19-dataset-till-2222022) in the form of a csv file which is sourced from 'Our World in Data' which is an organization that has been tracking various aspects of the COVID-19 pandemic. This data set will give us daily statistics on COVID-19 vaccination rates. The second source that we will be using is the [Country API by API Ninja](https://api-ninjas.com/api/country). This API will allow us to retrieve statistics about countries such as their GDP, urbanization rate, unemployment rate and population density.

We will extract the data from both of these sources and read them into Pandas Dataframes before cleaning them to give us only the information relevant for any analysis. The data will be structured into two tables, one consisting of the COVID-19 data while the other will consist of the country statistics. These tables will then be loaded into a Postgresql database following the schema located in [Resources](https://github.com/wawilson810/Project-2/tree/main/Resources). There is also a png of the ERD for the database in [Resources](https://github.com/wawilson810/Project-2/tree/main/Resources).

## Project Report

### Extraction

The two datasets that we are using were both read into a jupyter notebook. The [COVID-19 Data](https://www.kaggle.com/datasets/taranvee/covid-19-dataset-till-2222022) was sourced from Kaggle and is included in [Resources](https://github.com/wawilson810/Project-2/tree/main/Resources). This data was then read into a Pandas Dataframe for the transformation. The data on the country statistics was gathered through an API. To get the data from this API, we first got a list of countries that were included in our cleaned COVID-19 dataset and then queried the API with the individual countries from that list using the iso codes. This returned a json of the statistics for said countries and any countries that were in the API's records had their statistics concatenated onto a Pandas Dataframe.

### Transformation

We started by cleaning the COVID-19 Dataset. When the csv was loaded into a Pandas Dataframe, it included many statistics that would be irrelevant for analysis of vaccination rates. The first step we took was filtering out all of the columns that weren't needed. This left us with a Dataframe with many rows of null values which represented countries where vaccination data was unable to be sourced from on a given date. Using the pandas.Dataframe.dropna() method, these rows were dropped from the Dataframe which left us with only the relevant data. Additionally, this had the benefit of clearing out rows which were statistics for entire continents which were included in the csv but dropped because the continent values in those rows were empty. To further clean the dataframe, we iterated through the country column and got rid of anything in paranthesis. This was done because the iso code is unique to each country and the extra information made the data look messy.

Then we calculated the percentage of the population that had at least one vaccine and that were fully vaccinated in each country for every date. We replaced the 'people_vaccinated' and 'people_fully_vaccinated' with these values since they would be more useful for comparative analysis.

Then we read in the data the API Ninjas' [Country API](https://api-ninjas.com/api/country) into a dataframe. We queried the API for every unique iso code in our COVID-19 dataset, concatenating the statistics for each country onto a separate Dataframe. Some of the iso codes that were included in the COVID-19 dataset were not recognized by the API. The countries that were recognized were made into a list and then the COVID-19 dataset was filtered farther to only include countries which had available statistics.

### Load

To load the data into a database, we first created a vaccinations_db database in Postgresql. The database contained two tables, a 'vaccination' table and a 'stats' table which have a shared key of iso_code. The schema that describes this database is located [here](https://github.com/wawilson810/Project-2/blob/main/Resources/schema.sql) and the ERD describing the relationship is located [here](https://github.com/wawilson810/Project-2/blob/main/Resources/ETL_ERD.png) After these two tables were created, we established a connection between our jupyter notebook and the database using sqlalchemy before loading the data in using pandas built in to_sql() method which uses psycopg2 to interface with Postgresql. We then verified that the data had been loaded in properly.





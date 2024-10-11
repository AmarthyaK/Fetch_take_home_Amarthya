# Fetch_take_home_Amarthya

Execution Order of Codes:
The following list outlines the order in which the provided notebooks should be executed. The execution order is indicated in the notebook names with suffixes "_ex{1,2,3,...}", representing the sequence of execution.

parsing_json_ex1: Parse the raw JSON data, perform normalization, and export the results to CSV files.
DateQualityIssues_Loading_Data_ex2: Conduct data quality checks, exploratory data analysis (EDA), and load the cleaned data into MySQL.
query_1_2_ex3, query_3_4_ex4, query_5_6_ex5: Execute SQL scripts to address the business questions based on the data in MySQL.

File and Folder Explanation:

Data_sources: This folder contains the raw JSON data sources.
Dependencies: A file listing all the Python libraries required. Reviewers should ensure they have these libraries installed before running the code.
MYSQL_user_config: Contains MySQL server configurations, including parameters such as user, host, password, and port.
Important:
Before running any queries, ensure that MySQL is running.
To check this:

Press Win + R -> Type services.msc -> Ensure MYSQL80 is running.
Edit the configuration file based on your MySQL server configuration.

For further configuration details, one can verify the information from manage Server Connections window in MYSQL80


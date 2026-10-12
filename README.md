# Masai-Capstone-Project
submissions/
- README.md                                        # This file. Gives a step-by-step guide to running the layers.
- sql/schema_seed_data_and_reports.sql             # One sql file. Create DB, schema, insert data & task reports.  
- data/customers.csv, products.csv, orders.csv     # The raw data from the brief converted into csv files.
- analysis/clean_eda_and_visualisations.ipynb      # One notebook with cleaning, EDA and visualisation tasks. 
- visualizations/return_rate_by_payment.png, monthly_revenue_trend.png      # The charts plotted with the findings and labeled highlights.
- narrator/ findings.json, generate_narrative.ipynb, sample_output.txt     # The findings json, GenAI code notebook & AI sample output for running the numeric accuracy check.
    

# Part 1 : SQL Relational Layer & Reporting
- Download and open the schema_seed_data_and_reports.sql file on MySQL. This single file contains all the code for Tasks 1, 2 & 3.
- Copy the whole body of code.
- Connect to local instance with your password and open a new SQL tab.
- Paste the whole body of code into the new tab.
- Each code block is headed by a -- comment that gives out its task specified by the brief. Execute each portion of code sequentially using the execute below cusror button.
- CAUTION : in Task 2, enter file path to seed data csv files from your machine. Take care to use double back slashes in the folder separators in MySQL to avoid errors.
- Each task wise code block will produce the outputs as specified in the brief.

- # Part 2 — Python/Pandas Data Wrangling & EDA
- Download and Import clean_eda_and_visualisations.ipynb into a new google colab notebook. The code for cleaning, EDA and visualisations is all included in this single python file.
- Upload the customers, products and orders csv files to the google colab files repository by clicking on the files icon on the left of the page.
- Code for each task is in a separate cell with a # comment for the task name and requirement.
- Running each cell once the csv files are uploaded will produce the outputs required by the brief.
- CAUTION : Each cell will have to be run sequentially as the outputs from earlier cells feed subsequent cells in the data wrangling code pipeline.
- Task 5 generates the findings.json file required for Part 3. The file generated while making the project is uploaded in this repo.

- # Part 3 — GenAI-Powered Insight Narrator
- Download and Import generate_narrative.ipynb into a new google colab notebook. Grader will need to paste their own API key in place of 'YOUR_API_KEY' in the code cell for Task 2. This will make it an environment variable for the whole notebook.
- The default model ingoogle colab is set to gemini 2.5 flash lite which is now not supported. Grader will need to update the model to a gemini-flash-lite-latest in the response = client.models.generate_content section of the code for Task 2.
- Task 4 contains the code for the offline fallback path which works in the absence of an API key. **NOTE** : The findings.json file will ahve to be uploaded up google colab for this code to work.
- The sample_output.txt file uploaded in this repo is for carrying out the numeric accuracy check by the grader. **NOTE** : It will need to be uploaded to google colab for the code to work.

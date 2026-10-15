# Masai-Capstone-Project

# Overview
The folders contain :
    - The relational database created on MySQL with the analytical queries.
    - The EDA, wrangling and visualizations done using Python.
    - The GenAI SCR narrative, JSON and accuracy checks. 
    
Part wise steps to be followed to access the repo are covered below.
    

# Part 1 : SQL Relational Layer & Reporting
- Open the sql folder, Download and open the schema, seed_data and eports.sql files. 
- Open MySQL / syntax compatible sql code editor and connect to local instance with your password and open a new SQL tab.
- Copy the code from schema.sql, seed_data.sql and reports.sql and paste into the new file in that order.
- Each code block is headed by a -- comment that gives out its task specified by the brief. Execute each portion of code sequentially using the execute below cusror button.
- **CAUTION** : in Task 2, enter file path to seed data csv files from your machine. Take care to use double back slashes in the folder separators in MySQL to avoid errors.
- Each task wise code block will produce the outputs as specified in the brief.

- # Part 2 — Python/Pandas Data Wrangling & EDA
- Download and Import clean_and_eda.py and visualisations.py into separate new google colab notebooks. 
- Upload the customers, products and orders csv files to the google colab files repository by clicking on the files icon on the left of the page.
- Code for each task is in marked with a # comment for the task name and requirement.
- Running once the csv files are uploaded will produce the outputs required by the brief.
- In case of errors, the clean_eda_and_visualisations.ipynb file is also uploaded as a backup which contains the complete code. The .csv files will have to be uploaded for this to work as well.
- CAUTION : Each cell in the ipynb file will have to be run sequentially as the outputs from earlier cells feed subsequent cells in the data wrangling code pipeline.
- Task 5 generates the findings.json file required for Part 3. The file generated while making the project is uploaded in this repo.

- # Part 3 — GenAI-Powered Insight Narrator
- Download and Import generate_narrative.py into a new google colab notebook. Grader will need to paste their **own API key in place of 'YOUR_API_KEY'** in the code cell for Task 2. This will make it an environment variable for the whole notebook. The .csv files also will have to be uploaded for this to work.
- In case of errors, the generate_narrative.ipynb file is also uploaded as a backup which contains the complete code. The .csv files will have to be uploaded for this to work as well.
- The default model in google colab is set to gemini 2.5 flash lite which is now not supported. Grader will need to update the model to a gemini-flash-lite-latest in the **response = client.models.generate_content** section of the code for Task 2.
- Task 4 contains the code for the offline fallback path which works in the absence of an API key. **NOTE** : The findings.json file will ahve to be uploaded up google colab for this code to work.
- The sample_output.txt file uploaded in this repo is for carrying out the numeric accuracy check by the grader. **NOTE** : It will need to be uploaded to google colab for the code to work.

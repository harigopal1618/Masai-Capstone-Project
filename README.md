# Masai-Capstone-Project
submission/
├── README.md                        # This file. Gives a step-by-step guide to running the layers.
├── sql/                             # One sql file. Create DB, schema, insert data & task reports.
│   ├── schema_seed_data_and_reports.sql
├── data/                            # The raw data from the brief converted into csv files.
│   ├── customers.csv
│   ├── products.csv
│   └── orders.csv
├── analysis/                        # One notebook with cleaning, EDA and visualisation tasks.
│   ├── clean_eda_and_visualisations.py 
├── visualizations/                  # The charts plotted with the findings and labeled highlights.
│   ├── return_rate_by_payment.png
│   └── monthly_revenue_trend.png
└── narrator/                        # The findings json, GenAI code notebook & AI sample output for running the numeric accuracy check.
    ├── findings.json
    └── generate_narrative.py
    └── sample_output.txt

# Part 1 : SQL Relational Layer & Reporting
- Download and open the schema_seed_data_and_reports.sql file on MySQL. This single file contains all the code for Tasks 1, 2 & 3.
- Copy the whole body of code.
- Connect to local instance with your password and open a new SQL tab.
- Paste the whole body of code into the new tab.
- Each code block is headed by a -- comment that gives out its task specified by the brief. Execute each portion of code sequentially using the execute below cusror button.
- CAUTION : in Task 2, enter file path to seed data csv files from your machine. Take care to use double back slashes in the folder separators in MySQL to avoid errors.
- Each task wise code block will produce the outputs as specified in the brief.

- # Part 2 — Python/Pandas Data Wrangling & EDA
- Import the clean_eda_and_visualisations.py into a new google colab notebook. The code for cleaning, EDA and visualisations is all included in this single python file.
- Upload the customers, products and orders csv files to google colab.
- 

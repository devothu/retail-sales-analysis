# retail-sales-analysis
Data analysis project exploring retail sales trends and product performance using Python and data visualization.
# Retail Sales Analysis Using SAS

## Project Overview

This project demonstrates a simple retail sales analysis using SAS.  
The dataset contains information about products sold, categories, quantity sold, and price.

The goal of the project is to perform:

- Data Import
- Data Cleaning
- Sales Calculations
- Aggregated Sales Analysis
- Visualization

This project is part of my Data Analytics / Data Science portfolio.

---

## Dataset

The dataset contains the following columns:

| Column | Description |
|------|------|
| date | Date of transaction |
| product | Product name |
| category | Product category |
| quantity | Units sold |
| price | Price per unit |

---

## Steps Performed

### 1 Import Data
The CSV file is imported into SAS using `PROC IMPORT`.

### 2 Data Cleaning
A new variable called `total_sales` is created:

total_sales = quantity * price

### 3 Exploratory Analysis

Basic statistics are calculated using:

PROC MEANS

This provides:

- Total quantity sold
- Average price
- Total revenue

### 4 Product Level Analysis

Using PROC SQL, we calculate:

- Total quantity sold per product
- Total revenue per product

### 5 Category Level Analysis

Sales are aggregated by category to understand which category performs best.

### 6 Daily Sales Trend

Daily revenue is calculated to identify sales trends over time.

### 7 Data Visualization

Two charts are created:

1. Revenue by Product (Bar Chart)
2. Daily Revenue Trend (Line Chart)

---

## Technologies Used

- SAS
- PROC SQL
- PROC MEANS
- PROC SGPLOT

---

## How to Run the Project

1. Download the repository
2. Place the CSV file in the data folder
3. Open the SAS file
4. Update the file paths if necessary
5. Run the program

---

## Future Improvements

- Larger datasets
- Customer segmentation
- Profit analysis
- Forecasting models

---

## Author

Final Year BSc Computer Science & Statistics Student  
Aspiring Data Scientist

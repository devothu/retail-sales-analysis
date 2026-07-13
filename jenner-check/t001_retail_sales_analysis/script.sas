/*==============================================
Retail Sales Analysis Project
Author:Othusitse Matlhaku
Description: Basic retail sales analytics using SAS
==============================================*/

/* Step 1: Define library */
/* The original points a RETAIL libname at a local Downloads folder and
   imports Downloads/retail_project/data/sales_data.csv via PROC IMPORT.
   For a self-contained run the same columns (date, product, category,
   quantity, price) are read inline below; every downstream step is the
   author's own. */
libname retail (work);

/* Step 2: Load sales data (same schema as the project CSV) */
data retail.sales;
    length product $12 category $12;
    informat date yymmdd10.;
    format date yymmdd10.;
    input date product $ category $ quantity price;
    datalines;
2024-01-05 WidgetA Hardware 12 4.50
2024-01-05 GadgetB Electronics 5 19.99
2024-01-06 WidgetA Hardware 8 4.50
2024-01-06 Notebook Stationery 20 2.25
2024-01-07 GadgetB Electronics 3 19.99
2024-01-07 DeskLamp Home 4 15.00
2024-01-08 WidgetA Hardware 15 4.50
2024-01-08 Notebook Stationery 10 2.25
2024-01-09 DeskLamp Home 6 15.00
2024-01-09 GadgetB Electronics 7 19.99
2024-01-10 WidgetA Hardware 9 4.50
2024-01-10 Notebook Stationery 25 2.25
2024-01-11 DeskLamp Home 2 15.00
2024-01-11 GadgetB Electronics 4 19.99
2024-01-12 WidgetA Hardware 11 4.50
;
run;


/* Step 3: Data Cleaning */

data retail.sales_clean;
    set retail.sales;

    /* Convert date to SAS format */
    format date yymmdd10.;

    /* Create Total Sales variable */
    total_sales = quantity * price;

run;


/* Step 4: View Dataset */

proc print data=retail.sales_clean;
run;


/* Step 5: Summary Statistics */

proc means data=retail.sales_clean sum mean max min;
    var quantity price total_sales;
run;


/* Step 6: Sales by Product */

proc sql;
create table retail.sales_by_product as
select product,
       sum(quantity) as total_quantity,
       sum(total_sales) as total_revenue
from retail.sales_clean
group by product;
quit;

proc print data=retail.sales_by_product;
run;


/* Step 7: Sales by Category */

proc sql;
create table retail.sales_by_category as
select category,
       sum(quantity) as total_quantity,
       sum(total_sales) as total_revenue
from retail.sales_clean
group by category;
quit;

proc print data=retail.sales_by_category;
run;


/* Step 8: Daily Sales Trend */

proc sql;
create table retail.daily_sales as
select date,
       sum(total_sales) as daily_revenue
from retail.sales_clean
group by date;
quit;

proc print data=retail.daily_sales;
run;


/* Step 9: Visualization */

proc sgplot data=retail.sales_by_product;
    vbar product / response=total_revenue datalabel;
    title "Revenue by Product";
run;

proc sgplot data=retail.daily_sales;
    series x=date y=daily_revenue;
    title "Daily Sales Trend";
run;

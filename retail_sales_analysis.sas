.sass-cache/
*.css.map
*.sass.map
*.scss.map
/*==============================================
Retail Sales Analysis Project
Author:Othusitse Matlhaku
Description: Basic retail sales analytics using SAS
==============================================*/

/* Step 1: Define library
*/
libname retail "Downloads/retail_project";

/* Step 2: Import CSV file
*/

proc import datafile="/folders/myfolders/retail_project/data/sales_data.csv"
    out=retail.sales
    dbms=csv
    replace;
    guessingrows=max;
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

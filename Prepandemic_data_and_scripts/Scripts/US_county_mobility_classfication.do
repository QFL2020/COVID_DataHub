set more off
log using US_county_mobility_classfication.log, replace
tempfile t t1 t2
* Covid-19 program
* May 2020
* The median of the max-distance mobility in each county from Mar 1 to Apr 18
* Jiaolong He

import delim using Global_Mobility_Report.csv,colr(1:5) clear
d
sum

keep if country_region_code=="US"
keep if sub_region_1!="."
tab sub_region_1,m

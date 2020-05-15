set more off
log using prepandemic.log,replace
tempfile t1 t2 t3 t4 t5 t6 t7 t8

* Covid-19 program
* April 2020
* Reshape long form data to be wide form data and merge those data as one data
* Jiaolong He

use US_state_uninsured,clear
merge 1:m stfips using US_county_tax_filling
drop _merge

merge 1:1 fips using US_county_mortality
drop tot_2018
drop _merge

merge 1:1 fips using US_county_housing_density
drop _merge

merge 1:1 fips using US_county_Pop_density
drop _merge

merge 1:1 fips using US_county_gdp
drop _merge

merge 1:1 fips using US_county_migration
drop _merge

merge 1:1 fips using US_county_Pop
drop _merge

merge 1:1 fips using US_county_poverty
drop _merge

merge 1:1 fips using US_county_household_income
drop _merge

merge 1:1 fips using US_county_social_determinants.dta
drop _merge
order stname stfips ctyname ctyfips fips
compress
d
sum

save prepandemic,replace 
export delim using prepandemic.csv,  replace

keep stname stfips ctyname ctyfips fips medexp uninsured_2017 agi* outmig2013_2017 inmig2013_2017 *2018 oldprop povprop hincgroup* languge diabetes_2016 association_2017 associationrate_2017 dissimwb dissimwn smoker_2017 hiv_2016
compress
d
sum
save prepandemic_mini,replace 
export delim using prepandemic_mini.csv,  replace

log close

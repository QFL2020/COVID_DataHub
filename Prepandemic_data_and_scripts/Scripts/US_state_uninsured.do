set more off
log using US_state_uninsured.log, replace
tempfile t t1

* Covid-19 program
* April 2020
* Data from Census bureau
* Proportion of people without health insurance of counties in 2013, 2016 and 2017 
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\uninsurance.csv",clear
drop v6 v7

* name of state
rename state stname
la var stname "State name"

* medicaid expansion state
rename medicaidexpansionstateyesyornon1 medexp
replace medexp="1" if  medexp=="Y"
replace medexp="0" if  medexp=="N"
destring medexp,replace
la var medexp "Is the medicaid expansion state since 2014? 1_Yes 0_No"

* uninsured
ren uninsured uninsured_2013
ren v4 uninsured_2016
ren v5 uninsured_2017

replace uninsured_2013 = uninsured_2013/100
replace uninsured_2016 = uninsured_2016/100
replace uninsured_2017 = uninsured_2017/100

la var uninsured_2013 "Without health insurance in 2013, prop."
la var uninsured_2016 "Without health insurance in 2016, prop."
la var uninsured_2017 "Without health insurance in 2017, prop."

* get fips
merge 1:m stname using US_county_Pop
keep if _merge==3
bys stfips:drop if stfips==stfips[_n-1]

keep stname stfips medexp uninsured*
order stname stfips medexp uninsured*

compress
d
sum
export exc using US_state_uninsured.xlsx, first(var) replace
save US_state_uninsured.dta, replace

log close

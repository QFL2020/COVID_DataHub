set more off
log using US_county_household_income.log, replace
tempfile t t1
* Covid-19 program
* April 2020
* Total household numbers and household income group based on 5-year estimate (2014 to 2018)
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\ACS_Household_Income_Distribution.csv",clear
d
sum

rename state stname
la var stname "State name"

rename geographicidentifierfipscode fipsc
tostring fipsc,gen(fipscc)
gen a="0"
egen fips=concat(a fipscc) if fipsc < 10000
replace fips=fipscc if fips==""
drop a fipsc fipscc
la var fips "FIPS code of state-county"

gen stfips=substr(fips,1,2)
la var stfips "State FIPS code"

gen ctyfips=substr(fips,3,3)
la var ctyfips "County FIPS code"

rename totalhouseholds tothousehold
la var tothousehold "Total household. Count based on ACS(2014-18)"
rename householdswhoseincomeinthepast12 hinc_group1
forval i=5/19{
local a = `i'-3
rename v`i' hinc_group`a'
}
forval i=1/16{
gen hincgroup`i'=hinc_group`i'/tothousehold
}
la var hincgroup1 "Prop. of Households whose income less than $10,000 based on ACS(2014-18)"
la var hincgroup2 "Prop. of Households whose income was $10,000 to $14,999 based on ACS(2014-18)"
la var hincgroup3 "Prop. of Households whose income was $15,000 to $19,999 based on ACS(2014-18)"
la var hincgroup4 "Prop. of Households whose income was $20,000 to $24,999 based on ACS(2014-18)"
la var hincgroup5 "Prop. of Households whose income was $25,000 to $29,999 based on ACS(2014-18)"
la var hincgroup6 "Prop. of Households whose income was $30,000 to $34,999 based on ACS(2014-18)"
la var hincgroup7 "Prop. of Households whose income was $35,000 to $39,999 based on ACS(2014-18)"
la var hincgroup8 "Prop. of Households whose income was $40,000 to $44,999 based on ACS(2014-18)"
la var hincgroup9 "Prop. of Households whose income was $45,000 to $49,999 based on ACS(2014-18)"
la var hincgroup10 "Prop. of Households whose income was $50,000 to $59,999 based on ACS(2014-18)"
la var hincgroup11 "Prop. of Households whose income was $60,000 to $74,999 based on ACS(2014-18)"
la var hincgroup12 "Prop. of Households whose income was $75,000 to $99,999 based on ACS(2014-18)"
la var hincgroup13 "Prop. of Households whose income was $100,000 to $124,999 based on ACS(2014-18)"
la var hincgroup14 "Prop. of Households whose income was $125,000 to $149,999 based on ACS(2014-18)"
la var hincgroup15 "Prop. of Households whose income was $150,000 to $199,999 based on ACS(2014-18)"
la var hincgroup16 "Prop. of Households whose income was $200,000 or more based on ACS(2014-18)"
keep stname stfips ctyfips fips tothousehold hincgroup*
order stname stfips ctyfips fips tothousehold

compress 
d 
sum 

save US_county_household_income,replace
export exc using US_county_household_income.xlsx, first(var) replace
log close

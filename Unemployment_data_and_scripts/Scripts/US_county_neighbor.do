set more off
log using US_county_neighbor.log, replace
tempfile t 

* Covid-19 program
* April 2020
* Census data/Geographic data
* Neighbors of each county
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Unemployment\Raw data\neighbor.csv",stringc(_all) clear
d
sum

forval i=1/14{
destring v`i',gen(pv`i')
gen v`i'o="0"
egen pv`i'p=concat(v`i'o pv`i')
replace v`i'=pv`i'p if pv`i'<10000
drop pv`i' pv`i'p v`i'o
}
list in 1/50

rename v1 fips 
la var fips "FIPS code of state-county"

forval i=2/14{
local a = `i'-1
rename v`i' neighbor`a'_2017
}

la var neighbor1_2017 "The 1st neighbor county in 2017"
la var neighbor2_2017 "The 2nd neighbor county in 2017"
la var neighbor3_2017 "The 3rd neighbor county in 2017"

forval i=4/13{
la var neighbor`i'_2017 "The `i'th neighbor county in 2017"
}

compress
d
sum
save US_county_neighbor,replace
export exc using US_county_neighbor.xlsx, first(var) replace
log close

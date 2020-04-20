set more off
log using unemployment.log, replace
tempfile t t1

* Covid-19 program
* April 2020
* Data from BLS
* Unemployment rate of counties from Jan-2019 to Feb-2020
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 1 data release\Unemployment\Raw data\LAUS_County.csv", stringc(2 3) numericc(6 7 8) clear
d
sum
*Give up PR district
drop if statefipscode=="72"

*name and fips code
ren statefipscode stfips
la var stfips "State FIPS code"
ren countyfipscode ctyfips
la var ctyfips "County FIPS code"

gen fips=substr(lauscode,3,5)
sort fips
sum fips if fips!=fips[_n-1]
la var fips "FIPS code of state-county"

*year and month
gen year=substr(period,5,2)
destring year,replace
tab year
replace year=year+2000
la var year "Year"

gen mon=substr(period,1,3)
gen month=1 if mon=="Jan"
replace month=2 if mon=="Feb"
replace month=3 if mon=="Mar"
replace month=4 if mon=="Apr"
replace month=5 if mon=="May"
replace month=6 if mon=="Jun"
replace month=7 if mon=="Jul"
replace month=8 if mon=="Aug"
replace month=9 if mon=="Sep"
replace month=10 if mon=="Oct"
replace month=11 if mon=="Nov"
replace month=12 if mon=="Dec"
la var month "Month"
save `t'

*reshape to wide data
use `t',clear
keep if year==2020
drop year

rename laborforce laborforce_2020_
la var laborforce_2020_ "Total labor force count-2020"
rename unemployment unemployment_2020_
la var unemployment_2020_ "Unemployment rate-2020"

keep fips month laborforce_ unemployment_
reshape8 wide laborforce_ unemployment_ , i(fips) j(month)
save `t1'

use `t',clear
keep if year==2019
drop year

rename laborforce laborforce_2019_
la var laborforce_2019_ "Total labor force count-2019"
rename unemployment unemployment_2019_
la var unemployment_2019_ "Unemployment rate-2019"

keep fips month laborforce_ unemployment_
reshape8 wide laborforce_ unemployment_ , i(fips) j(month)

merge 1:1 fips using `t1'
drop _merge

*get name of state and county
merge 1:m fips using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 1 data release\Prepandemic\intermediate data\US_county_Pop.dta"
sort fips
keep if fips!=fips[_n-1]
keep stname stfips ctyname ctyfips fips laborforce* unemployment*

merge 1:1 fips using US_county_neighbor.dta 
keep if _merge==3
drop _merge

order stname stfips ctyname ctyfips fips
compress
d
sum

export delim using unemployment.csv, datafmt replace
save unemployment.dta,replace

log close

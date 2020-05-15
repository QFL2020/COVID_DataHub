set more off
log using unemployment.log, replace
tempfile t t1

* Covid-19 program
* May 2020
* Data from BLS
* Unemployment rate of counties from Jan-2019 to Mar-2020
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Unemployment\Raw data\LAUS_County.csv", stringc(2 3) numericc(6 7 8) clear
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
gen month="01" if mon=="Jan"
replace month="02" if mon=="Feb"
replace month="03" if mon=="Mar"
replace month="04" if mon=="Apr"
replace month="05" if mon=="May"
replace month="06" if mon=="Jun"
replace month="07" if mon=="Jul"
replace month="08" if mon=="Aug"
replace month="09" if mon=="Sep"
replace month="10" if mon=="Oct"
replace month="11" if mon=="Nov"
replace month="12" if mon=="Dec"
la var month "Month"
save `t'

*reshape to wide data
use `t',clear
keep if year==2020
drop year

rename laborforce laborforce_2020
rename unemployment unemployment_2020
keep fips month laborforce_2020 unemployment_2020
reshape wide laborforce_2020 unemployment_2020, i(fips) j(month) string
la var laborforce_202001 "Total labor force count in 202001"
la var laborforce_202002 "Total labor force count in 202002"
la var laborforce_202003 "Total labor force count in 202003, not seasonal adjusted preliminary estimate"
la var unemployment_202001 "Unemployment rate in 202001"
la var unemployment_202002 "Unemployment rate in 202002"
la var unemployment_202003 "Unemployment rate in 202003, not seasonal adjusted preliminary estimate"
save `t1'

use `t',clear
keep if year==2019
drop year

rename laborforce laborforce_2019
rename unemployment unemployment_2019
keep fips month laborforce_2019 unemployment_2019
reshape wide laborforce_2019 unemployment_2019 , i(fips) j(month) string
forval i=1/9{
la var laborforce_20190`i' "Total labor force count in 20190`i'"
la var unemployment_20190`i' "Unemployment rate in 20190`i', not seasonal adjusted"
}
forval i=10/12{
la var laborforce_2019`i' "Total labor force count in 2019`i'"
la var unemployment_2019`i' "Unemployment rate in 2019`i', not seasonal adjusted"
}
merge 1:1 fips using `t1'
drop _merge

*get name of state and county
merge 1:m fips using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\intermediate steps\US_county_Pop.dta"
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

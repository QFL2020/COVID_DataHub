set more off
log using unemployment.log, replace
tempfile t t1

* Covid-19 program
* May 2020
* Data from BLS
* Unemployment rate of counties from Jan-2019 to Feb-2020
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
gen year=substr(period,1,2)
destring year,replace
tab year
replace year=year+2000
la var year "Year"

gen mon=substr(period,4,3)
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
la var laborforce_202001 "Total labor force count-2020-01"
la var laborforce_202002 "Total labor force count-2020-02"
la var laborforce_202003 "Total labor force count-2020-03"
la var unemployment_202001 "Unemployment rate-2020-01"
la var unemployment_202002 "Unemployment rate-2020-02"
la var unemployment_202003 "Unemployment rate-2020-03"
save `t1'

use `t',clear
keep if year==2019
drop year

rename laborforce laborforce_2019
rename unemployment unemployment_2019
keep fips month laborforce_2019 unemployment_2019
reshape wide laborforce_2019 unemployment_2019 , i(fips) j(month) string
la var laborforce_201901 "Total labor force count-2019-01"
la var laborforce_201902 "Total labor force count-2019-02"
la var laborforce_201903 "Total labor force count-2019-03"
la var laborforce_201904 "Total labor force count-2019-04"
la var laborforce_201905 "Total labor force count-2019-05"
la var laborforce_201906 "Total labor force count-2019-06"
la var laborforce_201907 "Total labor force count-2019-07"
la var laborforce_201908 "Total labor force count-2019-08"
la var laborforce_201909 "Total labor force count-2019-09"
la var laborforce_201910 "Total labor force count-2019-10"
la var laborforce_201911 "Total labor force count-2019-11"
la var laborforce_201912 "Total labor force count-2019-12"
la var unemployment_201901 "Unemployment rate-2019-01"
la var unemployment_201902 "Unemployment rate-2019-02"
la var unemployment_201903 "Unemployment rate-2019-03"
la var unemployment_201904 "Unemployment rate-2019-04"
la var unemployment_201905 "Unemployment rate-2019-05"
la var unemployment_201906 "Unemployment rate-2019-06"
la var unemployment_201907 "Unemployment rate-2019-07"
la var unemployment_201908 "Unemployment rate-2019-08"
la var unemployment_201909 "Unemployment rate-2019-09"
la var unemployment_201910 "Unemployment rate-2019-10"
la var unemployment_201911 "Unemployment rate-2019-11"
la var unemployment_201912 "Unemployment rate-2019-12"
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

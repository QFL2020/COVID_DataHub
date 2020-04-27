set more off
log using prepandemic.log,replace
tempfile t1 t2 t3 t4 t5 t6 t7 t8

* Covid-19 program
* April 2020
* Reshape long form data to be wide form data and merge those data as one data
* Jiaolong He

**step 1: revised data
use US_county_Pop,clear
rename a* a*_
rename n* n*_
rename tot tot_
rename male male_
reshape8 wide tot_-nh_hawaii_na, i(fips) j(year)
save `t1'

use US_county_Pop_density,clear
rename popdensity popdensity_
reshape8 wide popdensity_, i(fips) j(year)
save `t2'

use US_county_housing_density,clear
rename houseper houseper_
reshape8 wide houseper_, i(fips) j(year)
save `t3'

use US_county_gdp,clear
rename gdp gdp_
reshape8 wide gdp_, i(fips) j(year)
save `t4'

use US_state_uninsured,clear
rename medexp medexp_2017
rename uninsured uninsured_
reshape8 wide uninsured_, i(stfips) j(year)

**step 2: merge data
merge 1:m stfips using US_county_tax_filling
drop _merge

merge 1:1 fips using US_county_mortality
drop tot_2018
drop _merge

merge 1:1 fips using `t3'
drop _merge

merge 1:1 fips using `t2'
drop _merge

merge 1:1 fips using `t4'
drop _merge

merge 1:1 fips using US_county_migration
drop _merge

merge 1:1 fips using `t1'
drop _merge

order stname stfips ctyname ctyfips fips

compress
d
sum

save prepandemic,replace 
export delim using prepandemic.csv,  replace
log close

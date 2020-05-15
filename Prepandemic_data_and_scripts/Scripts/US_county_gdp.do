set more off
log using US_county_gdp.log,replace
tempfile t t1 t2 t3 t4 t5 t11 t21 t31

* Covid-19 program
* April 2020
* BEA data
* GDP of counties from 2015 to 2018
* Jiaolong He

use US_county_Pop.dta,clear
keep stname stfips ctyname ctyfips fips tot* ageg4* ageg5* ageg6* ageg7* ageg8* ageg9* ageg10* ageg11* ageg12* ageg13*
forval i=2010/2018{
egen wkpop_`i'=rowtotal(ageg4_`i' ageg5_`i' ageg6_`i' ageg7_`i' ageg8_`i' ageg9_`i' ageg10_`i' ageg11_`i' ageg12_`i' ageg13_`i')
replace wkpop_`i'=round(wkpop_`i'*tot_`i')
}
keep stname stfips ctyname ctyfips fips wkpop*
save `t1',replace

forval i=2/3{
use `t1',clear
rename fips fips`i' 
forval j=2010/2018{
rename wkpop_`j' wkpop_`j'_`i' 
}
save `t`i''
}

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\county_gdp.csv",varn(1) stringc(1 2 3 4 5 6 7) numericc(8 9 10 11 12) clear
d
sum
gen id=_n
save `t4'

********Part 2: Deal with counties without combination gdp

**deal with those counties without combination
keep if combine==0
drop ctyname2 fips2 ctyname3 fips3

la var stname "State name"
la var ctyname "County name"

destring fips,gen(pfips)
gen var0="0"
egen pfips2=concat(var0 fips)
replace fips=pfips2 if pfips<10000
drop pfips pfips2

merge 1:1 fips using `t1'
keep if _merge==3
drop _merge

keep stname stfips ctyname ctyfips fips gdp*
order stname stfips ctyname ctyfips fips gdp*
compress
d
sum
save `t5'

********Part 2: Deal with counties with combination gdp
use `t4',clear
keep if combine==1
keep id fips gdp*
merge 1:1 fips using `t1'
drop if _merge==2
drop _merge
save `t11'

use `t4',clear
keep if combine==1
keep id fips2 gdp*
merge m:1 fips2 using `t2'
drop if _merge==2
drop _merge
save `t21'

use `t4',clear
keep if combine==1
keep id fips3 gdp*
keep if fips3!=""
merge m:1 fips3 using `t3'
drop if _merge==2
drop _merge
save `t31'

forval i=1/2{
merge 1:1 id using `t`i'1'
drop _merge
}

order id stname stfips ctyname ctyfips fips wkpop* fips2 fips3 gdp*
forval i=2015/2018{
egen totwkpop_`i'=rowtotal(wkpop_`i' wkpop_`i'_2 wkpop_`i'_3)
replace gdp_`i'=round(gdp_`i'*(wkpop_`i'/totwkpop_`i'))
}
keep stname stfips ctyname ctyfips fips gdp*
order stname stfips ctyname ctyfips fips gdp*
append using `t5'

la var fips "FIPS code of state-county"
forval i=2015/2018{
la var gdp_`i' "Total GDP in `i', Unit: thousands doller"
}
compress
d
sum
save US_county_gdp,replace
export exc using US_county_gdp.xlsx, first(var) replace
log close

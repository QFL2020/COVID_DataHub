set more off
log using US_county_Pop.log, replace
tempfile t t1 t2

* Covid-19 program
* April 2020
* Data from Census bureau
* Demographic structure of counties from 07/01/2010 to 07/01/2018
* Jiaolong He

use "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\cty_pop_demo",clear
d
sum

*fips code 
rename state stfips
rename county ctyfips
egen fips=concat(stfips ctyfips)

*year
tab year
drop if year<3
replace year=year+2007
tab year

*demographic structure
ren tot_pop tot
rename tot_male gender
save `t'

use `t', clear
keep fips year tot agegrp
reshape wide tot, i(fips year) j(agegrp)
save `t1'

use `t', clear
keep if agegrp==0
drop agegrp tot 
merge 1:1 fips year using `t1'
rename tot0 tot

*rename age group
forval i = 1/18{
rename tot`i' ageg`i'
}

*total count of race group
foreach x in h nhwa nhba nhia nhaa nhna{
gen `x'=`x'_male+`x'_female
}
drop *male *female

*proportion of age group and race group
foreach x in ageg1 ageg2 ageg3 ageg4 ageg5 ageg6 ageg7 ageg8 ageg9 ageg10 ageg11 ///
ageg12 ageg13 ageg14 ageg15 ageg16 ageg17 ageg18 gender ///
h nhwa nhba nhia nhaa nhna{
replace `x'=`x'/tot
}

*rename race group
rename h hispanic
rename nhwa nhwhite
rename nhba nhblack
rename nhia nhindian
rename nhaa nhasian
rename nhna nhhawaii
rename gender male

*prepare and reshape
rename a* a*_
rename n* n*_
rename hispanic hispanic_
rename tot tot_
rename male male_
drop _merge sumlev 
order stname stfips ctyname ctyfips fips year tot_ male_ 
reshape wide tot_-nhhawaii_, i(fips) j(year)

*label  
la var stname "State name"
la var stfips "State FIPS code"
la var ctyname "County name"
la var ctyfips "County FIPS code"
la var fips "FIPS code of state-county"

forval i=10/18{
la var tot_20`i' "Total pop. Count in 20`i'"
la var ageg18_20`i' "age 85+ prop. in 20`i'"
la var male_20`i' "male prop. in 20`i'"
la var hispanic_20`i' "Hispanic prop. in 20`i'"
la var nhwhite_20`i' "Not-Hispanic White alone prop. in 20`i'"
la var nhblack_20`i' "Not-Hispanic Black alone prop. in 20`i'"
la var nhindian_20`i' "Not-Hispanic American Indian and Alaska Native prop. in 20`i'"
la var nhasian_20`i' "Not-Hispanic Asian alone prop. in 20`i'"
la var nhhawaii_20`i' "Not-Hispanic Native Hawaiian and Other Pacific Islander prop. in 20`i'"
}
forval i=10/18{
forval j=1/17{
local a=(`j'-1)*5
local b=`a'+4
la var ageg`j'_20`i' "age `a'-`b' prop. in 20`i'"
}
}

order stname stfips ctyname ctyfips fips 
compress
d
sum

save US_county_Pop.dta, replace
export exc using US_county_Pop.xlsx, first(var) replace

log close

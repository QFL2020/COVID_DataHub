* Covid-19 program
* April 2020
* Data from Census bureau
* Demographic structure of counties from 07/01/2010 to 07/01/2018
* Jiaolong He
set more off
log using US_county_Pop.log, replace
tempfile t t1 t2

use "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 1 data release\Prepandemic\raw data\cty_pop_demo",clear
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
rename nhwa nh_white
rename nhba nh_black
rename nhia nh_indian_na
rename nhaa nh_asian
rename nhna nh_hawaii_na

*label  
la var stname "State name"
la var stfips "State FIPS code"
la var ctyname "County name"
la var ctyfips "County FIPS code"
la var fips "FIPS code of state-county"
la var tot "Total pop. Count"
la var ageg1 "age 0-4 prop."
la var ageg2 "age 5-9 prop."
la var ageg3 "age 10-14 prop."
la var ageg4 "age 15-19 prop."
la var ageg5 "age 20-24 prop."
la var ageg6 "age 25-29 prop."
la var ageg7 "age 30-34 prop."
la var ageg8 "age 35-39 prop."
la var ageg9 "age 40-44 prop."
la var ageg10 "age 45-49 prop."
la var ageg11 "age 50-54 prop."
la var ageg12 "age 55-59 prop."
la var ageg13 "age 60-64 prop."
la var ageg14 "age 65-69 prop."
la var ageg15 "age 70-74 prop."
la var ageg16 "age 75-79 prop."
la var ageg17 "age 80-84 prop."
la var ageg18 "age 85+ prop."

rename gender male
la var male "male prop."
 
la var hispanic "Hispanic prop."
la var nh_white "Not Hispanic White alone prop."
la var nh_black "Not Hispanic Black alone prop."
la var nh_indian_na "Not Hispanic American Indian and Alaska Native prop."
la var nh_asian "Not Hispanic Asian alone prop."
la var nh_hawaii_na "Not Hispanic Native Hawaiian and Other Pacific Islander prop."

keep stname stfips ctyname ctyfips fips year tot ageg1-ageg18 male hispanic nh_white nh_black nh_indian_na nh_asian nh_hawaii_na
order stname stfips ctyname ctyfips fips year tot ageg1-ageg18 male hispanic nh_white nh_black nh_indian_na nh_asian nh_hawaii_na
compress
d
sum

save US_county_Pop.dta, replace
export exc using US_county_Pop.xlsx, first(var) replace

log close

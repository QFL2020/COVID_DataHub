set more off
log using US_county_migration.log, replace
tempfile t t1

* Covid-19 program
* April 2020
* Data from Census bureau
* Estimated migration among counties from 2013 to 2017
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\mig_cty.csv",stringc(2 3) numericc(10 12)clear
d
sum
*fips code and name
gen b1 = substr(sta_code_b,-1,1)
tab b1
replace sta_code_b="00" if b1=="E"|b1=="I"|b1=="L"|b1=="M"|b1=="R"
rename sta_code_b stfips
replace stfips=substr(stfips,2,2)
drop if stfips=="72" | stfips=="00"
la var stfips "State FIPS code"

rename sta_name_b stname
format stname %20s
la var stname "State name"

gen b2 = substr(cty_code_b,-1,1)
tab b2
replace cty_code_b="000" if b2=="A"
rename cty_code_b ctyfips
drop if ctyfips=="000"
la var ctyfips "County FIPS code"

rename cty_name_b ctyname
la var ctyname "County name"

egen fips=concat(stfips ctyfips)
la var fips "FIPS code of state-county"
list stfips stname ctyfips ctyname fips in 1/10

*outmigration and inmigration
destring atbe,replace
sum atbe btae

bys fips:egen outmig2013_2017=sum(btae)
la var outmig "Outmigrants from 2013 to 2017"

bys fips:egen inmig2013_2017=sum(atbe)
la var inmig "Inmigrants from 2013 to 2017"

sum outmig inmig
list stfips stname ctyfips ctyname fips if outmig==0
list stfips stname ctyfips ctyname fips if inmig==0

*keep unique counties
sort fips
keep if fips!=fips[_n-1]

keep stname stfips ctyname ctyfips fips outmig inmig
order stname stfips ctyname ctyfips fips outmig inmig

compress
d
sum
export exc using US_county_migration.xlsx, first(var) replace
save US_county_migration.dta, replace

*check counties which are out of data
merge 1:1 fips using US_county_pop.dta,force
list stfips stname ctyfips ctyname fips tot* if _merge!=3
*Kenedy County and Terrell County are not in the data
*There are both tiny county within Texas

log close

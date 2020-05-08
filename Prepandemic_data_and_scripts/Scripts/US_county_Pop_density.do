set more off
log using US_county_Pop_density.log, replace
* Covid-19 program
* April 2020
* Population density of counties from 2010 to 2018
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\ACS_Total_Population_County.csv", stringc(6) clear
d
sum
list ïobjectid countygniscode geographicidentifierfipscode areaoflandsquaremeters areaofwatersquaremeters name state in 1/5 
keep geographicidentifierfipscode areaoflandsquaremeters name state
drop if state=="Puerto Rico"
* name 
rename state stname
la var stname "State name"

rename name ctyname
la var ctyname "County name"

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

rename areaoflandsquaremeters landarea
replace landarea=landarea/1000000

merge 1:m fips using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\intermediate steps\US_county_Pop.dta"
keep stname stfips ctyname ctyfips fips year landarea tot

gen popdensity_=tot/landarea
la var popdensity_ "Population density, # people per km2"
drop tot landarea

reshape8 wide popdensity,i(fips) j(year)
order stname stfips ctyname ctyfips fips 

compress
d
sum

save US_county_Pop_density,replace
export exc using US_county_Pop_density.xlsx, first(var) replace
log close

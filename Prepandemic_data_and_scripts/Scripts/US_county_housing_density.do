set more off
log using US_county_housing_density.log, replace

* Covid-19 program
* April 2020
* Census data
* Estimated housing density of counties from 07/01/2010 to 07/01/2018
* Jiaolong He

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\PEP_2018_PEPANNHU_with_ann.csv",rowr(2:)stringc(1 2 3) numericc(4 5 6 7 8 9 10 11 12 13 14)clear
d 
sum
list in 1/5
drop in 1

*name and fips code
split geodisplaylabel, parse(, )
list geodisplaylabel1 geodisplaylabel2 in 1/5

rename geodisplaylabel2 stname
la var stname "State name"

gen stfips = substr(geoid,10,2)
la var stfips "State FIPS code"

rename geodisplaylabel1 ctyname
la var ctyname "County name"

gen ctyfips = substr(geoid,12,3)
la var ctyfips "County FIPS code"

gen fips = substr(geoid,10,5)
la var fips "FIPS code of state-county"

list stname stfips ctyname ctyfips fips in 1/5
* housing unit
drop hucen42010 hubase42010
reshape long huest7,i(fips) j(year)
rename huest7 housing_
reshape wide housing_,i(fips) j(year)

merge 1:1 fips using US_county_Pop.dta
forval i=10/18{
gen houseper_20`i'=tot_20`i'/housing_20`i'
la var houseper_20`i' "# individual per housing unit in 20`i'"
}
keep stname stfips ctyname ctyfips fips houseper*
order stname stfips ctyname ctyfips fips houseper*
compress
d
sum

save US_county_housing_density,replace
export exc using US_county_housing_density.xlsx, first(var) replace
log close

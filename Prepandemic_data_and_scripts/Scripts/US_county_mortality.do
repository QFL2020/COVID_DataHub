set more off
log using US_county_mortality.log, replace

* Covid-19 program
* April 2020
* Mortality of 5 kinds disease of counties in 2018
* Jiaolong He

*give up those state and counties of PR
import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\mmr.csv",clear
d
sum
drop v1
drop if stfips==.
sum

*fips code
la var stname "State name"

replace stfips=100+stfips
tostring stfips,replace
replace stfips=substr(stfips,2,2)
la var stfips "State FIPS code"

la var ctyname "County name"

destring ctyfips, replace
replace ctyfips=1000+ctyfips
tostring ctyfips,replace
replace ctyfips=substr(ctyfips,2,3)
la var ctyfips "County FIPS code"

drop fips
egen fips=concat(stfips ctyfips)
la var fips "FIPS code of state-county"
list stname stfips ctyname ctyfips fips in 1/5

*check population:if they are equal, we make them as just one variable
drop *population *deaths

rename cardiovascular_cruderate cmortality_2018
la var cmortality "Crude death rate of cardiovascular diseases in 2018, # in 100,000"

rename diabetes_cruderate dmortality_2018
la var dmortality "Crude death rate of diabetes in 2018, # in 100,000"

rename mental_cruderate mmortality_2018
la var mmortality "Crude death rate of mental diseases in 2018, # in 100,000"

rename neoplasm_cruderate nmortality_2018
la var nmortality "Crude death rate of neoplasm in 2018, # in 100,000"

rename respiratory_cruderate rmortality_2018
la var rmortality_2018 "Crude death rate of respiratory diseases in 2018, # in 100,000"

merge 1:m fips using US_county_Pop
keep stname stfips ctyname ctyfips fips tot_2018 rmortality_2018 cmortality_2018 nmortality_2018 dmortality_2018 mmortality_2018
order stname stfips ctyname ctyfips fips tot_2018 rmortality_2018 cmortality_2018 nmortality_2018 dmortality_2018 mmortality_2018
compress
d
sum

save US_county_mortality,replace
export exc using US_county_mortality.xlsx, first(var) replace
log close

set more off
log using US_county_social_determinants.log,replace
tempfile t

* Covid-19 program
* May 2020
* Social determinant variables
* Jiaolong He
import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\Aggregated_Social_determinants.csv",varn(1) clear
d
sum
drop v1 population-v21 notproficientinenglish cilow cihigh female rural cilow1 cihigh1 hivcases smokerserrormargins smokerszscore zscore adultswithdiabetes

**district name and fips code
list stfips stname ctyfips ctyname fips in 1/5
rename fips fipsc
tostring fipsc,gen(fipscc)
gen a="0"
egen fips=concat(a fipscc) if fipsc < 10000
replace fips=fipscc if fips==""
drop a fipsc fipscc stfips ctyfips
la var fips "FIPS code of state-county"

gen stfips=substr(fips,1,2)
la var stfips "State FIPS code"

gen ctyfips=substr(fips,3,3)
la var ctyfips "County FIPS code"

la var stname "State name"
la var ctyname "County name"
**other social determinant variables
rename v23 languge
replace languge=languge/100
la var languge "Prop. of people not proficient in English based on ACS(2014-18)"

rename association association_2017
la var association_2017 "Count. of associations in 2017"

rename countyvalue associationrate_2017
la var associationrate_2017 "Association Rate in 2017, # per 10,000 people"

rename residentialsegregationblackwhite dissimwb
la var dissimwb "Dissimilarity Index for black-white residential segregation across census tracks"

rename residentialsegregationnonwhitewh dissimwn
la var dissimwn "Dissimilarity Index for white-nonwh residential segregation across census tracks"

rename smokerscountyvalue smoker
split smoker,parse("%")
destring smoker1,replace
drop smoker smoker2
rename smoker1 smoker_2017
replace smoker_2017=smoker_2017/100 if smoker_2017>1
la var smoker "Prop. of smoker in 2017"
destring fips,gen(fipss)
save `t'

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\HIV+Diabetes2016.csv",varn(1) clear
keep fips adultswithdiabetes hivprevalencerate

rename fips fipss
rename adultswithdiabetes diabetes_2016
replace diabetes_2016=diabetes_2016/100
la var diabetes_2016 "Prop. of adults aged 20 and above with diagnosed diabetes in 2016"

rename hivprevalencerate hiv_2016 
la var hiv_2016 "HIV Prevalence Rate in 2016, # per 100,000 people"

merge 1:1 fipss using `t'
keep stname stfips ctyname ctyfips fips languge diabetes_2016 association_2017 associationrate_2017 dissimwb dissimwn smoker_2017 hiv_2016
order stname stfips ctyname ctyfips fips languge diabetes_2016 association_2017 associationrate_2017 dissimwb dissimwn smoker_2017 hiv_2016
compress
d
sum
save US_county_social_determinants,replace
export delim using US_county_social_determinants.xlsx,  replace

log close

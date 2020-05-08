set more off
log using US_county_social_determinants.log,replace
tempfile t1 t2 t3 t4 t5 t6 t7 t8

* Covid-19 program
* May 2020
* Reshape long form data to be wide form data and merge those data as one data
* Jiaolong He
import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 2 data release\Prepandemic\raw data\Aggregated_Social_determinants.csv",varn(1) clear
d
sum
drop v1 population-v21 notproficientinenglish cilow cihigh female rural cilow1 cihigh1 hivcases smokerserrormargins smokerszscore zscore associations adultswithdiabetes

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
rename v23 languge_2018
replace languge_2018=languge_2018/100
la var languge_2018 "Prop. of people not proficient in English based on 2014-2018 ACS estimates"

rename countyvalue association_2017
la var association_2017 "Association Rate, # per 10,000 people"

rename residentialsegregationblackwhite resegwb
la var resegwb "Dissimilarity Index for black-white residential segregation across census tracks"

rename residentialsegregationnonwhitewh resegwn
la var resegwn "Dissimilarity Index for white-nonwh residential segregation across census tracks"

rename hivprevalencerate hiv 
split hiv,parse("H")
destring hiv1,replace
drop hiv hiv2
rename hiv1 hiv_2016
la var hiv_2016 "HIV Prevalence Rate, # per 100,000 people"

rename smokerscountyvalue smoker
split smoker,parse("%")
destring smoker1,replace
drop smoker smoker2
rename smoker1 smoker_2017
replace smoker_2017=smoker_2017/100 if smoker_2017>1
la var smoker "Prop. of smoker"

keep stname stfips ctyname ctyfips fips languge_2018 association_2017 resegwb resegwn smoker_2017 hiv_2016
order stname stfips ctyname ctyfips fips languge_2018 association_2017 resegwb resegwn smoker_2017 hiv_2016
compress
d
sum
save US_county_social_determinants,replace
export delim using US_county_social_determinants.xlsx,  replace

log close

set more off
log using US_county_tax_filling.log, replace
tempfile t 

* Covid-19 program
* April 2020
* Census data
* Estimated proportion of agi groups of counties in 2017
* Jiaolong He

**Get people aged 15+
use US_county_Pop.dta, clear
keep if year==2017
egen adprop=rowtotal(ageg4 ageg5 ageg6 ageg7 ageg8 ageg9 ageg10 ageg11 ageg12 ageg13 ageg14 ageg15 ageg16 ageg17 ageg18)
sum adprop 
gen adpop=int(tot*adprop)
la var adpop "Population of aged 15+"
keep stname stfips ctyname ctyfips fips tot adpop
save `t'

**Get income group
import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 1 data release\Prepandemic\raw data\17incyallagi.csv",rowr(2:)stringc(1 2 3 4) clear
d
sum

destring statefips, replace
replace statefips=100+statefips
tostring statefips,replace
gen stfips=substr(statefips,2,2)
la var stfips "State FIPS code"

ren countyname ctyname
la var ctyname "County name"

destring countyfips, replace
replace countyfips=1000+countyfips
tostring countyfips,replace
gen ctyfips=substr(countyfips,2,3)
la var ctyfips "County FIPS code"
drop if ctyfips=="000"

egen fips=concat(stfips ctyfips)
la var fips "FIPS code of state-county"
list stfips ctyname ctyfips fips in 1/5

keep stfips ctyfips ctyname fips agi_stub mars1 mars2 mars4
ren mars1 renums
ren mars2 renumm
ren mars4 renumh

replace renumm=renumm*2
egen renumg=rowtotal(renums renumm renumh)

keep stfips ctyfips ctyname fips agi_stub renumg
reshape wide renumg,i(fips) j(agi_stub)
egen renumt=rowtotal(renumg1 renumg2 renumg3 renumg4 renumg5 renumg6 renumg7 renumg8)

merge 1:1 fips using `t'
list stname ctyname if _merge==2
* Hawaii   Kalawao County is not included in tax filling statistics
keep if _merge==3
drop _merge

replace adpop=renumt if adpop < renumt
gen renumg9=adpop-renumt
sum renumg9
sum if renumg9<0

forval i=1/9{
gen agiprop`i'_2017=renumg`i'/adpop
}

sum agiprop*
la var agiprop1_2017 "Adjusted gross income group under $1 in 2017, prop."
la var agiprop2_2017 "Adjusted gross income group $[1,10000)  in 2017, prop."
la var agiprop3_2017 "Adjusted gross income group $[10000,25000)  in 2017, prop."
la var agiprop4_2017 "Adjusted gross income group $[25000,50000)  in 2017, prop."
la var agiprop5_2017 "Adjusted gross income group $[50000,75000)  in 2017, prop."
la var agiprop6_2017 "Adjusted gross income group $[75000,10000)  in 2017, prop."
la var agiprop7_2017 "Adjusted gross income group $[100000,200000)  in 2017, prop."
la var agiprop8_2017 "Adjusted gross income group $200000 and more  in 2017, prop."
la var agiprop9_2017 "Individuals without tax filing in 2017, prop."

keep stname stfips ctyname ctyfips fips agiprop1_2017-agiprop9_2017
order stname stfips ctyname ctyfips fips agiprop1_2017-agiprop9_2017 

compress
d
sum

save US_county_tax_filling,replace
export exc using US_county_tax_filling.xlsx, first(var) replace
log close


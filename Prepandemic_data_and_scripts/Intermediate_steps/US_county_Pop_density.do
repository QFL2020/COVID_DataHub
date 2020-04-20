* Covid-19 program
* April 2020
* Population density of counties in 2018
* Jiaolong He
set more off
log using US_county_Pop_density.log, replace

import delim using "C:\Users\Administrator\Dropbox\HPC_data_hub\Phase 1 data release\Prepandemic\raw data\USA_area.csv", stringc(6) clear
d
sum
list in 1/5
drop v1 country

* name 
rename state stname
la var stname "State name"

rename county ctyname
la var ctyname "County name"

la var fips "FIPS code of state-county"
list stname ctyname if fips=="NA"
/*
 641. |  Illinois         La Salle |
 741. |   Indiana    Lake Michigan |
1273. |  Michigan      Lake Hurron |
1274. |  Michigan    Lake Michigan |
1275. |  Michigan   Lake St. Clair |
      |----------------------------|
1276. |  Michigan    Lake Superior |
1356. | Minnesota    Lake Superior |
1855. |  New York     Lake Ontario |
2090. |      Ohio        Lake Erie |
3085. | Wisconsin    Lake Michigan |
      |----------------------------|
3086. | Wisconsin    Lake Superior |
*/
drop if fips=="NA"

rename area_sqkm area

merge 1:m fips using US_county_Pop.dta
list stname ctyname fips if _merge==2 & fips!=fips[_n-1]

/*
 3746. |   Alaska   Hoonah-Angoon Census Area   02105 |
 3787. |   Alaska        Kusilvak Census Area   02158 |
 3836. |   Alaska          Petersburg Borough   02195 |
12869. | Maryland              Baltimore city   24510 |
15918. | Missouri              St. Louis city   29510 |
*/

keep if _merge==3

list fips ctyname area in 1
replace area=29446 if fips=="02105"
replace area=50943 if fips=="02158"
replace area=119.3 if fips=="02195"
replace area=238.41 if fips=="24510"
replace area=170 if fips=="29510"

gen popdensity=tot/area
la var popdensity "Population density, # people per km2"

keep stname stfips ctyname ctyfips fips year popdensity
compress
d
sum

save US_county_Pop_density,replace
export exc using US_county_Pop_density.xlsx, first(var) replace
log close

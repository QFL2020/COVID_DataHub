# HPC_DataHub
COVID-19 Data Hub from Hopkins Population Center

HPC Data Hub Team
Faculty: Dr. Qingfeng Li (lead), Dr. Alexandre White, Dr. Lingxin Hao
Students: Aditya Suru, Jiaolong He, Gwyneth Wei

HPC Data Hub Phase 1 Release
4/13/2020

The HPC Data Hub is a newly establish data service infrastructure of Hopkins Population Center, with its inception on 3/31/2020. The HPC Data Hub is currently focusing on providing critical data at the county level in the United Stated necessary for population-based research on Covid19 from demographic and social science perspectives and provide evidence-based, timely policy recommendations for curbing the pandemic.

We plan to release the HPC Data Hub data by phases. The data are public accessible at github repository. The metadata documentation HPC_Data_Hub_Metadata_Phase1.xlsx provides the basic information for users. The repository site includes codes and methodology of our data curations (including quality control) as well as original data sources’ methodological documentation.

The success of HPC Data Hub relies on users’ questions, feedback, and suggestions. We are building a users’ listserv. The HPC Data Hub team is devoted to timely responding to users’ questions and suggestions. 


Table 1. Summary of HUC Data Hub Phase 1 Release: County Level (a total of 440 variables covering pre- and during-Covid19 periods)
Type	variable	Number of variables	format	Time metric	period
Covid19	year-mn-dt_cases	77	Timeseries (count)	daily	1/21/2020 – 4/6/2020
	year-mn-dt_deaths	77	Timeseries (count)	daily	Timeseries (counts)
Policy action	(details)	9	timing		
	(details)	8	Binary (yes/no)		
unemployment	Labor force	14	count	monthly	Dec2018-Jan2020
	Unemployment rate	14	rate	monthly	
Cause-specific mortality	Based population	4	count	annual	2018 deaths	4	count		 2018
2018 Crude rate	4	rate		 
Pop. Density per km-2	Popdensity
	8	rate	annual	2010-2018
Pop. Density per housing unit	Houseper
	8	rate	annual	2010-2018
Tax filing income brackets and non-filing	agigrop1-agiprop9	9	proportion	annual	2017
Population 	Total counts	8	count	annual	2010-2018
	ageg1-ageg18	8*18	proportion	annual	2010-2018
	male	8	proportion	annual	2010-2018
	Hispanic	8	proportion	annual	2010-2018
	nH_White	8	proportion	annual	2010-2018
	nH_Black	8	proportion	annual	2010-2018
	nH_Indian_Na	8	proportion	annual	2010-2018
	nH_Asian	8	proportion	annual	2010-2018
	nH_Hawaii_Na	8	proportion	annual	2010-2018
Notes:
Geo Code
	stfips	stname	ctyfips	ctyname	fips
Covid19 (confirmed cases and dealths, 77 time points)
	2020-01-21_cases	2020-01-22_cases
	2020-01-23_cases	2020-01-24_cases	2020-01-25_cases	2020-01-26_cases	2020-01-27_cases	2020-01-28_cases	2020-01-29_cases	2020-01-30_cases	2020-01-31_cases	2020-02-01_cases	2020-02-02_cases	2020-02-03_cases	2020-02-04_cases	2020-02-05_cases	2020-02-06_cases	2020-02-07_cases	2020-02-08_cases	2020-02-09_cases	2020-02-10_cases	2020-02-11_cases	2020-02-12_cases	2020-02-13_cases	2020-02-14_cases	2020-02-15_cases	2020-02-16_cases	2020-02-17_cases	2020-02-18_cases	2020-02-19_cases	2020-02-20_cases	2020-02-21_cases	2020-02-22_cases	2020-02-23_cases	2020-02-24_cases	2020-02-25_cases	2020-02-26_cases	2020-02-27_cases	2020-02-28_cases	2020-02-29_cases	2020-03-01_cases	2020-03-02_cases	2020-03-03_cases	2020-03-04_cases	2020-03-05_cases	2020-03-06_cases	2020-03-07_cases	2020-03-08_cases	2020-03-09_cases	2020-03-10_cases	2020-03-11_cases	2020-03-12_cases	2020-03-13_cases	2020-03-14_cases	2020-03-15_cases	2020-03-16_cases	2020-03-17_cases	2020-03-18_cases	2020-03-19_cases	2020-03-20_cases	2020-03-21_cases	2020-03-22_cases	2020-03-23_cases	2020-03-24_cases	2020-03-25_cases	2020-03-26_cases	2020-03-27_cases	2020-03-28_cases	2020-03-29_cases	2020-03-30_cases	2020-03-31_cases	2020-04-01_cases	2020-04-02_cases	2020-04-03_cases	2020-04-04_cases	2020-04-05_cases	2020-04-06_cases	2020-01-21_deaths	2020-01-22_deaths	2020-01-23_deaths	2020-01-24_deaths	2020-01-25_deaths	2020-01-26_deaths	2020-01-27_deaths	2020-01-28_deaths	2020-01-29_deaths	2020-01-30_deaths	2020-01-31_deaths	2020-02-01_deaths	2020-02-02_deaths	2020-02-03_deaths	2020-02-04_deaths	2020-02-05_deaths	2020-02-06_deaths	2020-02-07_deaths	2020-02-08_deaths	2020-02-09_deaths	2020-02-10_deaths	2020-02-11_deaths	2020-02-12_deaths	2020-02-13_deaths	2020-02-14_deaths	2020-02-15_deaths	2020-02-16_deaths	2020-02-17_deaths	2020-02-18_deaths	2020-02-19_deaths	2020-02-20_deaths	2020-02-21_deaths	2020-02-22_deaths	2020-02-23_deaths	2020-02-24_deaths	2020-02-25_deaths	2020-02-26_deaths	2020-02-27_deaths	2020-02-28_deaths	2020-02-29_deaths	2020-03-01_deaths	2020-03-02_deaths	2020-03-03_deaths	2020-03-04_deaths	2020-03-05_deaths	2020-03-06_deaths	2020-03-07_deaths	2020-03-08_deaths	2020-03-09_deaths	2020-03-10_deaths	2020-03-11_deaths	2020-03-12_deaths	2020-03-13_deaths	2020-03-14_deaths	2020-03-15_deaths	2020-03-16_deaths	2020-03-17_deaths	2020-03-18_deaths	2020-03-19_deaths	2020-03-20_deaths	2020-03-21_deaths	2020-03-22_deaths	2020-03-23_deaths	2020-03-24_deaths	2020-03-25_deaths	2020-03-26_deaths	2020-03-27_deaths	2020-03-28_deaths	2020-03-29_deaths	2020-03-30_deaths	2020-03-31_deaths	2020-04-01_deaths	2020-04-02_deaths	2020-04-03_deaths	2020-04-04_deaths	2020-04-05_deaths	2020-04-06_deaths	
Policy Action
Timing (year-mn-dt) 9 variables
emergency
k12	
dayCare	
nursing_visitorBan	
stayAtHome_declare	
nonEssentaialBusiness_closed	
closed_restaurants	
closed_gyms	
closed_movieTheatres	

Binary (0/1) 8 variables
Froze_evictions	
Froze_utilityShutoff	
Froze_mortgagePayments	
relegiousGathering	
AlcoholStores_open	
firearms_open	
Medical_expansion	
Paid_sick_leaves

Cause-specific base population, cases, and mortality rate (4 causes of death) 4x3=12 variables
c_population	
cardiovascular_deaths	
cardiovascular_crudeRate	
d_population	
diabetes_deaths	
diabetes_crudeRate	
m_population	
mental_deaths	
mental_crudeRate	
n_population	
neoplasm_deaths	
neoplasm_crudeRate

# HPC_DataHub
COVID-19 Data Hub from Hopkins Population Center

HPC Data Hub Team
Faculty: Dr. Qingfeng Li (lead), Dr. Alexandre White, Dr. Lingxin Hao
Students: Aditya Suru, Jiaolong He, Gwyneth Wei


HPC Data Hub Phase 1 Release
4/15/2020

The HPC Data Hub is a newly establish data service infrastructure of Hopkins Population Center (HPC), with its inception on 3/31/2020. The HPC Data Hub is currently focusing on providing critical data at the county level in the United Stated necessary for population-based research on COVID-19 from demographic and social science perspectives and provide evidence-based, timely policy recommendations for curbing the pandemic. As the last few weeks have demonstrated, more timely and effective data on social, economic and health disparities are needed to provide the analysis we need to move ahead of this pandemic and respond appropriately as situations change. 

We plan to release the HPC Data Hub data in phases. The data are publicly accessible at our Github repository ( https://github.com/QFL2020/HPC_DataHub ). The metadata documentation HPC_Data_Hub_Metadata_Phase1.xlsx provides the basic information for users. The repository site includes codes and methodology of our data curations as well as original data sources’ methodological documentation.

The success of HPC Data Hub relies on users’ questions, feedback, and suggestions. We are building a users’ listserv. The HPC Data Hub team is devoted to timely responding to users’ questions and suggestions. 

HPC Data Hub Team
Faculty: Dr. Qingfeng Li (lead), Dr. Alexandre White, Dr. Lingxin Hao
Students: Aditya Suru, Jiaolong He, Gwyneth Wei

Table 1. Summary of HPC Data Hub Phase 1 Release: County Level (a total of 440 variables covering pre and during COVID-19 periods)
Type	variable	Number of variables	format	Time metric	period
COVID-19	year-mn-dt_cases	77	timeseries (count)	daily	1/21/2020 – present
	year-mn-dt_deaths	77	timeseries (count)	daily	1/21/2020 - present
Policy action	(details)	9	timing		
	(details)	8	binary (yes/no)		
unemployment	Labor force	14	count	monthly	Dec2018-Jan2020
	Unemployment rate	14	rate	monthly	Dec2018-Jan2020
Cause-specific mortality	Based population	4	count	annual	2018
	deaths	4	count		2018
	Crude rate	4	rate		 
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


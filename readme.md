# Agricultural Land Inequality Measures
The repository contains data files (in Stata format) for different waves of the FAO's Agricultural Census. Each is named "faocensus_YYYY.dta". Each data file has the number of holdings in each "bin" (e.g. holdings with between 5-9 hectares) as well as the total hectares held by those holdings. From this data, one can calculate a Gini coefficient, as well as other measures of inequality. 

Each wave of the FAO Ag Census used different standards, so the number of bins in each wave are not comparable. The script "fao_calc.do" calculates a Gini and a symmetry index for each wave separately, then appends the various waves together into a final dataset "faocensus_all.dta". 

The dataset for "faocensus_2000.dta" was updated in 2015/16 with the latest available census data from the FAO, but more could have been added since then. It should be obvious how to add a new country/census row to the dataset to include in the calculations.

# Replication data for Vollrath (2007)
The files named "agprodXXX" are replication scripts and data files for my paper in the AJAE from 2007 on inequality and ag. production. 

1. agprodols.dta - STATA file for the OLS regressions in table 4
2. agprodols.do - do-file that replicates the results in table 4
3. agprodpanel.dta - STATA file for panel regressions in table 6
4. agprodpanel.do - do-file that replicates the results in table 6

The files were created using STATA version 9.
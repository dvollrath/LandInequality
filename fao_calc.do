/*
The script takes in separate data files for each wave of ag census.
Each ag census wave operated under different rules, so the number of categories 
reported varies from wave to wave.

With the available categories in a given wave, the script calculates the Gini and
a symmetry index (is inequality driven by a few large farms, or by a few small ones?)

After calculations are done for each wave, the waves are appended together for final
data set.

*/

cd ~/Dropbox/ArchiveProject/LandIneq/agprodstata

foreach year in 1950 1960 1970 1980 1990 2000 {
	use "faocensus_`year'.dta", clear
	save "faocensus_`year'_calc.dta", replace

	preserve // number of bins varies by year, so need to capture that number
		keep hold_bin*
		describe hold_bin*
		local bins = r(k)
		di "Number of bins: " r(k)
	restore

	gen hold_bin0 = 0 // placeholder for 0th bin
	move hold_bin0 hold_bin1 // variables need to be in order
	gen area_bin0 = 0 // placeholder for 0th bin
	move area_bin0 area_bin1 // variables need to be in order

	egen tot_hold = rsum(hold_bin*) // total holdings
	egen tot_area = rsum(area_bin*) // total area of holdings
	gen ave_size = tot_area/tot_hold // average farm size

	// replace area with share of total area for Gini calculation
	foreach x of varlist area_bin* {
		replace `x' = `x'/tot_area 
	}
	// replace missing holding data with zeros to allow Gini calculation
	foreach x of varlist hold_bin* {
		replace `x' = 0 if `x'==.
	}

	// Initialize sums
	gen sum = 0 // Gini summation
	gen sum_F = 0 // sub-sum for symmetry calc
	gen sum_L = 0 // sub-sum for symmetry calc

	// Cycle through bins, doing cumulative sums and adding up for Gini and symmetry coefficients

	local binsminus = `bins' - 1 // need one less than total number of bins

	forvalues z = 0/`binsminus' { // for bin 0 through next to last bin
		local zplus = `z' + 1 // need index plus one for calculations
		qui egen cum_bin`z' = rsum(area_bin0-area_bin`z') // cumulative land area through z
		qui egen cum_bin_`z'plus = rsum(area_bin0-area_bin`zplus') // cum land area through z plus one
		qui gen cum_tot`z' = cum_bin`z' + cum_bin_`z'plus
		// Add area of trapezoid between z and zplus to the running sum for Gini coefficient
		qui replace sum = .5*(hold_bin`zplus'/tot_hold)*cum_tot`z' + sum 

		qui gen ave_size_bin`z' = area_bin`z'*tot_area/hold_bin`z' // avg size of each bin
		qui replace sum_F = sum_F + hold_bin`z' if ave_size_bin`z'<ave_size // running sum for # holdings with < avg. size
		qui replace sum_L = sum_L + area_bin`z'*tot_area if ave_size_bin`z'<ave_size // run sum for # Ha on < avg. size farms
		// Note that above logic works b/c bins with 0 hold or area will be below ave, but also add nothing to total
	}

	// Sum captures area below Lorenz curve. Gini is area above Gini Lorenz
	gen G = 1 - 2*sum
	// Symmetry sums % farms less than avg. size plus % HA on farms less than avg. size
	gen S = sum_F/tot_hold + sum_L/tot_area // Symmetry coefficient

	drop cum_bin* // clean up
	drop cum_tot* // clean up
	drop ave_size_bin* // clean up
	drop hold_bin* // remove because these won't match across datasets
	drop area_bin* // remove because these won't match across datasets

	save "faocensus_`year'_calc.dta", replace
}

// Append all datasets to one master dataset
use "faocensus_1950_calc.dta", clear
save "faocensus_all.dta", replace
foreach year in 1960 1970 1980 1990 2000 {
	append using "faocensus_`year'_calc.dta"
}
save "faocensus_all.dta", replace

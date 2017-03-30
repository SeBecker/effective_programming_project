/*
The file "adjust_panel.do" tells stata that the data set has a panel (code_numeric) and time series structure (year_numeric).
Furthermore it sorts the data set relating to the country code and the specific year of observations, generates country and year specific dummies to prepare the data set for fixed effects analysis. Last but not least the data set is saved in *bld/src/data_management* such that continuing operations doesn't effect the original data set.


*/


// Header do-File with path definitions, those end up in global macros.

include project_paths
log using `"${PATH_OUT_DATA}/log/`1'.log"', replace

use "${PATH_IN_DATA}/`2'_panel"

tsset code_numeric year_numeric
sort code_numeric year_numeric
tab year, gen (yr)
tab code, gen(cd)

if "`2'"== "5_year" {
    ssc install xtabond2, replace
    }


save "${PATH_OUT_DATA}/`2'_panel_all", replace


log close

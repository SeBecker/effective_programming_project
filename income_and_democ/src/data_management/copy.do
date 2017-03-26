/*
The file "copy.do" opens the original data set and saves a copy in *bld/src/data_managament* such that continuing operations doesn't effect the original data set.

*/


// Header do-File with path definitions, those end up in global macros.
include project_paths
log using `"${PATH_OUT_DATA}/log/`1'.log"', replace

use "${PATH_IN_DATA}/`2'"

save "${PATH_OUT_DATA}/`2'_all", replace


log close

/*
The file "add_new_data.do" adds the new data from AJR (2005) to the
dataset as described in Albouy (2012).

*/


// Header do-File with path definitions, those end up in global macros.
include project_paths
log using `"${PATH_OUT_DATA}/log/`1'.log"', replace

use "${PATH_IN_DATA}/`2'"

save "${PATH_OUT_DATA}/`2'_all", replace


log close

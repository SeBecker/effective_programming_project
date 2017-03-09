

// Read in the model controls
include project_paths



log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace



do `"${PATH_OUT_MODEL_SPECS}/`2'"'

use `"${PATH_OUT_DATA}`2'_all"'

twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}")  legend(off) xscale(r(0 4.5))

graph export `"${PATH_OUT_FIGURES}/`2'.eps"', replace



log close




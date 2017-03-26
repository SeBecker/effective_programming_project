

// Read in the model controls
include project_paths



log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace



do `"${PATH_OUT_MODEL_SPECS}/`2'"'

use `"${PATH_OUT_DATA}`2'_all"'

ge x = "`2'"

if x=="F1" {
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off) xscale(r(6 10.6))

}

else if x=="F2"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if x=="F3"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if x=="F4"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if x=="F6" {
    reg ${DEPVAR1} ${DEPVAR2} ${INDEP1} ${INDEP2} ${DUMMY}
    reg ${DEPVAR1} ${INDEP1} ${INDEP2} ${DUMMY} if e(sample)==1
    predict ${RESID1}, residuals
    reg ${DEPVAR2} ${INDEP1} ${INDEP2} ${DUMMY} if e(sample)==1
    predict ${RESID2}, residuals



    twoway (scatter ${RESID1} ${RESID2} if e(sample)==1, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${RESID1} ${RESID2} if e(sample)==1, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") t2title(${T2TITLE}, size(medium)) legend(off)
}

else {
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}")  legend(off) xscale(r(0 4.5))

}

graph export `"${PATH_OUT_FIGURES}/`2'.png"', replace


log close




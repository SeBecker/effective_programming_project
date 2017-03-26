/*
The file "figures.do" generates Figure 1 to 6 from Acemoglu 2008 :cite:`Acemoglu1`. First the file creates a log file in *bld/final/log* and load the individual specifications from *bld/src/model_specs*. Dependent on the specific do file which is loaded it generates a figure and saves the result in *bld/out/figures*. The process for figure 1 to 5 differs only in respect of the scaling. To show the dependency of changes in GDP and democracy independent from historical factors, the creation process of figure 6 includes several regressions to predict their specific residuals and implement them into the figure.
*/


// Read in the model controls
include project_paths



log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace



do `"${PATH_OUT_MODEL_SPECS}/`2'"'

use `"${PATH_OUT_DATA}`2'_all"'


if "`2'"=="F1" {
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off) xscale(r(6 10.6))

}

else if "`2'"=="F2"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if "`2'"=="F3"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if "`2'"=="F4"{
    twoway (scatter ${DEPVAR} ${INDEP}, msymbol(none) mlabel(code) mlabsize(tiny)) (lfit ${DEPVAR} ${INDEP}, clcolor(black)), ytitle("${YTITLE}") xtitle("${XTITLE}") title("${TITLE}") subtitle("${SUBTITLE}") legend(off)

}

else if "`2'"=="F6" {
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




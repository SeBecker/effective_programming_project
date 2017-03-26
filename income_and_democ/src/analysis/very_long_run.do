/*
The file "yery_long_run.do" replicates the estimation for Table 8A and 8B from Acemoglu 2008 s.833 :cite:`Acemoglu1`. First the file creates a log file in *bld/out/analysis/log* and loads the model specifications from *bld/src/model_specs/very_long.do*.
I

*/









// Read in the model controls
include project_paths

log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/very_long"'

use `"${PATH_OUT_DATA}//500_year_panel_all"'


// Table A column 1

reg ${DEPVAR} ${INDEP1} if ${DUMMY2}==1, cluster(madid)

mat A_1= [_b[${INDEP1}]\ _se[${INDEP1}]\ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ e(N) \ e(r2) ]

// Table A column 2

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} if ${DUMMY2}==1, cluster(madid)

test ${INDEP2} ${INDEP3}

mat A_2= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ . \ . \ . \ . \ . \ . \ r(p) \ e(N) \ e(r2) ]

// Table A column 3

reg ${DEPVAR} ${INDEP1} ${INDEP4} if ${DUMMY2}==1, cluster(madid)

test  ${LIST1} ${LIST3} ${LIST2}

mat A_3= [_b[${INDEP1}]\ _se[${INDEP1}]\ . \ . \ . \ . \ _b[${LIST1}] \ _se[${LIST1}]\ _b[${LIST2}] \ _se[${LIST2}] \ _b[${LIST3}] \ _se[${LIST3}] \ r(p) \ e(N) \ e(r2) ]

// Table A column 4

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} ${INDEP4} if ${DUMMY2}==1, cluster(madid)

test ${INDEP2} ${INDEP3}  ${LIST1} ${LIST3} ${LIST2}

mat A_4= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ _b[${LIST1}] \ _se[${LIST1}]\ _b[${LIST2}] \ _se[${LIST2}] \ _b[${LIST3}] \ _se[${LIST3}] \ r(p) \ e(N) \ e(r2) ]

// Table B col 1

reg ${DEPVAR} ${INDEP1} if ${DUMMY1}==1, cluster(madid)

mat B_1= [_b[${INDEP1}]\ _se[${INDEP1}]\ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ e(N) \ e(r2) ]

// Table B col 2

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} if ${DUMMY1}==1, cluster(madid)

test ${INDEP2} ${INDEP3}

mat B_2= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ . \ . \ . \ . \ . \ . \ . \ . \ r(p) \ e(N) \ e(r2) ]

// Table B col 3

reg ${DEPVAR} ${INDEP1} ${INDEP4} if ${DUMMY1}==1, cluster(madid)

test ${LIST1} ${LIST3} ${LIST2}

mat B_3= [_b[${INDEP1}]\ _se[${INDEP1}]\ . \ . \ . \ . \ _b[${LIST1}] \ _se[${LIST1}] \ _b[${LIST2}] \ _se[${LIST2}] \ _b[${LIST3}] \ _se[${LIST3}] \ . \ . \ r(p) \ e(N) \ e(r2) ]

// Table B col 4

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} ${INDEP4} if ${DUMMY1}==1, cluster(madid)

test ${INDEP2} ${INDEP3}  ${LIST1} ${LIST3} ${LIST2}

mat B_4= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ _b[${LIST1}] \ _se[${LIST1}] \ _b[${LIST2}] \ _se[${LIST2}] \ _b[${LIST3}] \ _se[${LIST3}] \ . \ . \ r(p) \ e(N) \ e(r2) ]

// Table B col 5

reg ${DEPVAR} ${INDEP1} ${INDEP5} if ${DUMMY1}==1, cluster(madid)

test ${INDEP5}

mat B_5= [_b[${INDEP1}]\ _se[${INDEP1}]\ . \ . \ . \ . \ . \ . \ . \ . \ . \ . \ _b[${INDEP5}] \ _se[${INDEP5}] \ r(p) \ e(N) \ e(r2) ]

// Table B col 6

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} ${INDEP5} if ${DUMMY1}==1, cluster(madid)

test ${INDEP2} ${INDEP3} ${INDEP5}

mat B_6= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ . \ . \ . \ . \ . \ . \ _b[${INDEP5}] \ _se[${INDEP5}] \ r(p) \ e(N) \ e(r2) ]

// Table B col 7

reg ${DEPVAR} ${INDEP1} ${INDEP2} ${INDEP3} ${INDEP4} ${INDEP5} if ${DUMMY1}==1, cluster(madid)

test ${INDEP2} ${INDEP3} ${INDEP5} ${LIST1} ${LIST2} ${LIST3}

mat B_7= [_b[${INDEP1}]\ _se[${INDEP1}]\ _b[${INDEP2}] \ _se[${INDEP2}] \ _b[${INDEP3}] \ _se[${INDEP3}] \ _b[${LIST1}] \ _se[${LIST1}] \ _b[${LIST2}] \ _se[${LIST2}] \ _b[${LIST3}] \ _se[${LIST3}] \ _b[${INDEP5}] \ _se[${INDEP5}] \ r(p) \ e(N) \ e(r2) ]





mat A =[ A_1, A_2, A_3, A_4]

svmat A,names(A_)
format A_1 A_2 A_3 A_4 %9.3f
gen id = _n
sort id
drop if id>15
gen str A_colstring = "Change in log GDP per capita \\ over sample period" if id==1
replace A_colstring = "" if id==2
replace A_colstring = "Constraint on the executive at \\ independence" if id==3
replace A_colstring = "" if id==4
replace A_colstring = "Independence year/100" if id==5
replace A_colstring = "" if id==6
replace A_colstring = "Fraction Muslim" if id==7
replace A_colstring = "" if id==8
replace A_colstring = "Fraction Protestant" if id==9
replace A_colstring = "" if id==10
replace A_colstring = "Fraction Catholic" if id==11
replace A_colstring = "" if id==12
replace A_colstring = "Historical factors F-test" if id==13
replace A_colstring = "Observations" if id==14
replace A_colstring = "R-squared" if id==15

keep A_colstring A_1 A_2 A_3 A_4

save `"${PATH_OUT_ANALYSIS}/very_long_A"' , replace

mat B = [B_1, B_2, B_3, B_4, B_5, B_6, B_7]

svmat B,names(B_)
format B_1 B_2 B_3 B_4 B_5 B_6 B_7 %9.3f
gen id = _n
sort id
drop if id>17

gen str B_colstring = "Change in log GDP per capita \\ over sample period" if id==1
replace B_colstring = "" if id==2
replace B_colstring = "Constraint on the executive at \\ independence" if id==3
replace B_colstring = "" if id==4
replace B_colstring = "Independence year/100" if id==5
replace B_colstring = "" if id==6
replace B_colstring = "Fraction Muslim" if id==7
replace B_colstring = "" if id==8
replace B_colstring = "Fraction Protestant" if id==9
replace B_colstring = "" if id==10
replace B_colstring = "Fraction Catholic" if id==11
replace B_colstring = "" if id==12
replace B_colstring = "Log population density, 1500" if id==13
replace B_colstring = "" if id==14
replace B_colstring = "Historical factors F-test" if id==15
replace B_colstring = "Observations" if id==16
replace B_colstring = "R-squared" if id==17

keep B_colstring B_1 B_2 B_3 B_4 B_5 B_6 B_7


save `"${PATH_OUT_ANALYSIS}/very_long_B"' , replace
















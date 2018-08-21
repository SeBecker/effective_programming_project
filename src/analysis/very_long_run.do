/*
The file "very_long_run.do" replicates the estimation for Table 8A and 8B from Acemoglu 2008 s.833/834 :cite:`Acemoglu1`. First the file creates a log file in *bld/out/analysis/log* and loads the model specifications from *bld/src/model_specs/very_long.do* (see also :ref:`Model specification very_long`) and the 500 year data set from *bld/out/data*.

The following regressions are run:

Base sample 1500-2000
=====================

OLS 1
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 125

    OLS regression of ${DEPVAR} on ${INDEP1}. Observations are only included if ${DUMMY2} equals 1. Standard errors are robust and clustured by level of aggregation for 1500 income data (madid).

OLS 2
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 131

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP2} and {INDEP3}. Observations are only included if ${DUMMY2} equals 1. Standard errors are robust and clustured by level of aggregation for 1500 income data (madid). Furthermore a joint significance test is performed for all variables but ${INDEP1}.

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 133

OLS 3
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 139

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP4} (see also :ref:`Model specification very_long`). Observations are only included if ${DUMMY2} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). Furthermore a joint significance test is performed for all variables but ${INDEP1} .

OLS 4
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 147

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP4}, {INDEP2} and ${INDEP3} (see also :ref:`Model specification very_long`). Observations are only included if ${DUMMY2} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). Furthermore a joint significance test is performed for all variables but ${INDEP1} .


Former colony sample
====================

The following regressions include only former colonies (${DUMMY}==1).

OLS1
----
    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 155

    OLS regression of ${DEPVAR} on ${INDEP1}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustured by level of aggregation for 1500 income data (madid).

OLS 2
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 161

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP2} and {INDEP3}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustured by level of aggregation for 1500 income data (madid). Furthermore a joint significance test is performed for all variables but ${INDEP1} .


OLS 3
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 169

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP4}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). As before a joint significance test is performed for all variables but ${INDEP1} .

OLS 4
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 177

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP4}, {INDEP2} and ${INDEP3}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). As in OLS 2, a joint significance test is performed for all variables but ${INDEP1} .


OLS 5
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 185

    OLS regression of ${DEPVAR} on ${INDEP1} and ${INDEP5}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). As in OLS 2, a joint significance test is performed for all variables but ${INDEP1} .


OLS 6
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 193

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP5}, ${INDEP2} and ${INDEP3}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). As in OLS 2, a joint significance test is performed for all variables but ${INDEP1} .



OLS 7
-----

    .. literalinclude:: ../../src/analysis/very_long_run.do
        :lines: 201

    OLS regression of ${DEPVAR} on ${INDEP1}, ${INDEP5}, ${INDEP4} ${INDEP2} and ${INDEP3}. Observations are only included if ${DUMMY1} equals 1. Standard errors are robust and clustered by level of aggregation for 1500 income data (madid). As in OLS 2, a joint significance test is performed for all variables but ${INDEP1} .


*/

// Read in the model controls
include project_paths

log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/very_long"'

use `"${PATH_OUT_DATA}//500_year_data_all"'


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
















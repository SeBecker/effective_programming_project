// Read in the model controls


include project_paths


log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/`2'"'

local inst = "${INST1} ${INST2}"


foreach i in `inst' {
    use `"${PATH_OUT_ANALYSIS}/`2'_`i'up_IVestimation_results"', clear
    sca def x = "`i'"

    if x == "nsave" {
        listtab `i'_up_colstring `i'_up_1 `i'_up_2 `i'_up_3 `i'_up_4 `i'_up_5 `i'_up_6 `i'_up_7 `i'_up_8 `i'_up_9 ///
            using `"${PATH_OUT_TABLES}/`2'_`i'_IVtable.tex"', replace type rstyle(tabular) ///
            head("\begin{table}[htb]" "\caption{Fixed Effects Results Using ${TABLETITLE}  Measure of Democracy: Two-Stage Least Squares with ${IVTITEL1}}" ///
            "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccccccc}" ///
            "\toprule" ///
            "& \multicolumn{9}{c}{Base Sample, 1960-2000} \\" ///
            "\midrule" ///
            "& \multicolumn{9}{c}{All countries} \\" ///
            "\midrule" ///
            "& \begin{tabular}[c]{@{}c@{}} Pooled \\ OLS\end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS\end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Arellano- \\ Bond GMM \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular} \\ " ///
            " & (1) & (2) & (3) & (4) & (5) & (6) & (7) & (8) & (9)\\" ///
            "\midrule" ///
            "Panel A & \multicolumn{9}{c}{\textit{Dependent variable is democracy}:}\\ " ///
            "\midrule" ) ///

        use `"${PATH_OUT_ANALYSIS}/`2'_`i'do_IVestimation_results"', clear

        listtab `i'_do_colstring `i'_do_1 `i'_do_2 `i'_do_3 `i'_do_4 `i'_do_5 `i'_do_6 `i'_do_7 `i'_do_8 `i'_do_9, ///
            appendto(`"${PATH_OUT_TABLES}/`2'_`i'_IVtable.tex"') type rstyle(tabular) ///
            head("\midrule" ///
            "Panel B & \multicolumn{9}{c}{\textit{First stage for Log Gdp per capita t-1}:}\\" ///
            "\midrule" ) ///
            foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )
    }


    else if x == "worldincome"{
        listtab `i'_up_colstring `i'_up_1 `i'_up_2 `i'_up_3 `i'_up_4 `i'_up_5 `i'_up_6 `i'_up_7 `i'_up_8 `i'_up_9 ///
            using `"${PATH_OUT_TABLES}/`2'_`i'_IVtable.tex"', replace type rstyle(tabular) ///
            head("\begin{table}[htb]" "\caption{Fixed Effects Results Using ${TABLETITLE} Measure of Democracy: Two-Stage Least Squares with ${IVTITLE2}}" ///
            "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccccccc}" ///
            "\toprule" ///
            "& \multicolumn{9}{c}{Base Sample, 1960-2000} \\" ///
            "\midrule" ///
            "& \multicolumn{9}{c}{All countries} \\" ///
            "\midrule" ///
            "& \begin{tabular}[c]{@{}c@{}} Pooled \\ OLS\end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS\end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ OLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Arellano- \\ Bond GMM \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular}" ///
            "& \begin{tabular}[c]{@{}c@{}} Fixed effects \\ 2SLS \end{tabular} \\ " ///
            " & (1) & (2) & (3) & (4) & (5) & (6) & (7) & (8) & (9)\\" ///
            "\midrule" ///
            "Panel A & \multicolumn{9}{c}{\textit{Dependent variable is democracy}:}\\ " ///
            "\midrule" ) ///

            use `"${PATH_OUT_ANALYSIS}/`2'_`i'do_IVestimation_results"', clear

        listtab `i'_do_colstring `i'_do_1 `i'_do_2 `i'_do_3 `i'_do_4 `i'_do_5 `i'_do_6 `i'_do_7 `i'_do_8 `i'_do_9, ///
            appendto(`"${PATH_OUT_TABLES}/`2'_`i'_IVtable.tex"') type rstyle(tabular) ///
            head("\midrule" ///
            "Panel B & \multicolumn{9}{c}{\textit{First stage for Log Gdp per capita t-1}:}\\" ///
            "\midrule" ) ///
            foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )
    }


}




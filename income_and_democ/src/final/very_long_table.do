/*
The file "long_table.do" transfers the results from the fixed effects long run analysis (:ref:`very long run analysis`) into a latex table structure save the tex file in *bld/out/tables*.
*/

include project_paths


log using `"${PATH_OUT_FINAL}/log/`1'.log"', replace

do `"${PATH_OUT_MODEL_SPECS}/very_long"'

foreach i in A B {
    use `"${PATH_OUT_ANALYSIS}/very_long_`i'"'

    if "`i'"== "A" {
        listtab A_colstring A_1 A_2 A_3 A_4 ///
        using `"${PATH_OUT_TABLES}/very_long_A.tex"', replace type rstyle(tabular) ///
        head("\begin{table}[htb]" "\caption{Democracy In The Very Long Run}" ///
        "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lcccc}" ///
        "\toprule" ///
        "\midrule" ///
        "& \multicolumn{4}{c}{Base sample, 1500-2000} \\" ///
        "\cmidrule(lr){2-5}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular} \\ " ///
        "& (1) & (2) & (3) & (4) \\" ///
        "\midrule" ///
        "& \multicolumn{4}{c}{\multirow{3}{*}{\shortstack[c]{Dependent variable is change in democracy \\ over sample period}}} \\" ///
        "& & & & \\" ///
        "\cmidrule(lr){2-5}" ) ///
        foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )

    }
    else if "`i'"== "B" {
        listtab B_colstring B_1 B_2 B_3 B_4 B_5 B_6 B_7 ///
        using `"${PATH_OUT_TABLES}/very_long_B.tex"', replace type rstyle(tabular) ///
        head("\begin{table}[htb]" "\caption{Democracy In The Very Long Run}" ///
        "\footnotesize" "\begin{center}" "\begin{adjustbox}{max width=\textwidth}" "\begin{tabular}{lccccccc}" ///
        "\toprule" ///
        "\midrule" ///
        "& \multicolumn{7}{c}{Former colonies sample, 1500-2000} \\" ///
        "\cmidrule(lr){2-8}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular}" ///
        "& \begin{tabular}[c]{@{}c@{}} OLS \end{tabular} \\ " ///
        "& (1) & (2) & (3) & (4) & (5) & (6) & (7) \\" ///
        "\midrule" ///
        "& \multicolumn{7}{c}{\textit{Dependent variable is change in democracy over sample period}} \\" ///
        "\cmidrule(lr){2-8}" ) ///
        foot("\bottomrule" "\end{tabular}" "\end{adjustbox}" "\end{center}" "\end{table}" )


    }


}

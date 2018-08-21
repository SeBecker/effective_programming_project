.. _introduction:


************
Introduction
************
The following report documents the replication of Acemoglu 2008 :cite:`Acemoglu1`. The Project template is by Hans Martin Gaudecker :cite:`GaudeckerEconProjectTemplates`.


.. _dag:

Structure of the Project
========================
The project has the following structure:

- Original data is saved in *src/original_data*. for more information about the data sets see also :ref:`original_data`

-   The data sets are adjusted and copied by two different files in *src/data_management*. Furthermore the adjusted data sets are saved in *bld/out/data* such that the countinuing analysis process does not have any impact on the original data.

-   Model specifications are saved in *.json* files in *src/model_specs*. Waf converts this files into do (saved in *bld/src/model_specs*) files such that they can be easily implemented into the analysis files (*src/analysis*) and the figure construction files (*src/final*). For more information about the specific content of each *.json* file see also :ref:`model_specs`.

-   Everything related to the analysis process can be found in *src/analysis*. During the build process some files (*regression.do*, *IV_estimation.do* and *robustness_check.do*) are copied over just because it allows to run the same do file for different model specifications at the same time. The copied files are saved in *bld/src/analysis*. For more information about the contained files see also :ref:`analysis`

-   *src/final* contains one file related to the figure construction process and several others that transfer the regression results from the analysis part into tex files. The resulting tables are saved in *bld/out/tables*. For more information see also :ref:`final`.

-   *src/paper* includes the resulting paper that integrates all former tex tables and figures into a pdf document saved in *bld/src/paper*.


.. raw:: latex

    \vspace*{2ex}

    \includegraphics{../dependency_graph.pdf}

For the sake of simplicity, the dependency graph does not include the long run and very long run analysis and table construction process (*very_long_A.tex*, *very_long_B.tex* and *long_run_table.tex*). Both processes are very similar to the construction of the figures, but use the *POL.do* and *very_long.do* model specification files instead of the figure related specifications.


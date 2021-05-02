# A few more theoretico-practical tips...

## On SPM's condition files
Condition files are .mat files that contain the information about the trials of the experiment. They only contain three pieces of information: name of the conditions in the experiments, trial times (onsets) and trial durations. 

Since SPM wants this information in a .mat file, these cannot be open outside of MATLAB. To explore them, load them in MATLAB by drag and drop into the Comand Window and you should see the three variables appearing in the workspace. Something you should always checkout is if the three variables have the same number of cells (one per condition) and if the `onsets` and `durations` variable have the same number of entries (one per trial).

## On SPM's confound files
Confound files contain variables that you would want to use to “clean up” the data (such as head motion). They are .txt files containing a big matrix with the different variables in columns and with the values in rows. There’s one value for each datapoint in our time series.

Take as an example head motion. This is a variable that is well captured by 6 parameters (x, y and z axis and two movement types, translation and rotation).
For every datapoint (every volume in the functional files) we have a value for each one of these 6 parameters (editado). When you take all of the values in each one of those parameters across time, you can use those timeseries as regressors. 

## On SPM's beta maps.
The number of betas (or beta files or beta maps) should match the number of regressors. Note that you will get a beta estimate also for the confound regressors even if you would not typically care too much about them. SPM (as most packages running GLM for fMRI) do not include meaningfull labels in the beta file names. The name/order of the beta files will match the order with which the regressors were put into the GLM. In the case of SPM, task regressors go first in alphabetical order of the “name” of the regressor in the condition files; then confound regressors go in the same order as they are in the confound file.

Finally, note that your model will also include a "constant" regressor for each run in your task (to account for differences in signal across runs). As a consequence, you will also have one extra beta for each one of your runs.

To sum up, the number of beta files that you get out of SPM's GLM should add up to:
(n_task_regressors + n_confound_regressors + 1) * n_runs

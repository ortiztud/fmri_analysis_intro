# Running the analyses

## Add relevant folders to Matlab's path
1. Go to ` ~/fmri_analysis_intro/_functions/` and open the `init.m` matlab file
2. Set the `% Path to the seminar repository` to match the location of the `_functions` foler in your PC
3. Set the `% Path to SPM12` to match the location of the `spm12` foler in your PC

## Run univariate analysis wrapper on your data
1. Go to the `~/fmri_analysis_intro/analysis_scripts/` folder.
2. open the file to run the analysis (`univ_wrapper_process.m`, `univ_wrapper_spatial.m`,
   `univ_wrapper_content.m`, depending on the dataset your are working on).
3. Set the project_folder path to match the location of the files on your computer
4. Fill the "subjects" field indicating for which subjects you want to run the analysis
6. Create condition files for each subject.
7. Create confound files for each subject.
8. Run the GLM for each subject (it takes a while).
9. Run the loop through subjects to create the contrast files.
10. Run the group analysis for ech contrast.
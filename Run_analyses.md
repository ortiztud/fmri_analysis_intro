# Running the analyses

## Add relevant folders to Matlab's path
1. Go to ` ~/fmri_analysis_intro/` and open the `init.m` matlab file
2. Set `spm_folder` to point at the location of the `spm12` folder in your PC. Save the file. You only need to do this once.
3. In MATLAB's Command Window type `init`. You will need to do this everytime that you re-start MATLAB.

## Compute GLM on your data
1. Go to the `~/fmri_analysis_intro/analysis_scripts/session-GLM/` folder.
2. Open the empty template (`GLM_wrapper_template.m`)
3. Set the project_folder path to match the location of the files on your computer
4. Fill the "subjects" field indicating for which subjects you want to run the analysis
6. Create condition files for each subject.
7. Create confound files for each subject.
8. Run the GLM for each subject (it takes a while).

## Run univariate analysis on your data
### For process-specific: 
- 1. Run the loop through subjects to create the contrast file.

- 2. Run the group analysis for ech contrast. 

### For spatial-mapping:
Run retinotopy. 

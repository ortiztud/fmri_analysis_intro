% Filled in example for fmri_analysis_intro. Process-specific dataset

%% Define all the paths in your computer
project_folder='/Users/javierortiz/PowerFolders/data_fmri-analysis_intro/spatial-mapping';

%% Which subjects?
subjects = [1];

%% Now we need to create the condition files. For that we can use the function called
% univariate_00_create_cond_files(project_folder, subject, task)
% Create condition files
for c_sub = subjects
    univariate_00_create_cond_files(project_folder, c_sub, 'ring', 'ring3T')
end

% Create confound files
for c_sub = subjects
    univariate_01_create_confounds_files(project_folder, c_sub, 'ring', 'ring3T')
end

% Run GLM
for c_sub=subjects
    univariate_02_glm(project_folder, c_sub, 'ring', 1, 'ring3T')
end

% Run retinotopy
retinotopy(project_folder, 1, 'ring3T')

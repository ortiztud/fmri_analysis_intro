% Wrapper
project_folder='/home/javier/pepe/2_Analysis_Folder/fMRI_analysis_seminar/spatial-mapping';

% Create condition files
which_subs=[1,3];
for c_sub = which_subs
    univariate_00_create_cond_files(project_folder, c_sub, 'ring', 'ring3T')
end

% Create confound files
for c_sub = which_subs
    univariate_01_create_confounds_files(project_folder, c_sub, 'ring', 'ring3T')
end

% Run GLM
for c_sub=which_subs
    univariate_01_glm(project_folder, c_sub, 'ring', 1,'ring3T')
end

% Run retinotopy
for c_sub=which_subs
    retinotopy(project_folder, c_sub,0)
end
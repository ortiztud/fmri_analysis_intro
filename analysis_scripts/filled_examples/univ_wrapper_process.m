% Filled in example for fmri_analysis_intro. Process-specific dataset

%% Define all the paths in your computer
project_folder='/Users/javierortiz/PowerFolders/data_fmri-analysis_intro/process-specific';

%% Which subjects?
subjects = [1:20];

%% Now we need to create the condition files. For that we can use the function called
% univariate_00_create_cond_files(project_folder, subject, task)
% Create condition files
for c_sub = subjects
    univariate_00_create_cond_files(project_folder, c_sub, 'stroop')
end

% Create confound files
for c_sub = subjects
    univariate_01_create_confounds_files(project_folder, c_sub, 'stroop')
end

% Run GLM
for c_sub=subjects
    univariate_02_glm(project_folder, c_sub, 'stroop', 1)
end

% Run contrast
contrast_names={'neu-inc';'inc-all';'all-inc';'con-inc';'con-neu'};
contrast_weights={[0 -1 1];[-1 2 -1];[1 -2 1];[1 -1 0];[1 0 -1]};
for c_sub=subjects
    univariate_03_contrast(project_folder, c_sub, contrast_names, contrast_weights)
end

% Run group analysis for each contrast
for c_cont = 1:numel(contrast_names)
    univariate_04_group_level(project_folder, subjects, c_cont, ...
        contrast_names{c_cont});
end
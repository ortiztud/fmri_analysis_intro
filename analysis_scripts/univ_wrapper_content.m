% Wrapper

%% Define all the paths in your computer
project_folder='/home/ortiz/DATA/2_Analysis_Folder/fMRI_analysis_seminar/content-specific';
project_name = 'content-specific';

%% Which subjects?
subjects = [6,7,8];

%% Now we need to create the condition files. For that we can use the function called
% univariate_00_create_cond_files(project_folder, subject, task)
% Create condition files
for c_sub = subjects
    univariate_00_create_cond_files(project_folder, c_sub, 'floc', 'floc7T',{'adult';'house'})
end

% Create confound files
for c_sub = subjects
    univariate_01_create_confounds_files(project_folder, c_sub, 'floc', 'floc7T')
end

% Run GLM
for c_sub=subjects
    univariate_02_glm(project_folder, c_sub, 'floc', 1, 'floc7T')
end

% Run contrast
contrast_names={'adult-house';'house-adult'};
contrast_weights={[1 -1];[-1 1]};
for c_sub=subjects
    univariate_03_contrast(project_folder, c_sub, contrast_names, contrast_weights) % Inc > Neutr
end

% Run group analysis for each contrast
for c_cont = 1:numel(contrast_names)
    univariate_04_group_level(project_folder, subjects, c_cont, ...
        contrast_names{c_cont});
end

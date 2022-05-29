%% Wrapper template for fmri_analysis_intro. GLM computation.
% This is a template wrapper script for computing a GLM (LSU approach) of fMRI
% data with SPM.
%
% To run a GLM in SPM we will need two sets files (on top of the data files):
%       - Condition files: .mat files that contain three variables, namely,
%       'onsets', 'durations' and 'names'. These variables must be cell
%       arrays with as many entries as conditions of interest; each entry in
%       'onsets' and 'durations' must contain as many numerical values as
%       observations in that condition; each entry in 'names' must contain
%       a string with the condition name.
%       IMPORTANT! The order of the conditions must be preserved across
%       variables.
%       - Confound files: .txt files containing a timepoint X regressors
%       matrix. No headers are permitted.

%% Define paths
project_folder='/Users/javierortiz/PowerFolders/data_fmri-analysis_intro/process-specific';

%% Which subjects?
subjects = [1];

%% First step. Condition onsets.
% For that we can use the function called
% univariate_00_create_cond_files(project_folder, subject, task, [session])
% Write your call for this function below. Try with one participant.
% univariate_00_create_cond_files(project_folder, 2, 'stroop')

% Did you get any error? If so, check with the trainers and your
% colleagues. If not, verify that the outputs that have been created look
% good.

% If the outputs look good for one participant, now try to create a loop to
% repeat the function call multiple times in an automatic way.
% MATLAB's syntax for loops always starts with 'for' or 'while' and finish
% with 'end'.
for whatever = subjects
    
    % Function call. Which argument needs to change in each iteration?
    univariate_00_create_cond_files(project_folder, whatever, 'stroop')
    
end

%% Second step. Confound files.
% For a BIDS dataset this can also be automatized with the function
% univariate_01_create_confounds_files(project_folder, subject, task, [session])
% Try with one subject and then loop through the calls.
for whatever = subjects
    
    univariate_01_create_confounds_files(project_folder, whatever, 'stroop')
    
end
%% Third step. Run GLM
% Now we are ready to run our GLM with SPM. We have created a short
% function with the scripting from SPM.
% univariate_02_glm(project_folder, subject, task, compresion?, [session])
univariate_02_glm(project_folder, 1, 'stroop', 0)

% Make sure you have checked the outputs and that you understand what they
% represent!
%% Wrapper template for fmri_analysis_intro. Univariate analysis.
% This is a template wrapper script for running univariate contrasts of fMRI
% data (beta maps) with SPM.
%
% To run a contrast in SPM we will need a SPM.mat file. Hopefully, this has
% been successfully created in a previous step. On top of that file we will
% also need:
%       - Contrasts names: Cell array containing the names that we want to 
%       give our constrasts. Make sure you use meaningfull names. There are
%       no restriction to the characters you can use.
%       - Constrats weights: Cell array containing the weight vectores for 
%       that correspond to the contrasts names. IMPORTANT! The order must
%       be preserved across variables.

%% Define paths
project_folder='/dataset/path/in/your/computer/';

%% Which subjects?
subjects = [];

%% Run contrast.
% First, define the contrasts of interest.
contrast_names={'';''};
contrast_weights={[];[];};

% Now we can call the following function.
% univariate_02_contrast(project_folder, subject, contrast_names, contrast_weights)
% As in the previous exercises, always try first with one or two 
% participants before looping through the entire sample.


% Do you understand the new outputs?

%% Run group analysis for each contrast
% Once you already have computed contrast maps, we are ready to run
% group-level analysis. We can use the following function
% univariate_03_group_level(project_folder, subjects, contrast_number, contrast_name)
% IMPORTANT! Pay attention to the contrast number. It should math the ORDER
% in which the contrasts were computed in the previous step.

% Do you understand the new outputs?
%% Wrapper template for fmri_analysis_intro. Retinotopy.
% This is a template wrapper script for running functonal retinotopy.
%
% To run this script you need the beta maps generated for each condition in 
% either an eccentricity and/or a polar angle mapping run. 
%       - Contrasts names: Cell array containing the names that we want to 
%       give our constrasts. Make sure you use meaningfull names. There are
%       no restriction to the characters you can use.
%       - Constrats weights: Cell array containing the weight vectores for 
%       that correspond to the contrasts names. IMPORTANT! The order must
%       be preserved across variables.

%% Define paths
project_folder='/home/javier/pepe/2_Analysis_Folder/fMRI_analysis_seminar/spatial-mapping';

%% Which subjects?
subjects = [];

%% Run retinotopy.
% If you already understand what retinotopy is and which type of stimulation 
% your participants were exposed to, we are ready to actually run the
% analysis. We can use the following function
% retinotopy(project_folder, subject, [session])

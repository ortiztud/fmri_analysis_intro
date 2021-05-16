%% Wrapper template for fmri_analysis_intro. Retinotopy.
% This is a template wrapper script for running functonal retinotopy.
%
% To run this script you need the beta maps generated for each condition in 
% either an eccentricity and/or a polar angle mapping run. You do not need to specify
% much below. Just point at the root folder of the project and select for which
% subject you want to run the analysis. IMPORTANT! Do you need a session label?

%% Define paths
project_folder='/dataset/path/in/your/computer/';

%% Which subjects?
subjects = [];

%% Run retinotopy.
% If you already understand what retinotopy is and which type of stimulation 
% your participants were exposed to, we are ready to actually run the
% analysis. We can use the following function
% retinotopy(project_folder, subject, [session])

% This script imports some functions that we will need for the seminar. In 
% Matlab's terms: it will add the relevant folders to Matlab's path.
%
% REMEMBER: You need to run this script every time that you open Matlab.
% You can do that by clicking the green "play" button at the top of this
% window or just typing "init" in Matlab's terminal.

%% Local paths
% Here you need to specify where you have put the SPM folder.
spm_folder = '/path/to/spm12';


%% Add paths (no need to change anything from here on)
% Seminar functions
addpath('_functions');

% The next line will make SPM's functions available to MATLAB.
addpath(spm_folder)

%% Print message
sprintf('All necessary paths have been added. We are ready to start.')
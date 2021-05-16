% univariate_01_create_confounds_files(project_folder, which_sub, task_name, varargin)
% This function reads in confounds information from json files in a BIDS
% dataset and creates confounds files in .txt to be read by SPM. The script will
% assume that all your files follow BIDS convention. To include changes in
% the way paths are hanldled, see getdirs.m.
%
% Usage: 
%    - project_folder: path to root folder of the project
%    - which_sub: subject id
%    - task_name: task label for which condition files will get generated.
%    NOTE that this label *must* be identical to the one used for naming
%    the files.
%    - varargin: optional arguments.
%           - string: If provided, the first argument will be used as session label
%           to navigate BIDS folders.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe University)
% Created: 17.03.2021
% Last update: 14.04.2021

function univariate_01_create_confounds_files(project_folder, which_sub, task_name, varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
else
    ses_label = '';
end

% Get folder structure
if contains(project_folder,'process-specific')
    sufs = getdirs_process(project_folder, which_sub, ses_label);
elseif contains(project_folder,'spatial-mapping')
    sufs = getdirs_spatial(project_folder, which_sub, ses_label);
else 
    error('I do not recognize the provided folder. Please, check that it is correct. \n\n. Provided path: %', project_folder)
end

% Get how many runs are available
timeseries_folder = [sufs.func, 'sub*', task_name, '*timeseries.tsv'];
sprintf('Looking for timeseries files at %s', sufs.func)
temp=dir(timeseries_folder);
if isempty(temp) % This is here to handle different between fmriprep's versions
    temp=dir([sufs.func, 'sub*', task_name, '*regressors.tsv']);
end
if isempty(temp)
    error('No timeseries files found in the searched folder')
end
for i=1:length(temp)
    conf_files{i}=temp(i).name;
end
n_runs=size(conf_files,2);

% Start looping over runs
for c_run = 1:n_runs
    
    % Use get_moco_info function to generate the confound files
    here = cd;there = sufs.func;out_dir=sufs.univ;
    get_moco_info(here, there, out_dir, conf_files{c_run});
   
end

% Echo
fprintf(['Participant ' num2str(which_sub,'%.2d') ' done\n'])

end
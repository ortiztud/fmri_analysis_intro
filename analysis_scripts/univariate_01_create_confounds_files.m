% This script takes in confounds information from json files in a BIDS
% dataset and creates confounds files in txt to be read by SPM.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe Univerity)
% Created: 17.03.2021

function univariate_01_create_confounds_file(project_folder, which_sub, task_name, varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
else
    ses_label = '';
end

% Get folder structure
sufs=getdirs(project_folder, which_sub, ses_label);

% Get how many runs are available
temp=dir([sufs.func, 'sub*', task_name, '*timeseries.tsv']);
for i=1:length(temp)
    conf_files{i}=temp(i).name;
end
n_runs=size(conf_files,2);

% Start looping over runs
for c_run = 1:n_runs
    
    % Use R function to generate the confound files
    run_conf_file=[sufs.func, conf_files{c_run}];
    cmd = sprintf('Rscript %sget-moco-info.R %s', sufs.functions, run_conf_file);
    system(cmd);
   
end

% Echo
fprintf(['Participant ' num2str(which_sub,'%.2d') ' done\n'])

end
% univariate_00_create_cond_files(project_folder, which_sub, task_name, varargin)
% This function reads in event information from .json files in a BIDS
% dataset and creates conditions files in SPM format. The script will
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
%           - cell array: If provided, the second argument will be used to select 
%           specific conditions from the event files.
%
% Each event in the json file will be treated as a condition.
% CAUTION: This might not always be what the GLM requires since you might
% want to collapse several events into single regressors.
% Also, if you want to select specific events (without collapsing) you
% can pass a cell array with the event names as the second option argument.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe University)
% Created: 09.01.2021
% Last update: 14.04.2021

function univariate_00_create_cond_files(project_folder, which_sub, task_name, varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
    if size(varargin,2)>1
        cond_names = varargin{2};
    end
else
    ses_label = '';
end

% Get folder structure
sufs=getdirs(project_folder, which_sub, ses_label);

% Get how many runs are available
temp=dir([sufs.events, '/sub*', task_name, '*events.tsv']);
for i=1:length(temp)
    ev_files{i}=temp(i).name;
end
n_runs=size(ev_files,2);

% Start looping over runs
for cRun = 1:n_runs
    
    % Load event files
    ev = read_tsv([sufs.events, ev_files{cRun}]);
    
    % Get available conditions
    try
        avail_conditions = unique(ev.trial_type);
    catch
        ev.Properties.VariableNames{'condition'}='trial_type';
        avail_conditions = unique(ev.trial_type);
    end
    
    % Check if requested conditions are available
    if exist('cond_names', 'var')
        if mean(ismember(cond_names, avail_conditions)) ~= 1
            avail_conditions
            error('Requested conditions are not available. Above this error you can see a list all available conditions')
        end
    else
        sprintf('No conditions were specified. Using all conditions available in event files.')
        cond_names = avail_conditions;
    end
    n_cond = length(cond_names);
    
    % Loop over conditions / trial types
    for cType = 1:n_cond
        % Get indices for the current condition for each experiment
        ind=strcmpi(ev.trial_type,cond_names{cType});
        
        % Build SPM structure
        names{cType}=cond_names{cType};
        onsets{cType}=ev.onset(ind);
        durations{cType}=ev.duration(ind);
        
    end
    
    % Save
    save(sprintf('%s%s.mat',sufs.univ, ev_files{cRun}(1:end-4)), 'onsets','names','durations')
end

% Echo
fprintf(['Participant ' num2str(which_sub,'%.2d') ' done\n'])

end
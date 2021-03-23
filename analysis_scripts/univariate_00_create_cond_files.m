% This script takes in event information from json files in a BIDS
% dataset and creates conditions files in SPM format. Each event in the
% json file will be treated as a condition.
% CAUTION: This might not always be what the GLM requires since you might
% want to collapse several events into single regressors.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe Univerity)
% Created: 09.01.2021

function univariate_00_create_condFile(project_folder, which_sub, task_name, varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
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
    
    % Get conditions
    try
        conditions = unique(ev.trial_type);
    catch
        ev.Properties.VariableNames{'condition'}='trial_type';
        conditions = unique(ev.trial_type);
    end
    n_cond = length(conditions);
    
    % Loop over conditions / trial types
    for cType = 1:n_cond
        % Get indices for the current condition
        ind=strcmpi(ev.trial_type,conditions{cType});
%          ind=strcmpi(ev.trial_type,conditions{cType}) &
%          strcmpi(ev.correct, 'Y'); % For process-specific
        
        % Build SPM structure
        names{cType}=conditions{cType};
        onsets{cType}=ev.onset(ind);
        durations{cType}=ev.duration(ind);
        
    end
    
    % Save
    save(sprintf('%s%s.mat',sufs.univ, ev_files{cRun}(1:end-4)), 'onsets','names','durations')
end

% Echo
fprintf(['Participant ' num2str(which_sub,'%.2d') ' done\n'])

end
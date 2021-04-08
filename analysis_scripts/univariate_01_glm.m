% This script takes in the condition files created with
% univariate_00_create_condFile, creates a SPM.mat and computes the GLM. In
% SPM's terms: it specifies the model and estimates it.
%
% If compress == 1 then .nii files will be compressed at the end.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe Univerity)
% Created: 09.01.2021
% Last update: 12-01.2021

function univariate_01_glm(project_folder, which_sub, task_name, compress,varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
else
    ses_label = '';
end

% Get folder structure
[sufs, sub_code]=getdirs(project_folder, which_sub, ses_label);

% Echo
fprintf('Starting participant %d',which_sub)

% Create output folder to keep things nice and clean
out_folder=[sufs.univ, '/betas'];
if ~exist(out_folder);mkdir(out_folder);end

% Get how many runs are available
temp=dir([sufs.univ, '/sub*', task_name, '*events.mat']);
temp2=dir([sufs.func, 'sub*', task_name, '*_SPM.txt']);
for i=1:length(temp)
    ev_files{i}=temp(i).name;
    conf_files{i}=temp2(i).name;
end
n_runs=size(ev_files,2);

% Get filenames
func_files=smooth_bids(sufs.func, task_name);

%% Fun beggins
matlabbatch{1}.spm.stats.fmri_spec.dir = {out_folder}; % Output folder
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 0.8; % TR
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 72; % n slices
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 36; % reference slice for slicetime correction

%% Loop through runs
for c_run=1:4%n_runs
    
    % These are all the fields that SPM needs for a given run. Nothing
    % needs to be changed here.
    if n_runs>1
        filter = ['^', sub_code,  '.*', task_name, '.*_run-', num2str(c_run), '.*sm_bold.nii$'] ;
    else
        filter = ['^', sub_code,  '.*', task_name, '.*sm_bold.nii$'] ;
    end
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).scans = cellstr(spm_select('FPList',sufs.func,filter));
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).multi = {[sufs.univ, ev_files{c_run}]};
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).multi_reg = {[sufs.func,conf_files{c_run}]};
%     matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).multi_reg = {['']};
    matlabbatch{1}.spm.stats.fmri_spec.sess(c_run).hpf = 128;
    
end

%%  Model specification
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {[project_folder, '/tpl-MNI152NLin2009cAsym_label-GM_bin.nii']};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% Model estimation
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

%% And run!
spm_jobman('run', matlabbatch);
clear matlabbatch;

% Clean up if requested
if compress
    for c_run=1:n_runs
        gzip([sufs.func, func_files{c_run}]);
    end
end
end
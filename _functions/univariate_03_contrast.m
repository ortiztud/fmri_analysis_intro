% univariate_03_contrast(project_folder, which_sub, contrast_names, weigth_vec,varargin)
% This function reads in the SPM.mat file from a GLM estimation done in SPM
% and computes contrast maps.
%
% Usage:
%    - project_folder: path to root folder of the project
%    - which_sub: subject id
%    - contrast_names: cell array containing the names of the contrasts to 
%    be run.
%    - contrast_weights: cell array containing the weights of the contrast
%    to be run. NOTE: These weights should match the order of the names in
%    contrast_names.
%    - varargin: optional arguments.
%           - string: If provided, the first argument will be used as session label
%           to navigate BIDS folders.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe University)
% Created: 09.01.2021
% Last update: 14.04.2021

function univariate_03_contrast(project_folder, which_sub, contrast_names, weigth_vec,varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
else
    ses_label = '';
end

% Get folder structure
sufs=getdirs(project_folder, which_sub, ses_label);

% How many contrast?
n_contrast = numel(contrast_names);
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.con.spmmat = {[sufs.univ, 'betas/SPM.mat']};
for c_contrast = 1:n_contrast
    matlabbatch{1}.spm.stats.con.consess{c_contrast}.tcon.name = contrast_names{c_contrast};
    matlabbatch{1}.spm.stats.con.consess{c_contrast}.tcon.weights = weigth_vec{c_contrast};
    matlabbatch{1}.spm.stats.con.consess{c_contrast}.tcon.sessrep = 'none';
end
matlabbatch{1}.spm.stats.con.delete = 0;

%% And run!
spm_jobman('run', matlabbatch);
clear matlabbatch;
end

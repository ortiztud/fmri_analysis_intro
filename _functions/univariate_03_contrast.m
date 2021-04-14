% This script takes in the SPM.mat file from a GLM estimation done in SPM
% and computes contrast maps.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe Univerity)
% Created: 09.01.2021
% Last update: 12-01.2021


function univariate_02_contrast(project_folder, which_sub, contrast_names, weigth_vec,varargin)

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

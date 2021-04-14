% univariate_04_group_level(project_folder, which_sub, contrast_number,contrast_name, varargin)
% This script performs the group level analysis of single subject contrast
% maps.
%
% Usage:
%    - project_folder: path to root folder of the project
%    - which_sub: subject id
%    - contrast_number: numeric label assigned by SPM when running the
%    contrast. This number reflects the order on which the contrasts were
%    run and accumulates even if the same contrasts are run multiple times. 
%    This is a bit annoying a very error prone, so make sure the number
%    specified here matches exactly the contrast that you want to look at.
%    - contrast_names: cell array containing the names of the contrasts to 
%    be run.
%    - varargin: optional arguments.
%           - string: If provided, the first argument will be used as session label
%           to navigate BIDS folders.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe University)
% Created: 12.01.2021
% Last update: 17.03.2021

function univariate_04_group_level(project_folder, which_sub, contrast_number,contrast_name, varargin)

% Session label
if ~isempty(varargin)
    ses_label = varargin{1};
else
    ses_label = '';
end

% Output folder
output_folder=[project_folder, '/outputs/group_level/univ/', contrast_name];

%% start looping over subjects
c=1;
for cSub = which_sub
    
    % Get folder structure
    sufs=getdirs(project_folder, cSub, ses_label);
    
    % Get contrast 1st level files
    file_names{c,1}=[sufs.outputs, 'univ/betas/con_000', num2str(contrast_number),'.nii'];
    c=c+1;
end

%% Fun begins
% Nothing needs to be changed from here on
matlabbatch{1}.spm.stats.factorial_design.dir = {output_folder};
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = file_names;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = contrast_name;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = 1;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;
spm_jobman('run', matlabbatch);
clear matlabbatch;


end

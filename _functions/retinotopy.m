% retinotopy(project_folder, which_sub, varargin)
% This script computes retinotopy for a given subject. It takes in the beta
% estimates from a GLM and codes brain voxels as a function of their
% preferred regressor/condition/eccentricity.
% Usage:
%    - project_folder: path to root folder of the project
%    - which_sub: subject id
%    - varargin: optional arguments.
%           - string: If provided, the first argument will be used as session label
%           to navigate BIDS folders.
%
% This script has been created for the fMRI analysis seminar on PsyMSc4 at
% the Goethe University.
%
% Author: Ortiz-Tudela (Goethe Univerity)
% Created: 17.03.2021
% Last update: 12.01.2021

function retinotopy(project_folder, which_sub, varargin)

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

% Which betas code for the eccentricity conditions
ecc_reg=[1:6;18:23;35:40];
all_betas=[];

% Loop through runs
for c_run = 1:3
    run_betas=[];
    % Loop through ecc conditions
    for c_ecc = ecc_reg(c_run,:)
        temp = spm_read_vols(spm_vol(sprintf('%s/betas/beta_%04d.nii', sufs.univ, c_ecc)));
        
        % Concatenate betas along the 4th dimmension
        run_betas = cat(4,run_betas, temp);
        
    end
    
    % % Concatenate run betas along the 5th dimmension
    all_betas = cat(5,all_betas, run_betas);
end

% Average across runs
av_betas = mean(all_betas,5);

% Get maximums
[values, codes]=max(av_betas,[],4);

% Create a copy to be used as an envelope
cmd = sprintf('cp %s/betas/beta_0001.nii %sretinotopy.nii', sufs.univ,sufs.univ);
system(cmd);

% Read in the envelope
env = spm_vol(sprintf('%sretinotopy.nii', sufs.univ));

% Write volume
spm_write_vol(env,codes);

end
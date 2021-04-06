function smoothed_files=smooth_bids(func_folder, task_name)
% This is a small wrapper to smooth files with SPM's function in a BIDS
% formatted dataset. I am creating this function because smoothing is not
% done in fMRIPrep but it is often required for univariate analysis.
% Since SPM cannot hangle compressed nifti files but BIDS has them, the
% files are decompressed, smoothed and compressed back again.

% CAUTION: This script will smooth **ALL** functional files for the
% specified task inside the specified subject's BIDS directory.
% If this is not what you want, you would need to modify the files selected
% below.

% Where do we start?
here=cd;

% Get functional files
temp=dir([func_folder, '/sub*', task_name, '*desc-preproc_bold.nii.gz']);
for i=1:length(temp)
    func_files{i}=temp(i).name;
end

% Let's go to the func folder so we can read files more easily
cd(func_folder)

% Loop through files
for c_file = 1:length(func_files)
    
    % Build smoothed filenames
    ind=strfind(func_files{c_file},'preproc');
    smoothed_files{c_file}=[func_files{c_file}(1:ind-1), 'sm_bold.nii'];
    
    % Check if uncompressed smoothed files already exist
    if ~exist(smoothed_files{c_file})
        
        % Now we check if the smoothed files exist compressed and unzip them
        if exist([smoothed_files{c_file}, '.gz'])
            gunzip([smoothed_files{c_file}, '.gz']);
            
        else
            % If we are here it means that smoothing was not done previously. We
            % will do it now. First, we check if we need to unzip the func file
            % also.
            if ~exist(func_files{c_file}(1:end-3))
                gunzip(func_files{c_file});
            end
            
            % Now we finally do the smoothing
            sprintf('Smoothing %s', func_files{c_file})
            spm_smooth(func_files{c_file}(1:end-3),smoothed_files{c_file},4);
        end
        
    end
end

% Now let's go back to where we started
cd(here)
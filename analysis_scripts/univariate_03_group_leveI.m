% Univariate contrast from SPM.mat
% Author: Ortiz-Tudela (Goethe Uni)

% Second level analysis
function second_level_univariate_MNI(which_sub)
%% Add necessary paths
% Main folder
if strcmpi(getenv('USERNAME'),'javier')
    main_folder= '/home/javier/pepe/2_Analysis_Folder/PIVOTAL/FeedBES';
    addpath('/home/javier/pepe/2_Analysis_Folder/_common_software/spm12')
else
    main_folder= '/home/ortiz/DATA/2_Analysis_Folder/PIVOTAL/FeedBES';
    addpath('/home/ortiz/DATA/2_Analysis_Folder/_common_software/spm12')
end


% Contrasts labels
cont_labels={'episodic';'semantic';'epi>sem';'sem>epi'};

%% loop over contrasts
for cContrast = 1:length(cont_labels)
    
    % Get contrast name
    cont_label= cont_labels{cContrast};
    
    % Output folder
    output_folder=[main_folder, '/outputs/group_level/univariate/',...
        cont_label, '_MNI/'];
    
    
    %% start looping over subjects
    c=1;
    for cSub = which_sub
        
        % Get folder structure
        [sufs,sub_code]=feedBES_getdir(main_folder, cSub);
        
        % Get contrast 1st level files
        file_names{c,1}=[sufs.outputs, 'episem/con_000', num2str(cContrast), '.nii'];
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
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = cont_label;
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = 1;
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 0;
    spm_jobman('run', matlabbatch);
    clear matlabbatch;
end

end

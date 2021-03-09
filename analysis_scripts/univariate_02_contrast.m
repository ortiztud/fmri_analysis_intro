% Univariate contrast from SPM.mat
% Author: Ortiz-Tudela (Goethe Uni)

function contrast_SPM_episem(which_sub)

%% Add necessary paths
% Main folder
if strcmpi(getenv('USERNAME'),'javier')
    main_folder= '/home/javier/pepe/2_Analysis_Folder/PIVOTAL/FeedBES';
else
    main_folder= '/home/ortiz/DATA/2_Analysis_Folder/PIVOTAL/FeedBES';
end

%% start looping over subjects
for cSub = which_sub
    
    % Get folder structure
    [sufs,sub_code]=feedBES_getdir(main_folder, cSub);
    
    % Get regressor's names
    weigth_vec=[1,-1];
    
    %-----------------------------------------------------------------------
    matlabbatch{1}.spm.stats.con.spmmat = {[sufs.outputs, 'episem/SPM.mat']};
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'episodic';
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 0];
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'semantic';
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 1];
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'epi>sem';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = weigth_vec;
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'sem>epi';
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = weigth_vec*-1;
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
    matlabbatch{1}.spm.stats.con.delete = 0;
    
    spm_jobman('run', matlabbatch);
    clear matlabbatch;
end

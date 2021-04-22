% # Read fMRIPrep's confounds output and create a text file compatible with SPM that contains 
% # only MOCO, global signals and linear trends.

function get_moco_info(func_file)

'Extracting confounds'

% # Read in confounds files
system(sprintf('cp %s %scsv', func_file, func_file(1:end-3)));
conf_data = readtable([func_file(1:end-3),'csv']);

% # Select the columns with moco info
moco = [conf_data.rot_x, conf_data.rot_y, conf_data.rot_z, ...
    conf_data.trans_x, conf_data.trans_y, conf_data.trans_z];

% # Get non linear trends from run files  
cos1 = conf_data.cosine00;
cos2 = conf_data.cosine01;

% ## Now combine different confounds into a single file for SPM
csf = conf_data.csf;
wm = conf_data.white_matter;
glob = conf_data.global_signal;
output = [moco, csf, wm, glob, cos1, cos2];
output=round(output,4);

% # Write output info to txt file
if contains(func_file, 'timeseries.tsv')
  output_name = split(func_file, 'timeseries.tsv');
else
  output_name = split(func_file, 'regressors.tsv');
end
output_name = [output_name{1}, 'SPM.txt'];

writematrix(output, output_name)
   
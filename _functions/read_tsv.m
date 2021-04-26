function table=read_tsv(filename)
% This is a small script to read in tsv files into a table. tsv files are
% basically csv files with tab instead of commas as separators. Matlab
% gets too confused with this.
%
% What this script does is to create a copy of the tsv file, change the
% filename to .csv, read the new file with readtable and delete the new
% file so that there is no trace of its use in the data folder.

% Copy the .tsv file into a .csv file
if IsWin
    cmd = sprintf('copy %s %s', filename, 'temp.csv');
else
    cmd = sprintf('cp %s %s', filename, 'temp.csv');
end
system(cmd);

% Read the .csv file
table=readtable('temp.csv');

% Delete the .csv file
if IsWin
    cmd = 'del temp.csv';
else
    cmd = 'rm temp.csv';
end
system(cmd);


end
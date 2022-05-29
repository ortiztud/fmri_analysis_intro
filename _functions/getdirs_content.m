% function [sufs, sub_code]=getdirs(main_folder, which_sub, varargin)
% Gets folder structure for a given participant.s
% A BIDS convention is assumed and the sufs variable here merely provides a
% handle for easier navigation through folders. It also outputs the
% participant code as a string to be used outside of this script.
% Usage: 
%    - main_folder: path to root folder of the project
%    - which_sub: subject id
%    - varargin: optional arguments.
%           - string: If provided, the first argument will be used as session label
%           to navigate BIDS folders.
%
% Author: Ortiz-Tudela (Goethe University)
% Created: 01.02.2020
% Last update: 14.04.2021

function [sufs, sub_code]=getdirs_content(main_folder, which_sub, varargin)
%% Folder names
sufs.BIDS = '/BIDS/';
sufs.preproc = '/preproc_data/fmriprep/';
sufs.outputs = '/outputs/';
sufs.brain = '/preproc_data/fmriprep/';

%% Sub code
if which_sub<10
    sub_code=['sub-0', num2str(which_sub)];
else
    sub_code=['sub-', num2str(which_sub)];
end

%% Session label
if isempty(varargin) || strcmpi(varargin{1}, '')
    sess_label = '';
else
    sess_label = ['ses-', varargin{1}];
end

%% Create subject folders names
sufs.BIDS=[main_folder,sufs.BIDS, sub_code,'/'];
sufs.events=[sufs.BIDS,sess_label,'/func/'];
sufs.preproc=[main_folder,sufs.preproc, sub_code,'/'];
sufs.anat=[sufs.preproc,'/anat/'];
sufs.func=[sufs.preproc,sess_label, '/func/'];
sufs.outputs=[main_folder,sufs.outputs, sub_code,'/'];
sufs.univ=[sufs.outputs, '/univ/'];
sufs.functions = [main_folder, '/../fmri_analysis_intro/_functions/'];

%% Create folders if they don't already exist
if ~exist(sufs.outputs);mkdir(sufs.outputs);end
if ~exist(sufs.univ);mkdir(sufs.univ);end

end

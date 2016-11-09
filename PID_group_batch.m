%%% PID_group_batch %%%

clear all; close all; 
addpath(genpath('/Users/katieshak/Documents/MATLAB/KS_functions/')); % add folder/subfolders to path
%% Call PID_group_plot in a batch of folders

anal_dir = uigetdir();
    %'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_11_22_Live/br2_58B_6fA/p1_hemi1_left';
cd(anal_dir);

cd('1-oil')
PID_group_plot;
cd('..');

cd('2-oct')
PID_group_plot;
cd('..');

cd('3-mch')
PID_group_plot;
cd('..');

cd('4-far')
PID_group_plot;
cd('..');

cd('5-ipa')
PID_group_plot;
cd('..');

cd('6-hac')
PID_group_plot;
cd('..');

cd('7-ben')
PID_group_plot;
cd('..');

% cd('1-oil')
% PID_group_plot;
% cd('..');
% 
% cd('2-BenLow')
% PID_group_plot;
% cd('..');
% 
% cd('3-BenMed')
% PID_group_plot;
% cd('..');
% 
% cd('4-BenHigh')
% PID_group_plot;
% cd('..');
% 
% cd('5-OctLow')
% PID_group_plot;
% cd('..');
% 
% cd('6-OctMed')
% PID_group_plot;
% cd('..');
% 
% cd('7-OctHigh')
% PID_group_plot;
% cd('..');

% cd('..');





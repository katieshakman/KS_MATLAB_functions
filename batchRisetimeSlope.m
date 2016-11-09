%%% RiseTime and Slope Batch

%% Clean slate: clear variables, close figures
clear all; close all;

%% Specify folders. Run RiseTimeWithinFly in each folder (for session). 
startDir = pwd; 

anal_dir = ...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_11_22_Live/br2_58B_6fA/p1_hemi1_left';
cd(anal_dir);
RiseTimeWithinFly; 
cd(startDir); 

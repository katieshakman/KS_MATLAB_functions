function output = organizeDirs(inputCSplus)
% clear; close all; 

%% Set parameters
filterToken = 'TSeries-Cycle*'; 
if strcmp(inputCSplus,'Oct')
    outDirStrings = {'Oil'; 'OctCS+'; 'MchCS-'}; 
else
    outDirStrings = {'Oil'; 'OctCS-'; 'MchCS+'}; 
end
prefix = 'PreProcessed/'; 
grouping = [1,2,3,1,2,3,1,2,3]; 

%% Set up 
% Get list of folders to be renamed
dirsToMove = dir(filterToken); 
ROItoMove = dir('ROI*'); 
% assert(length(dirsToMove) == length(grouping)); 

for idx = 1:length(outDirStrings)
    newDir = outDirStrings{idx};
    if ~isdir(newDir)
        mkdir(newDir);
    end
end
%% Rename/move folders as specified
for idx = 1:length(grouping)
    destination = strcat(prefix,outDirStrings{grouping(idx)},'/',dirsToMove(idx).name);
    mkdir(destination); 
    addpath(destination); 
    copyfile(dirsToMove(idx).name, destination);
    copyfile(ROItoMove(1).name, strcat(prefix,outDirStrings{grouping(idx)},'/')); 
%     movefile('projects/testcases','projects/myfiles/')
end

%% Set output 
output = 'Done'; 
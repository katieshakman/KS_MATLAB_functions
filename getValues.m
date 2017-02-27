%function [output] = getValues(vari)
% Load and save or print all instances of variable from folder and immediate subfolders


% setup
clear all; close all; 
vari = '*evokedPeak*';

% get subfolders
myDir = pwd; 
allContent = dir(myDir); 
trueDirs = allContent([allContent().isdir]); % use logical indexing to remove non-folders
trueDirs = struct2table(trueDirs);
dirNames = trueDirs.name;

% get instances of variable (input to function) in each folder and
% each subfolder (but not parent folder '..')
data = []; % init
counter = 0; % initialize 
for idx=1:length(dirNames)
    if strcmp(dirNames{idx},'..') % find the index of parent folder '..'
        ; % skip this folder
    else
        cd(dirNames{idx}); 
        % display directory moved into: 
        disp(pwd)
        localData = struct2table(dir(vari)); % gets names of data files
        for dat = 1:size(localData.name,1)
            counter = counter + 1; 
            try 
                fileName = localData.name{dat};
            catch
                fileName = localData.name; 
            end
            tempDat = load(fileName);

            fields = fieldnames(tempDat);
            for i = 1:numel(fields) % should be only 1 field 
                gotDat = tempDat.(fields{1});
                disp('got it')
            end
            data = [data; gotDat];
        end
        cd(myDir);
    end
end

% Put it all together into a table:

index = (1:length(data))';

data = array2table(data);  
data.index = index;

try
    names = dirNames(3:end);
    names = cell2table(names);
    names.index = index;
    myData = join(names,data)
    disp('OK.  Names and data are the same length.')
catch % If 1-oil has no data in it for the specified type 
    names = dirNames(3:end);
    names = names(2:end);
    names = cell2table(names);
    names.index = index;
    myData = join(names,data)
    disp('CAUTION: Check to make sure the names and data line up.')
end

myData.data
            

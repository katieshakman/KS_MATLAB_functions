%%% data_prep4PCA %%%

clear all; close all; 
startDir = pwd; 

% target folder for analysis 
targetDir = '/Users/katieshak/Desktop/Data_Analysis_Temp/mixed_traces';

% list of data folders
dataDirList = {...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br3/p1_hemi1'; ...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br4/p1_hemi1'; ...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br1_58B_6fA/p1_hemi1';...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br2_58B_6fA/p1_hemi1';...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_21_Live/br1_58B_6fA/p1_hemi1_left';...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_23_Live/br1_58B_6fA/p1_hemi1_right';...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_23_Live/br2_58B_6fA/p1_hemi1_left';...
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_26_Live/br1_58B_6fA/p1_hemi1_left'...
    };
% list of trial type subfolders:
subDirList = {...
    '1-oil';...
    '2-oct';...
    '3-mch';...
    '4-far';...
    '5-ipa';...
    '6-hac';...
    '7-ben'...
    };

% for each folder, copy files of correct type 
% to the target analysis folder
for dirIdx = 1:length(dataDirList)
    % try to change into each data folder
    cd_success = 0; % initialize 
    try
        cd(dataDirList{dirIdx});
        cd_success = 1;
    catch 
        display('Error for dirIdx = ');
        display(dirIdx);
        cd_success = 0;
        continue; 
    end
    
    if cd_success == 1
        % try to change into each subfolder
        for subIdx = 1:length(subDirList)
            try
                cd(dataDirList{dirIdx}); % back up a level
                cd(subDirList{subIdx});
                tempContents = dir('*TSeries*.mat');
                %display(tempContents);
                for contIdx = 1:length(tempContents)
                    destName = strcat(targetDir,'/',subDirList{subIdx},tempContents(contIdx).name);
                    copyfile(tempContents(contIdx).name,destName);
                    %display('Copyfile success.');
                end
            catch
                display('Error copying from folder:');
                display(subDirList{subIdx}); 
            end
        end
    else
        display('Unsuccessful change of dir.')
    end
    
end
cd(startDir);


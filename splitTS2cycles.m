function outputDir = splitTS2cycles(TSdir)

%% Parameters
startDir = pwd; 
lenCycleID = 10; 
numFilesToSkip = 6; 
% Note: Currently assuming the max cycle ID is 9.  
xmlToken = 'TSeries*.xml';
envToken = 'TSeries*.env'; 
%% List all the relevant files in the directory 
if ~exist('TSdir')
    TSdir = pwd; 
end
cd(TSdir); 
allFiles = dir(); 
allTifs = dir('*.tif');
% Calculate length of a cycle in total files
allCycleFirst = dir('*Cycle00001*'); 
if isempty(allCycleFirst)
    allCycleFirst = dir('*Cycle00002*'); 
    allCycleFirstTifs = dir('*Cycle00002*.tif');
else
    allCycleFirstTifs = dir('*Cycle00001*.tif');
end
cycleLen = length(allCycleFirst);
% Calculate length of a cycle in tifs 
cycleLenTifs = length(allCycleFirstTifs); 

% Calculate number of cycles
numCycles = length(allTifs)/cycleLenTifs; 

%% Separate cycle files into their own subfolders
allFilesTab = struct2table(allFiles);
for cnum = 1:numCycles
    subDirName = strcat('TSeries-Cycle',num2str(cnum)); 
    mkdir(subDirName); 
    % Move files from (cnum-1)*cycleLen + 1, thru (cnum)*cycleLen
    for idx = ...
            (((cnum-1)*cycleLen + 1) + numFilesToSkip) : ...
            (cnum*cycleLen + numFilesToSkip)
        copyfile(allFiles(idx).name,subDirName); 
    end
end

%% Deal with other files that should be copied to all cycles
toCopyToAllXML = dir(xmlToken);
for itemNo = 1:length(toCopyToAllXML)
    if isempty(strfind(toCopyToAllXML(itemNo).name,'Cycle'))
        disp(strcat('Copying: ', toCopyToAllXML(itemNo).name)); 
        for cnum = 1:numCycles
            subDirName = strcat('TSeries-Cycle',num2str(cnum));
            copyfile(toCopyToAllXML(1).name, subDirName);
        end
    end
end

%% Return to original directory and set output 
cd(startDir) 
outputDir = pwd; 

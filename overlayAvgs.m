% Overlay averages from each group on a single plot. 

% note: may want to add PID traces 
% as a second plot

% clear all; close all; 

% user variables:
xmin = 2; % lower bound of x-axis for plot
xmax = 8; % upper bound of x-axis for plot

% Choose parent folder containing group subfolders. 
startDir = pwd;
parentDir = uigetdir();
cd(parentDir);
dirAll = dir()
dirVec = [dirAll(:).isdir] % logical vector
dir_list = cellstr({dirAll(dirVec).name}'); % note: still has . and ..
clear dirAll; clear dirVec; 

% loop through and load average trace from each folder. 
% plot while looping. 

overlayFig = figure; 
%tPts_list = []; % initialize
subIdx = 0; % initialize
legendList = []; % initialize
for dirIdx = 1:length(dir_list)
    subFold = [dir_list{dirIdx,1}];
    if ~strcmp(subFold(1,1), '.') % to ignore . and ..
        subIdx = subIdx +1; % iterate for a real subfolder
        cd(subFold);
        % load time points:
        found_tPts = dir('*tPts*');
        load(found_tPts.name);
        tPts_list{subIdx,1} = tPts(1,:); % take first line of tPts 
        % load average trace: 
        found_avgdFoF = dir('*avg_dFoF*'); 
        load(found_avgdFoF.name);
        avgTrace_list{subIdx,1} = avg_dFoF;
        % add the new data to the plot: 
        hold all; 
        plot(tPts_list{subIdx,1},avgTrace_list{subIdx,1}); 
        % add identifier to legend list:
        legendList = [legendList;found_avgdFoF.name(1:end-13)];
        % move back up to parent directory:
        cd('..');
                display(pwd)
    end
end
% add a legend, title, etc. to the plot
leg = legend(legendList,'Location','NorthWest');
set(leg,'Interpreter','none');
xlim([xmin,xmax]);
% save the plot as a fig and as a jpg, in parentDir
saveas(overlayFig, [parentDir,'_overlay'],'fig');
saveas(overlayFig, [parentDir,'_overlay'],'jpg');




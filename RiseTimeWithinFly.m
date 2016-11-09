% RiseTimeWithinFly

%% Clean slate: clear variables, close figures
clear all; close all;

%% Get folders to analyze (within fly)
startDir = pwd; % may change this to uigetdir
cd(startDir);

odorList = {'oil'; 'oct'; 'far';}; % defines folders to go into

%% Get peak timings and rise slopes for files in each folder

% loop thru odorList to get folders to go into
TSdFoFlist = []; % init list of names
TStPtlist = []; % init list of names
TSdFoFvals = []; % init
TStPtvals = []; % init
slopeList = cell(length(odorList),1); % init
risetimeList = cell(length(odorList),1); % init
for odori = 1:length(odorList)
    % go into folder
    toFind = strcat('*',odorList{odori});
    tempDirs = dir(toFind);
    cd(tempDirs(1).name);
    % get data (both timePoints and deltaFoverF)
    clear tempTSdFoFlist; % reset temp variables 
    clear tempTStPtlist; % reset temp variables
    tempTSdFoFlist = dir('TS*delFoverF.mat');
    tempTStPtlist = dir('TS*timePoints.mat');
    clear tempTSdFoFdata; % reset temp variables 
    clear tempTStPtdata; % reset temp variables 
    % load TSeries*delFoverF and TSeries*timePoints
    for filei = 1:length(tempTStPtlist)
        tempTSdFoFdata{filei,1} = load(tempTSdFoFlist(filei).name);
        tempTStPtdata{filei,1} = load(tempTStPtlist(filei).name);
        % find index corresponding to max for given TS:
        % find first timepoint after 3s: 
        AfterOdorOn = (tempTStPtdata{filei,1}.timePoints > 3) ;
        BeforeOdorOff = (tempTStPtdata{filei,1}.timePoints < 5) ;
        DuringOdor = AfterOdorOn(BeforeOdorOff);
        DuringOdorTimes = tempTStPtdata{filei,1}.timePoints(DuringOdor);
        DuringOdordFoF = tempTSdFoFdata{filei,1}.delFoverF(DuringOdor);
        % find location of peak 
        tempPeak = max(DuringOdordFoF); 
        itempPeak = find(DuringOdordFoF == tempPeak);
        if ((tempPeak - DuringOdordFoF(1)) == 0)
            tempSlope = 0;
        else
            tempSlope = (tempPeak - DuringOdordFoF(1))...
                /(DuringOdorTimes(itempPeak)-DuringOdorTimes(1));
        end
        % Note: could also just have tempPeak as numerator for tempSlope, 
        % since the rise should be relative to baseline.
                % tempSlopebaseln = (tempPeak)...
                % /(DuringOdorTimes(itempPeak)-DuringOdorTimes(1));
        
        slopeList{odori} = [slopeList{odori}; tempSlope];
        risetimeList{odori} = ...
            [risetimeList{odori}; DuringOdorTimes(itempPeak)];

    end
    TSdFoFlist = [TSdFoFlist;tempTSdFoFlist];% append new ones to bottom
    tempTStPtlist = dir('TS*timePoints.mat');
    TStPtlist = [TStPtlist;tempTStPtlist]; % append new ones to bottom
    % Could assert that timePoints and delFoverF are same length for each trial
    %
    % move back to starting directory
    cd(startDir);
end
%% Save peak timings and slopes
save('risetimeList','risetimeList');
save('slopeList','slopeList');
%% Plot peak timings and slopes
% plot peak/rise timings
riseFig = figure; 
hold on
for odori = 1:length(odorList)
    x = 1:length(risetimeList{odori,1});
    y = risetimeList{odori,1};
    plot(x,y);
end
hold off 
legend(odorList);
% plot slopes 
slopeFig = figure; 
hold on
for odori = 1:length(odorList)
    x = 1:length(slopeList{odori,1});
    y = slopeList{odori,1};
    plot(x,y);
end
hold off 
legend(odorList);
%% Save plots
saveas(riseFig, 'riseFig'); 
saveas(slopeFig, 'slopeFig');

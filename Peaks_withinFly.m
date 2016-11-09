% Peaks_withinFly
% this version seems buggy as of 12/14/2015. 
clear all; close all;

% list the odors to look for in the starting folder
%%odors = {'oil', 'oct','mch','far','ipa','hac','ben'}';
odors = {'oil', 'BenL','BenM','BenH','OctL','OctM','OctH'}';
% initialize the cell arrays that will hold data
peakFilenames = cell(size(odors)); % init
peakData = cell(size(odors)); % init
% loop thru odors from above list. 
for odorIdx = 1:length(odors)
    % find .mat files associated with the odor 
    %%toFind = ['*',odors{1,odorIdx},'*.mat'];
    toFind = ['*',odors{odorIdx,1},'*trial_dfPeak*.mat'];
    % get the filename(s) of the .mat file(s)
    peakFilenames{odorIdx,1} = dir(toFind);
    % load the data from the appropriate .mat file
    peakData{odorIdx,1} = load(peakFilenames{odorIdx,1}.name);
end
% find the number of trials from the loaded data structure
numTrials = length(peakData{1,1}.dfPeak);
% prepare to plot the peak data for each trial and odor
xdata = 1:length(odors);
figure; 
% loop through the trials
for trialIdx = 1:numTrials
    % get peaks from each odor (for given trial #) to plot
	ydata = nan(size(odors));
    for odorIdx = 1:length(odors)
        ydata(odorIdx) = peakData{odorIdx,1}.dfPeak(trialIdx);
    end
    hold all
    % plot peaks for all the odors for the given trial
    plot(xdata,ydata);
    hold off
end
legend(num2str(xdata'));

% PID_group_plot

clear all; close all;
%%
%function PID_group_plot
% specify figure numbers for diff figures; 
indivsFigNo = 1;
allTogFigNo = 2; 
% specify y axis limits:
y_limits = [0,1];

% get all PID fig objects in folder
dirPID = dir('PID*.fig');
% dirPID = flipud(dirPID);

% load all PID fig files
PIDfig = []; % init
allYData = []; % init
allXData = [];
allpi = [];
for pi = 1:length(dirPID)
    tempName = dirPID(pi,1).name;
    tempStruc = load(tempName,'-mat');
    PIDfig = [tempStruc; PIDfig];
% make a figure with each PID fig as a subplot
    YData = tempStruc.hgS_070000.children.children(1,1).properties.YData;
    XData = (1/1000)*tempStruc.hgS_070000.children.children(1,1).properties.XData;
%     figure(indivsFigNo); % plot on indivsFigNo figure
%     subplot(length(dirPID),1,pi);
%     plot(XData,YData);
    figure(allTogFigNo); % plot on allTogFigNo figure
    subplot(2,1,1)
    hold all
    plot(XData,YData);
    hold off
    ylims = y_limits;
% save x and y data from each
    allYData = [allYData; YData];
    allXData = [allXData; XData];
    allpi = [allpi; pi];
end
% save axes from allTogFigNo figure subplot (2,1,1):
ylims = ylim; 
ylim(y_limits);
xlim([2 7]);
hleg = legend(num2str(allpi));
%   v = get(hleg,'title');
%   set(v,'string','Trial #:');
xlabel('seconds');
ylabel('PID');
% get a title: 
workingDir = pwd; 
display(workingDir(end-10:end));
prompt = 'Please type a title string (e.g. "Oct"): '
titleStr = input(prompt,'s');
title(titleStr);

% make a figure with all PID figs overlaid
avgX = mean(allXData);
avgY = mean(allYData);
PIDfig = figure(allTogFigNo); % plot on allTogFigNo figure
subplot(2,1,2)
plot(avgX,avgY);
ylim(ylims);
xlim([2 7]);
ylim(y_limits); % user-specified y axis limits
xlabel('seconds');
ylabel('Mean PID');

%% Save figure
saveas(PIDfig,'PIDgroup','jpg');
Display('Figure saved'). 


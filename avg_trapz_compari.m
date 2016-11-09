% avg trapz comparison

clear all; close all;
myFolder = pwd;
allNormAvg_list = [];
stop = 0;
max_tries = 25;
xlabels = {'Oil', 'Oct', 'Far'};
% Compile list of allNormAvg files from each folder.
for tryi = 1:max_tries
    if stop<1
        try
            currDir = uigetdir();
            cd(currDir);
            allNormAvg_temp = dir('allNormAvg*');
            if isempty(allNormAvg_temp)
                allNormAvg_temp = dir('allNormAvg*');
                if isempty(allNormAvg_temp)
                    display('No allNormAvg found in directory.')
                end
            end
            tempName = allNormAvg_temp.name;
            
            tempData = load(tempName);
            allNormAvg_list = [tempData.allNormAvg(:), allNormAvg_list];
            
        catch
            prompt = 'Do you want to add more data? y/n [y]: ';
            stopIfY = input(prompt,'s');
            if isempty(stopIfY)
                stopIfY = 'Y';
            end
            if strcmp(stopIfY,'n')
                stop = 1;
                break;
            end
    end
    prompt = 'Do you want to add more data? y/n [y]: ';
    stopIfY = input(prompt,'s');
    if isempty(stopIfY)
        stopIfY = 'Y';
    end
    if strcmp(stopIfY,'n')
        stop = 1;
        break;
    end
    end
end
% Switch back to starting folder
cd(myFolder);
% Plot data from each trialset (all odors, same fly) in a different color
fig = figure;
hold all;
x_vec = (1:size(allNormAvg_list,1));
for numBrain = 1:size(allNormAvg_list,2)
    y_vec = allNormAvg_list(:,numBrain);
    plot(x_vec,y_vec,'--s','LineWidth',1,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',10)
end
set(gca,'xtick',x_vec,'xticklabel',xlabels);
hold off;
hleg = legend;
prompty = 'Type an identifier for the figure:';
str = input(prompty,'s');
saveas(fig,['avg_trapz_comparison',str],'fig');
saveas(fig,['avg_trapz_comparison',str],'png');


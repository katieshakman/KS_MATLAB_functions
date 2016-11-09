% list_avg_peaks_compari
% calls: peaks_compari_prep

% avg peaks comparison, also evoked peak comparison

clear all; close all;

myFolder = pwd;
odors = {'oil', 'oct','mch','far','ipa','hac','ben'};
xlabels = odors;
odorA = odors{1,2};
odorB = odors{1,3};
max_tries = 25;
% dataDirList = {...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br3/p1_hemi1';   
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br4/p1_hemi1';
% };
dataDirList = {...
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br3/p1_hemi1';   
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br4/p1_hemi1';...
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br1_58B_6fA/p1_hemi1';...    
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br2_58B_6fA/p1_hemi1';... 
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_21_Live/br1_58B_6fA/p1_hemi1_left';...
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_23_Live/br1_58B_6fA/p1_hemi1_right';...
'/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2015_10_26_Live/br1_58B_6fA/p1_hemi1_left';...
};
dataDirList = flipud(dataDirList);
exptID = cell(dataDirList); % init
allNormAvg_list = []; % initialize
evokedAvg_list = [];
evokedP_list = [];
for folder_idx = 1:size(dataDirList,1) % num folders
    exptID{folder_idx,1} = num2str(folder_idx);
    dataFolder = dataDirList{folder_idx,:}; % or specify a list and take first from list instead
    cd(dataFolder);
    peaks_compari_prep(dataFolder,odors);
    % Compile list of allNormAvg files from each folder:
    allNormAvP_temp = dir('allNormAvPeak*');
    ev_temp = dir('*evokedAvg*');
    evP_temp = dir('*evokedPeak*');
%     if isempty(allNormAvP_temp) 
%         allNormAvP_temp = dir('allNormAvPeak*');
%         ev_temp = dir('*evokedAvg*');
%         evP_temp = dir('*evokedPeak*');
%         if isempty(allNormAvP_temp)
%             display('No allNormAvPeak found in directory.')
%         end
%     end
    tempName = allNormAvP_temp.name;
    tempEvName = ev_temp.name;
    tempEvPName = evP_temp.name;
    tempData = load(tempName);
    tempEvData = load(tempEvName);
    tempEvPData = load(tempEvPName);
    allNormAvg_list = [tempData.allNormAvPeak(:), allNormAvg_list];
%     evokedAvg_list = [tempEvData.evokedAvg(:),  evokedAvg_list];
%     evokedP_list = [tempEvPData.evokedPeak(:),  evokedP_list];
    % If we're out of folders, we're done.  Otherwise,
    % looping continues.
end
% Switch back to starting folder:
cd(myFolder);
%% Plot data from each trialset (all odors, same fly) in a different color
fig = figure;
hold all;
colorOrder = get(gca,'ColorOrder');
x_vec = (1:size(allNormAvg_list,1));
for numBrain = 1:size(allNormAvg_list,2)
    color = colorOrder(numBrain,:);
    y_vec = allNormAvg_list(:,numBrain);
    plot(x_vec,y_vec,'--s','LineWidth',1,...
        'MarkerFaceColor',color,...
        'MarkerEdgeColor',color,...
        'MarkerSize',5)
end
set(gca,'xtick',x_vec,'xticklabel',xlabels);
hold off;
hleg = legend(exptID,'Location','SouthEast');
% avg_per_odor = mean(allNormAvg_list,2);
% avg_for_yvec = mean(y_vec);
allNormAvgForStats = allNormAvg_list';
% evokedAvgForStats = evokedAvg_list';
% evokedPeakForStats = evokedP_list';
% % avgPerOdor_allNormAvgForStats = mean(allNormAvgForStats);
[p,~,stats] = anova1(allNormAvgForStats);
% % % [p,~,stats] = anova1(evokedAvgForStats);
[c,~,~,gnames]  = multcompare(stats,'CType','hsd');
%%
% prompty = 'Type an identifier for the figure:';
% str = input(prompty,'s');
% saveas(fig,['avg_trapz_comparison',str],'fig');
% saveas(fig,['avg_trapz_comparison',str],'png');



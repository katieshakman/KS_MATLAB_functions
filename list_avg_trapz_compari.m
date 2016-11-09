% avg trapz comparison
% also evoked peak comparison

clear all; close all;
% addpath('/Users/katieshak/code/MATLAB-extras/');
%%
myFolder = pwd;
% odors = {'oil', 'Oct', 'Vin','OctVin', 'H2O'};
% odors = {'oil', 'oct','mch','far','ipa','hac','ben'};
odors = {'oct','far','ipa','hac','ben'}; % short odors list
% odors = {'oil', 'BenLow','BenMed','BenHigh','OctLow','OctMed','OctHigh'};
% odors = {'oil', 'Ben10XDil','Ben1X','BenPt1XAmp','Oct100XDil','Oct10X','Oct1X'};
% odors = {'1-oil', '2-Ben10XDil', '3-Ben1X', '4-BenPt1XAmp', '5-Oct100XDil','6-Oct10X','7-Oct1X'};
xlabels = odors;
odorA = odors{1,1};
odorB = odors{1,2};
% max_tries = 25;
% dataDirList = {...
% %     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/Br1_58B_6fE/p1_hemi1_right';...
% %     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br2_58B_6fE/p1_hemi1_left';...
% %     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br3_58B_6fE/p1_hemi1_right';...
%     };
% dataDirList = {...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br2_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br4_NonTetCtrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br1_NonTetCtrl/p1_hemi1_left';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br1_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_03_Live/Br1_NonTetCtrl/p1_hemi1_bot';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_05_Live/br2_NonTet_Ctrl/p1_hemi1_topRight';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_07_Live/br3_NonTeT_Ctrl/p1_hemi1_topRight';...
% };
dataDirList = {... 
    '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_08_08_Live/br2_82C10LexA6f/p1_hemi1_L_Border_mv1'};


dataDirList = flipud(dataDirList);
exptID = cell(dataDirList); % init
allNormAvg_list = []; % initialize
evokedAvg_list = [];
evokedP_list = [];
for folder_idx = 1:size(dataDirList,1) % num folders
    exptID{folder_idx,1} = num2str(folder_idx);
    dataFolder = dataDirList{folder_idx,:}; % or specify a list and take first from list instead
    cd(dataFolder);
    trapz_compari_prep(dataFolder,odors);
    % Compile list of allNormAvg files from each folder:
    allNormAvg_temp = dir('allNormAvg*');
    ev_temp = dir('*evokedAvg*');
    evP_temp = dir('*evokedPeak*');
    if isempty(allNormAvg_temp) || isempty(allNormAvg_temp)
        allNormAvg_temp = dir('allNormAvg*');
        ev_temp = dir('*evokedAvg*');
        evP_temp = dir('*evokedPeak*');
        if isempty(allNormAvg_temp)
            display('No allNormAvg found in directory.')
        end
    end
    tempName = allNormAvg_temp.name;
    try    
        tempEvName = ev_temp.name;

    tempEvPName = evP_temp.name;
    tempData = load(tempName);
    tempEvData = load(tempEvName);
    tempEvPData = load(tempEvPName);
    allNormAvg_list = [tempData.allNormAvg(:), allNormAvg_list];
    evokedAvg_list = [tempEvData.evokedAvg(:),  evokedAvg_list];
    evokedP_list = [tempEvPData.evokedPeak(:),  evokedP_list];
    catch
        ;
    end
    % If we're out of folders, we're done.  Otherwise,
    % looping continues.
end
% Switch back to starting folder:
cd(myFolder);
%% Plot data from each trialset (all odors, same fly) in a different color
% fig = figure;
% hold all;
% colorOrder = get(gca,'ColorOrder');
% x_vec = (1:size(allNormAvg_list,1));
% for numBrain = 1:size(allNormAvg_list,2)
%     color = colorOrder(numBrain,:);
%     y_vec = allNormAvg_list(:,numBrain);
%     plot(x_vec,y_vec,'--s','LineWidth',1,...
%         'MarkerFaceColor',color,...
%         'MarkerEdgeColor',color,...
%         'MarkerSize',5)
% end
% set(gca,'xtick',x_vec,'xticklabel',xlabels);
% hold off;
% hleg = legend(exptID,'Location','SouthEast');
% % avg_per_odor = mean(allNormAvg_list,2);
% % avg_for_yvec = mean(y_vec);
% allNormAvgForStats = allNormAvg_list';
% evokedAvgForStats = evokedAvg_list';
% evokedPeakForStats = evokedP_list';
% avgPerOdor_allNormAvgForStats = mean(allNormAvgForStats);
%% compute stats
% % [p,~,stats] = anova1(allNormAvgForStats);
% [p,~,stats] = anova1(evokedAvgForStats);
% [c,~,~,gnames]  = multcompare(stats,'CType','bonferroni')
%%
% prompty = 'Type an identifier for the figure:';
% str = input(prompty,'s');
% saveas(fig,['avg_trapz_comparison',str],'fig');
% saveas(fig,['avg_trapz_comparison',str],'png');



% avg trapz comparison
% also evoked peak comparison

clear all; close all;
% addpath('/Users/katieshak/code/MATLAB-extras/'); 
% addpath('/Users/katherineshakman/code/MATLAB-extras/');
%%
cd /Volumes/KATIELAB1/Data_Analysis/2015_10_13_Live/br1_58B_6fA/p1_hemi1/2-oct; 
myFolder = pwd;
% odors = {'oil', 'Oct', 'Vin','OctVin', 'H2O'};
odors = {'oil', 'oct','mch','far','ipa','hac','ben'};
% odorsSorted = {'oil', 'oct','hac','mch','ipa','far','ben'};
% odors = {'oct','far','ipa','hac','ben'}; % short odors list
% odors = {'oil', 'BenLow','BenMed','BenHigh','OctLow','OctMed','OctHigh'};
% odors = {'oil', 'Ben10XDil','Ben1X','BenPt1XAmp','Oct100XDil','Oct10X','Oct1X'};
% odors = {'1-oil', '2-Ben10XDil', '3-Ben1X', '4-BenPt1XAmp', '5-Oct100XDil','6-Oct10X','7-Oct1X'};
xlabels = odors;
odorA = odors{1,1};
odorB = odors{1,2};
% max_tries = 25;
% dataDirList = {...
%     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/Br1_58B_6fE/p1_hemi1_right';...
%     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br2_58B_6fE/p1_hemi1_left';...
%     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br3_58B_6fE/p1_hemi1_right';...
%     };
% dataDirList = {...
%     '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/Br1_58B_6fE/p1_hemi1_right';...
%     '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br2_58B_6fE/p1_hemi1_left';...
%     '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_26_Live/br3_58B_6fE/p1_hemi1_right';...
%     };
dataDirList = {...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br3/p1_hemi1';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_11_Live/br4/p1_hemi1';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br1_58B_6fA/p1_hemi1';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_13_Live/br2_58B_6fA/p1_hemi1';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_21_Live/br1_58B_6fA/p1_hemi1_left';...
%     '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_21_Live/br2_58B_6fA/p1_hemi1_right';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_23_Live/br1_58B_6fA/p1_hemi1_right';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_23_Live/br2_58B_6fA/p1_hemi1_left';...
    '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2015_10_26_Live/br1_58B_6fA/p1_hemi1_left';...
    };
% dataDirList = {...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br2_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br4_NonTetCtrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br1_NonTetCtrl/p1_hemi1_left';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br1_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_03_Live/Br1_NonTetCtrl/p1_hemi1_bot';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_05_Live/br2_NonTet_Ctrl/p1_hemi1_topRight';...
% '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_04_07_Live/br3_NonTeT_Ctrl/p1_hemi1_topRight';...
% };
% dataDirList = {...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br2_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br4_NonTetCtrl/p1_hemi1_right';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_09_Live/br1_NonTetCtrl/p1_hemi1_left';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_03_29_Live/br1_NonTet_Ctrl/p1_hemi1_right';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_04_03_Live/Br1_NonTetCtrl/p1_hemi1_bot';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_04_05_Live/br2_NonTet_Ctrl/p1_hemi1_topRight';...
% '/Users/katherineshakman/CloudStation/2Photon/Data_Analysis_Temp/Data_Analysis/2016_04_07_Live/br3_NonTeT_Ctrl/p1_hemi1_topRight';...
% };
% dataDirList = {... 
%     '/Users/katieshak/Desktop/Data_Analysis_Temp/Data_Analysis/2016_08_08_Live/br2_82C10LexA6f/p1_hemi1_L_Border_mv1'};
% dataDirList = {'/Users/katherineshakman/Desktop/Analysis_Temp/Data_Analysis/2016_11_08_Live/br2_V1Tet_71D08L6f/p1_hemi1_R'}; 

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
%         tempEvName = ev_temp.name;
%         tempEvPName = evP_temp.name;
        tempData = load(tempName);
%         tempEvData = load(tempEvName);
%         tempEvPData = load(tempEvPName);
        allNormAvg_list = [tempData.allNormAvg(:), allNormAvg_list];
%         evokedAvg_list = [tempEvData.evokedAvg(:),  evokedAvg_list];
%         evokedP_list = [tempEvPData.evokedPeak(:),  evokedP_list];
    catch
        disp('Problem getting the allNormAvg_list etc entries.');
    end
    % If we're out of folders, we're done.  Otherwise,
    % looping continues.
end
% Switch back to starting folder:
cd(myFolder);
%% Plot data from each trialset (all odors, same fly) in a different color
fig = figure;
hold all;
nBrains = size(allNormAvg_list,2);
cmap = jet(nBrains);
x_vec = (1:size(allNormAvg_list,1));
for numBrain = 1:nBrains
    color = cmap(numBrain, :);
    y_vec = allNormAvg_list(:,numBrain);
    plot(x_vec,y_vec,'--s','LineWidth',1,...
        'Color',color,...
        'MarkerFaceColor',color,...
        'MarkerEdgeColor',color,...
        'MarkerSize',5)
end
set(gca,'xtick',x_vec,'xticklabel',odors);
hold off;
hleg = legend(exptID,'Location','SouthEast');
% avg_per_odor = mean(allNormAvg_list,2);
% avg_for_yvec = mean(y_vec);
% allNormAvgForStats = allNormAvg_list';
% evokedAvgForStats = evokedAvg_list';
% evokedPeakForStats = evokedP_list';
% avgPerOdor_allNormAvgForStats = mean(allNormAvgForStats);
%% Sorted odors figure
odorMeans = mean(allNormAvg_list,2); 
[meansSorted,meansOrder] = sort(odorMeans);
allNormAvg_list_sorted = allNormAvg_list(meansOrder,:); 
fig = figure;
hold all;
x_vec = (1:length(odors)); 
for numBrain = 1:nBrains
    color = cmap(numBrain, :);
    y_vec = allNormAvg_list_sorted(:,numBrain);
    plot(x_vec,y_vec,'--s','LineWidth',1,...
        'Color',color,...
        'MarkerFaceColor',color,...
        'MarkerEdgeColor',color,...
        'MarkerSize',5)
end
set(gca,'xtick',x_vec,'xticklabel',odors(1,meansOrder));
hold off;
hleg = legend(exptID,'Location','SouthEast');
%% Sorted odors boxplots
odorMeans = mean(allNormAvg_list,2); 
[meansSorted,meansOrder] = sort(odorMeans);
allNormAvg_list_sorted = allNormAvg_list(meansOrder,:); 

cmap = lines(length(odors)); 
redLineColor = cmap(2,:); 
greenLineColor = cmap(5,:); 

figure; whitebg('w'); 
hold all;
x_vec = ones(1,nBrains); 
for odorIdx = 1:length(odors)
    if odorIdx == 1
        color = 'k';
    elseif ismember(odorIdx,[2 5 6])
        color = redLineColor ; 
    else
        color = greenLineColor ; 
    end     
    y_vec = allNormAvg_list_sorted(odorIdx,:);
    plot(odorIdx*x_vec,y_vec,'--s','LineWidth',1,...
        'LineStyle','none',...
        'Color',color,...
        'MarkerFaceColor',color,...
        'MarkerEdgeColor',color,...
        'MarkerSize',5)
end
plot(1:length(odors),meansSorted,'k+'); 
boxplot(allNormAvg_list_sorted','Colors','k')
set(gca,'xtick',1:length(odors),'xticklabel',odors(1,meansOrder));
xlim([0 length(odors)+1])
hold off;
% hLegend = legend({'Mean Response','No Odor','Aversive Odor','Appetitive Odor'},'Location','SouthEast');
hLegend = legend({'No Odor','Aversive Odor','Appetitive Odor'},'Location','SouthEast');
hYLabel = ylabel('Response Magnitude (AUC)');
hXLabel = xlabel('Odor'); 
hTitle = title('Odor Responses in V1 Axons  '); 
hText = text(0,0,''); 
% Make it prettier
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel, hText], ...
    'FontName'   , 'Helvetica');
set([hLegend, gca]             , ...
    'FontSize'   , 12           );
set([hXLabel, hYLabel, hText]  , ...
    'FontSize'   , 16          );
set( hTitle                    , ...
    'FontSize'   , 16          , ...
    'FontWeight' , 'bold'      );
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'      , 0:1:2, ...
  'LineWidth'   , 1         );

set(gcf, 'PaperPositionMode', 'auto');
% print -depsc2 odor_valence_independence.eps;
% cd('/Users/katherineshakman/Dropbox/Axel Lab Dropbox/JClub and LM Papers and Notes/MyPresentations/Figures/'); 
% print -depsc2 odor_valence_independence.eps
print -depsc2 '/Users/katherineshakman/Dropbox/Axel Lab Dropbox/JClub and LM Papers and Notes/MyPresentations/KBSColumbiaLatexTemplate/Chapter1/odor_valence_independence.eps'
% close;
% print -depsc myEPS.eps
%% Save figure with specified identifier
% prompty = 'Type an identifier for the figure:';
% str = input(prompty,'s');
% saveas(fig,['avg_trapz_comparison',str],'fig');
% saveas(fig,['avg_trapz_comparison',str],'png');
%% compute stats
% % figure; 
% [p,tbl,stats] = anova1(allNormAvg_list_sorted');
% % [p,tbl,stats ] = kruskalwallis(allNormAvgForStats)
% % [p,~,stats] = anova1(evokedAvgForStats);
% figure; 
% [c,~,~,gnames]  = multcompare(stats,'CType','bonferroni') 
% % [c,~,~,gnames]  = multcompare(stats,'CType','hsd') 




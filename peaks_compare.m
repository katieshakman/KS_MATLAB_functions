% peaks compare

% peaks comparison across flies and trials
% Normalize peaks to best response for that set of trials
% Note: uses padcat function from MATLAB FileExchange
function peaks_compare(odors)
% odors = {'oil', 'oct','mch','far','ipa','hac','ben'};
% For each fly/trial set: 

    % Get best trial from set (collection of odors for one fly)
    allPeaks_names = dir('*trial_dfPeak*.mat');
    allPeaks = cell(size(allPeaks_names));
    allAvg_names = dir('*_avg_dfPeak*.mat');
    allAvg = nan(size(length(allAvg_names)));

    for label = 1:length(allPeaks_names)
            tempP = load(allPeaks_names(label).name);
            tempP = tempP.dfPeak;
         allPeaks{label} = tempP; clear tempP;
            tempA = load(allAvg_names(label).name);
            tempA = tempA.avgdfPeak
         allAvg(label,:) = tempA
         clear tempA;
    end
    
    % Normalize all peak measurements to best trial 
    tempy = cat(1,allPeaks{:});
    normBy = max(tempy); clear tempy;
    allNormPeaks = padcat(2,allPeaks{:})/normBy;
    
    % Average across all of each trial type.  
    % i.e. Collect norm'd avg AOC for each trial type, for the fly

    allNormAvPeak = allAvg/normBy
    save('allNormAvPeak','allNormAvPeak');
    
% Plot

% Plot norm'd avg Peakss (one per odor per fly) as a 
% pre-post type of plot (e.g. connecting lines for all 
% odor for each fly).  Need odor labels on x axis. 
fig = figure; 
xlabels = odors;
% xlabels = {'Oil', 'Oct', 'MCH', 'Far', 'IpA', 'HAc', 'Ben'};
x = (1:length(allNormAvPeak))-1; 
plot(x,allNormAvPeak,'--s','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5)
set(gca,'xtick',x,'xticklabel',xlabels);

presentDir = pwd; 
fig_savefile = [presentDir(max(strfind(presentDir,'/')+1):end), 'Peak_sumFig'];
saveas(fig, fig_savefile, 'fig'); 
saveas(fig, fig_savefile, 'png'); 
 
end
% AOC trapz comparison across flies and trials
% Normalize AOC trapz to best response for that set of trials
function AOC_trapz_compare(odors)
% For each fly/trial set: 

    % Get best trial from set (collection of odors for one fly)
    allDataInLabels = dir('*AOC*.mat');
    vec_count = 0; % init
    avg_count = 0; 
    odor_count = 0; 
    allAvg = [];
    allData = [];
    allOdorAvg = [];
    for label = 1:length(allDataInLabels)
        avg_pos = strfind(allDataInLabels(label).name,'avg_AOC_trapz');
        tempData = load(allDataInLabels(label).name) ;
        if isempty(avg_pos)
            try
                allData = [allData; tempData.Atrapz];
                vec_count = vec_count + 1;
            catch 
                allOdorAvg = [allOdorAvg; tempData.avgAOdortrapz];
                odor_count = odor_count + 1; 
            end
        else
            allAvg = [allAvg; tempData.avgAtrapz];
            avg_count = avg_count + 1;
        end
    end

    % Normalize all AOC measurements to best trial 
    normBy = max(allData);
    allNormData = allData/normBy;
    
    % Average across all of each trial type.  
    % i.e. Collect norm'd avg AOC for each trial type, for the fly

    allNormAvg = allAvg/normBy; 
    save('allNormAvg','allNormAvg');
    save('allAvg','allAvg');
    save('allOdorAvg','allOdorAvg');
    
% Plot

% Plot norm'd avg AOCs (one per odor per fly) as a 
% pre-post type of plot (e.g. connecting lines for all 
% odor for each fly).  Need odor labels on x axis. 
fig = figure; 
xlabels = odors;
% xlabels = {'Oil', 'Oct', 'MCH', 'Far', 'IpA', 'HAc', 'Ben'};
x = (1:length(allNormAvg))-1; 
plot(x,allNormAvg,'--s','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5)
set(gca,'xtick',x,'xticklabel',xlabels);

presentDir = pwd; 
fig_savefile = [presentDir(max(strfind(presentDir,'/')+1):end), 'AOC_sumFig'];
saveas(fig, fig_savefile, 'fig'); 
saveas(fig, fig_savefile, 'png'); 
 

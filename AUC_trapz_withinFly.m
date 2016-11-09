% AUC_trapz_withinFly

% odors = {'oil', 'oct','mch','far','ipa','hac','ben'};
odors = {'Oil', 'Oct', 'Vin','OctVin', 'H2O'};
trapzFilenames = cell(size(odors)); % init
trapzData = cell(size(odors)); % init
for odorIdx = 1:length(odors)
    toFind = ['*',odors{1,odorIdx},'*.mat'];
    trapzFilenames{1,odorIdx} = dir(toFind);
    trapzData{1,odorIdx} = load(trapzFilenames{1,odorIdx}.name);
end
numTrials = length(trapzData{1,1}.Atrapz);
xdata = 1:length(odors);
figure; 
for trialIdx = 1:numTrials
	ydata = nan(size(odors));
    for odorIdx = 1:length(odors)
        ydata(odorIdx) = trapzData{1,odorIdx}.Atrapz(trialIdx);
    end
    hold all
    plot(xdata,ydata);
    hold off
end
legend(num2str(xdata'));
% coloredBoxPlot by Katie Shakman - 2/23/2017

function coloredBoxPlot(data, labelNums, labels, ...
    edgeColors, boxStyle, fillColor, opacity, indicesToFill,yRange)

% choose option 1 or 2 for plotting
option = 1; 
addScatter = 'on'; 

if option == 1
    boxplot(data, labels, ...
        'Widths', 0.3, 'Colors', edgeColors, 'Boxstyle', boxStyle)
    % Inspired by
    % www.mathworks.com/matlabcentral/newsreader/view_thread/300245:
    h = findobj(gca,'Tag','Box');
    for j=indicesToFill
        patch(get(h(j),'XData'),get(h(j),'YData'),fillColor,'FaceAlpha',opacity);
    end
    ylim(yRange);
    box off;
    if strcmp(addScatter,'on')
        hold on 
        for idx = min(labelNums):max(labelNums)
            scatterG = data(labelNums==idx)
            position = ones(size(scatterG))*idx
            scatter(position, scatterG); 
        end
    end
elseif option == 2
%     notBoxPlot(data,[],'jitter',0.5); % not implemented yet, since
%     different input data format 
else
    display('Please specify an option for coloredBoxPlot and retry.')
end
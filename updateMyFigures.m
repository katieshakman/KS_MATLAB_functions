% Katie Shakman 2/3/2017
% Update all axes on all open figures

% example usage: updateMyFigures([2 7 -0.1 0.5])

function updateMyFigures(newAxesLimits)
set(0, 'ShowHiddenHandles', 'on')
figHandles = get(0, 'Children');
for idx = 1:length(figHandles)
    h = figHandles(idx);
    set(groot,'CurrentFigure',h);
    % get axes handles: 
    % https://www.mathworks.com/matlabcentral/newsreader/view_thread/14207
    hAllAxes = findobj(gcf,'type','axes');
    hLeg = findobj(hAllAxes,'tag','legend');
    hAxes = setdiff(hAllAxes,hLeg); % All axes which are not
    for axIdx = 1:length(hAxes)
        hCurAx = hAxes(axIdx);
        axes(hCurAx)
        axis(newAxesLimits)
    end
end
end


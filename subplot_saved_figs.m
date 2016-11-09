% Subplot from 2 Saved Figures
% Katie Shakman 2016-03-28
% Based on: 
% http://www.mathworks.com/matlabcentral/answers/85219-subplot-of-already-saved-figures

function subplot_saved_figs()

% Load saved figures
saved1 = uigetfile('*.fig','Select the first figure'); 
saved2 = uigetfile('*.fig','Select the next figure');
c=hgload(saved1);
k=hgload(saved2);
% Prepare subplots
figure
h(1)=subplot(1,2,1);
h(2)=subplot(1,2,2);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
% % Add legends
% l(1)=legend(h(1),'LegendForFirstFigure');
% l(2)=legend(h(2),'LegendForSecondFigure');

end
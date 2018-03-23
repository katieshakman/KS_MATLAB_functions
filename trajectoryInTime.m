% trajectoryInTime
% Katie Shakman - 3/27/2017

%clear; 
close all; 
% Designed to use matlab-exported version of ann file from ctrax. 

z = 1:length(x);
col = 1:length(x);  % This is the color, vary with x in this case.
figure; 
surf([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
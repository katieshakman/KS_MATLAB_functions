% In a given folder, list all the .fig files.  
% For each, open and save as a .jpg file. 

function fig2jpg(folder)
    figList = dir('*.fig');
    for i = 1:length(figList)
        if strcmp(figList(i,1).name(1),'.')
            display('skipped'); % skip
        else
            figName = figList(i,1).name;
            outName = [figList(i,1).name(1:end-4),'.jpg'];
            h=openfig(figName,'new','invisible');
            saveas(h,outName,'jpg');
            close(h);
        end
    end
end
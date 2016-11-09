% peaks compari prep
% calls: peaks_compare
% called by: list_avg_peaks_compari

% function to batch process data for odor A vs odor B AOC comparison
function peaks_compari_prep(folder, odors)
% make folder for Odor A v Odor B
Z = odors{1,1};
Aname = odors{1,2};
Bname = odors{1,3};

newDir = [Aname,'V',Bname];
mkdir(newDir); % TODO: May eliminate this part in the future. 

% copy A and B and Z trapz files into new folder
for odorIdx = 1:size(odors,2)
    toFind = ['*',odors{1,odorIdx},'*.mat'];
    curList = dir(toFind);
    for idx = 1:size(curList,1)
        copyfile(curList(idx,1).name,newDir);
    end
end

cd(newDir);
peaks_compare(odors);

end

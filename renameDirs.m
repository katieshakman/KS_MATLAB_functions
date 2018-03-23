function output = renameDirs()

filterToken = 'Cycle*'; 
newPrefix = 'TSeries-'; 

dirList = dir(filterToken); 

for idx = 1:length(dirList)
    movefile(dirList(idx).name,strcat(newPrefix,dirList(idx).name)); 
end

output = pwd; 
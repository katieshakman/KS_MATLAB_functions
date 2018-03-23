% combineFigs

% To open previously saved figures and combine them into a single figure. 

function output = combineFigs(oldfigh, newfigh)

% Inputs to function are handles of two open figures. 
oldax = get(oldfigh,'Children'); 
newax = get(newfigh,'Children'); 

oldax_1c = get(oldax(1),'Children'); 
newax_par = newax(1); 

newobj = copyobj(oldax_1c,newax_par); 
output = gcf; 
function [imgArray700, imgArray800,hasWhite,numberOfScans] = script_odyssey_data(folderName)

cd(folderName) %go to folder selected by the user
count = 1;
listingFolders = dir(folderName); %listing the directory in a struct

if isunix
    begin = 4;
else
    begin = 3;
end

% go from first folder in de directory to the last one alphabetically
for i = begin : size(listingFolders,1)
    
    currentDir = strcat(folderName,'/',listingFolders(i,1).name);
    if(isdir(currentDir))
        
        cd(currentDir)
        
        %get the information of the files inside the folder
        info700 = dir('*700*');
        info800 = dir('*800*');

        
        %get the data using Bio-Formats toolbox
        data700 = bfopen(info700.name);
        data800 = bfopen(info800.name);
      
        
        %get the image by itself (image matrix)
        imgArray700(:,:,1,count) = data700{1,1}{1,1};
        imgArray800(:,:,1,count) = data800{1,1}{1,1};
          
        count = count+1;
    end 
end
numberOfScans=count-1;
hasWhite=false;
end
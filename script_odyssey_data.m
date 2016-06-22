function [imgArray700, imgArray800,hasWhite] = script_odyssey_data(folderName)


cd(folderName) %go to folder selected by the user
count = 1;
listingFolders = dir(folderName); %listing the directory in a struct

% go from first folder in de directory to the last one alphabetically
for i = 4 : size(listingFolders,1)
    
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
        img700 = data700{1,1}{1,1};
        img800 = data800{1,1}{1,1};
        
        %creates the array of images
        imgArray700{count}= img700;
        imgArray800{count}= img800;
        
        
        
        
        count = count+1;
    end
    
   
end
hasWhite=false;
end
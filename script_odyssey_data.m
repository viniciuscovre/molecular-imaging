function [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans] = script_odyssey_data(experimentFolders,prescanFolder,channel1,channel2,hasWhite)

count=1;

%get the images from prescan
cd(prescanFolder{1,1});
prescan700= dir(strcat('*',channel1,'*'));
prescan800= dir(strcat('*',channel2,'*'));
if hasWhite
    prescanWhite = dir('*White*');
end

%get the data using Bio-Formats toolbox
prescanData700 = bfopen(prescan700.name);
prescanData800 = bfopen(prescan800.name);
if hasWhite
    prescanDataWhite = bfopen(prescanWhite.name);
end

prescanImg700(:,:,1,count) = prescanData700{1,1}{1,1};
prescanImg800(:,:,1,count) = prescanData800{1,1}{1,1};
if hasWhite
    prescanImgWhite(:,:,1,count) = prescanDataWhite{1,1}{1,1};
end

%get the images from the experiment folders
for i= 1:length(experimentFolders)
    cd(experimentFolders{1,i});
    
    %get the information of the files inside the folder
    info700= dir(strcat('*',channel1,'*'));
    info800= dir(strcat('*',channel2,'*'));
    if hasWhite
        infoWhite = dir('*White*');
    end
    
    %get the data using Bio-Formats toolbox
    data700 = bfopen(info700.name);
    data800 = bfopen(info800.name);
    if hasWhite
        dataWhite = bfopen(infoWhite.name);
    end
    
    
    %get the image by itself (image matrix)
    imgArray700(:,:,1,count) = data700{1,1}{1,1};
    imgArray800(:,:,1,count) = data800{1,1}{1,1};
    if hasWhite
        imgArrayWhite(:,:,1,count) = dataWhite{1,1}{1,1};
    end
    
    count = count+1;
    
end
numberOfScans=count-1;

if ~hasWhite
        imgArrayWhite=0;
        prescanImgWhite=0;
    end
end
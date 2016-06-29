function [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans] = script_pearl_data(experimentFolders,prescanFolder,channel1,channel2,hasWhite)
% MOTION CORRECTION USING COREGIS ALGORITHM

%   Script for motion correction of molecular images of tissues. It uses
%   Bio-Formats toolbox (bfopen) for data loading* and the Coregis
%   algorithm as part of the pre-processing part for motion correction.

%   * A series of images are taken from samples called Pearl Data where
%   each folder is a unit of time (of a series in time) that has 3 images:
%   a targeted image (800nm), a control image (700nm) and a white image
%   (used for comparison motion adjust). The extra txt file in the
%   directory is used to get the exact time unit used in each case, and
%   other details.
%
%   LOAD_PEARL_SERIES(DIR)

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

%{
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
        infoWhite = dir('*White*');
        acquisition= dir('*acq*');
        
        %get the data using Bio-Formats toolbox
        data700 = bfopen(info700.name);
        data800 = bfopen(info800.name);
        dataWhite = bfopen(infoWhite.name);
        acq= fopen(acquisition.name);
        
        %get the image by itself (image matrix)
        imgArray700(:,:,1,count) = data700{1,1}{1,1};
        imgArray800(:,:,1,count) = data800{1,1}{1,1};
        imgArrayWhite(:,:,1,count) = dataWhite{1,1}{1,1};
        
        %creates the array of images
        
        
        tline = fgets(acq);
        while ischar(tline)
            if ~isempty(strfind(tline,'TimeStamp'))
                a=textscan(tline,'%s','delimiter','=');
                b=a{1,1};
                textData(count).timestamp= b{2,1};
            end
            tline = fgets(acq);
        end

        fclose(acq);
        
        %textData{count}=acq;
        
        count = count+1;
    end
    
end
numberOfScans=count-1;
hasWhite=true;


%}

end


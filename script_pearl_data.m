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

h=waitbar(0,'Loading Images...');
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
    
    waitbar(i/length(experimentFolders));
    
end
close(h);
numberOfScans=count-1;

    if ~hasWhite
        imgArrayWhite=0;
        prescanImgWhite=0;
    end

end


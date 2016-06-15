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

dialogTitle = 'Select Pearl Data Directory';
startPath = 'C:\';
folderName = uigetdir(startPath,dialogTitle);
cd(folderName); %go to folder selected by the user

listingFolders = dir(folderName); %listing the directory in a struct

% go from first folder in de directory to the last one alphabetically
for i = 4 : size(listingFolders,1)
    
    currentDir = strcat(folderName,'/',listingFolders(i,1).name);
    cd(currentDir);
    
    %get the information of the files inside the folder
    info700 = dir('*700*');
    info800 = dir('*800*');
    infoWhite = dir('*White*');
    
    %get the data using Bio-Formats toolbox
    data700 = bfopen(info700.name);
    data800 = bfopen(info800.name);
    dataWhite = bfopen(infoWhite.name);
    
    %get the image by itself (image matrix)
    img700 = data700{1,1}{1,1};
    img800 = data800{1,1}{1,1};
    imgWhite = dataWhite{1,1}{1,1};
    
    %motion correction
    [newImg700, newImg800] = coregis_2(img700, img800, imgWhite);
    
    %video stabilization
    
    
    %going to directory for the images after processing
    if ~exist('new', 'dir')
        mkdir new;
    end
    cd new
    
    %saving images
    imwrite(newImg700, [listingFolders(i).name '_700.png']);
    imwrite(newImg800, [listingFolders(i).name '_800.png']);
    
end

clc
function [imgArray700,imgArray800,imgArrayWhite,numOfScans] = script_csz_data(folderName, hasWhite)

if nargin < 1
    error('Insufficient Input Arguments');
    pause;
elseif nargin == 1
    hasWhite = true;
elseif nargin > 2
    error('Exceeded Number Of Input Arguments');
    pause;
end

cd(folderName) %go to folder selected by the user

%get the information of the files inside the folder
info700 = dir('*TRITC*'); %Targeted Image
info800 = dir('*Bodipy*'); %Control Image
if hasWhite
    infoWhite = dir('*AF647*');
end

%get the data using Bio-Formats toolbox
data700 = bfopen(info700.name);
data800 = bfopen(info800.name);
if hasWhite
    dataWhite = bfopen(infoWhite.name);
end

[numOfScans,~] = size(data700{1,1});

for i = 1 : numOfScans
    %get the image by itself (image matrix)
    imgArray700(:,:,1,i) = data700{1,1}{i,1};
    imgArray800(:,:,1,i) = data800{1,1}{i,1};
    if hasWhite
        imgArrayWhite(:,:,1,i) = dataWhite{1,1}{i,1};
    end 
end

end

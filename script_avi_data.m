function [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]...
    = script_avi_data(prescan700, prescan800, prescanWhite, hasWhite)

% % if nargin < 1
% %     error('Insufficient Input Arguments');
% %     pause;
% % elseif nargin == 1
% %     hasWhite = true;
% % elseif nargin > 2
% %     error('Exceeded Number Of Input Arguments');
% %     pause;
% % end
% 
% % count = 1;
% % 
% % %get the images from prescan
% % cd(prescanFolder{1,1})
% % prescan700= dir(strcat('*',channel1,'*'));
% % prescan800= dir(strcat('*',channel2,'*'));
% % if hasWhite
% %     prescanWhite = dir('*ratio*');
% % end

%get the data using Bio-Formats toolbox
prescanImg700 = bfopen(prescan700{1,1});
prescanImg800 = bfopen(prescan800{1,1});
if hasWhite
    prescanImgWhite = bfopen(prescanWhite{1,1});
end

[numberOfScans,~] = size(prescanImg700{1,1});

for i = 1 : numberOfScans
    %get the image by itself (image matrix)
    imgArray700(:,:,1,i) = prescanImg700{1,1}{i,1};
    imgArray800(:,:,1,i) = prescanImg800{1,1}{i,1};
    if hasWhite
        imgArrayWhite(:,:,1,i) = prescanImgWhite{1,1}{i,1};
    end 
end

end
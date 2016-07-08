function [moving_700,moving_800]=coregis_2(im700,im800,im_white)
% Inputs need to be image stacks with the same length
% function registers all the fluorescent images based on first white light image

im_white(isinf(im_white)) = 100; %make sure inf aren't a problem

[~,~,num]=size(im_white);
moving_700(:,:,:,1)=im700(:,:,:,1);
moving_800(:,:,:,1)=im800(:,:,:,1);
%figure;
for i=2:num
%     imshowpair(im_white(:,:,1),im_white(:,:,i),'Scaling','joint');
    % fixed        moving
    display(['Working on image number: ' num2str(i)]);
    [optimizer, metric] = imregconfig('monomodal');
    optimizer.MaximumIterations = 300;
    optimizer.MinimumStepLength = 5e-4;

    [white_fix tform] = imregister(im_white(:,:,:,i),im_white(:,:,:,1),'rigid', optimizer, metric);
    moving_700(:,:,:,i) = transformMovingImage_2(im700(:,:,:,i), im_white(:,:,:,1), tform);
    moving_800(:,:,:,i) = transformMovingImage_2(im700(:,:,:,i), im_white(:,:,:,1), tform);
    % moving                                      % fixed
%     imshowpair(im_white(:,:,1), white_fix,'Scaling','joint');
end

end
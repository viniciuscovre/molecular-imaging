function [im_u_n, factor_M] = pixelnorm(im_t,im_u, range)
% function to normalize two curves to the same scale based on a given range
[r c z numscan] = size(im_t);
im_u_n =  zeros(r,c,z,numscan);
temp_t = zeros(r,c);
temp_u = zeros(r,c);

for n = range(1):range(2)
    temp_t = temp_t + im_t(:,:,:,n);
    temp_u = temp_u + im_u(:,:,:,n);
end
factor_M = temp_t./temp_u;
factor_M(factor_M<0.1) = 0.1;
factor_M(factor_M>10) = 10;
[r1,c1,~] = find(isinf(factor_M));
for n = 1:numscan
    im_u_n(:,:,1,n) = im_u(:,:,1,n).*factor_M;
    % factor will fail for im_u = 0. Fix these with the following:
%     for p = 1:numel(r1)
%         im_u_n(r1(p),c1(p),1,n) = im_t(r1(p),c1(p),1,n);
%     end
end
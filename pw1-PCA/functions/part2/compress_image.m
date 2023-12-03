function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (height x width x 3), an image of size height x width over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels

    width = size(img,2);
    height = size(img,1);

    cimg = zeros(p,width,3);
    ApList = zeros(p,height,3);
    muList = zeros(height,3);


    for i=1:3
        [Mu, ~, V, ~] = compute_pca(img(:,:,i));
        [Y, Ap] = project_pca(img(:,:,i), Mu, V, p);
        
        muList(:,i) = Mu;
        ApList(:,:,i) = Ap;
        cimg(:,:,i) = Y;
         
    end

end


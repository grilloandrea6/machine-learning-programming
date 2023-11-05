function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(X,2);
N = size(X,1);
Mu = zeros(N,k);

switch init
    case 'sample'
        r = randsample(M,k);
        Mu = X(:,r);
        
    case 'range'
        Min = min(X,[],2);
        Max = max(X,[],2);
        Mu = Min + (Max - Min).*rand(2,k);

end


end
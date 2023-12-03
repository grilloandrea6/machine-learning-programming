function [d] =  distance_to_centroids(X, Mu, type)
%MY_DISTX2Mu Computes the distance between X and Mu.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Mu    : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : (k x M), distances between X and Mu 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(X,2);
k = size(Mu,2);
d = zeros(k,M);

for i=1:M
    for j=1:k
        d(j,i) = compute_distance(X(:,i),Mu(:,j),type);
    end
end


end
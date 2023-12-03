function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    index = find(deck);
    dist = zeros(size(Mu,2),1);
    for i = 1:size(Mu,2)
        dist(i) = compute_distance(deck(index),Mu(index,i),type);
    end
end


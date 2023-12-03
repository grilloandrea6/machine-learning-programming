function [cards] = recommend_cards(deck, Mu, type)
%RECOMMAND_CARDS Recommands a card for the deck in input based on the
%centroid of the clusters
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N, 1) a deck of card
%       o Mu : (M x k) the centroids of the k clusters
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o cards : a set of cards recommanded to add to this deck
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = deck_distance(deck,Mu,type);

[~, closest] = min(dist);

[~, idx] = sort(Mu(:,closest),'desc');

cards = idx(1:nnz(Mu(:,closest)));

 end
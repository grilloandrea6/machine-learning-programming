function [X, unique_cards] = prepare_data(data)
%PREPARE_DATA Convert the list of cards and deck to a matrix representation
%             where each row is a unique card and each column a deck. The
%             value in each cell is the number of time the card appears in
%             the deck
%
%   input -----------------------------------------------------------------
%   
%       o data   : (60, M) a dataset of M decks. A deck contains 60 non
%       necesserally unique cards
%
%   output ----------------------------------------------------------------
%
%       o X  : (N x M) matrix representation of the frequency of appearance
%       of unique cards in the decks whit N the number of unique cards in
%       the dataset and M the number of decks
%       o unique_cards : {N x 1} the set of unique card names as a cell
%       array
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


M = size(data,2);

unique_cards = unique(data);
X = zeros(length(unique_cards),M);

for i = 1:M % per ogni deck
    for j = 1:length(unique_cards) % per ogni unica carta%
        X(j,i) = sum(ismember(data(:,i),unique_cards(j))); % il numero di uniche carte in quel deck e
    end
end
end


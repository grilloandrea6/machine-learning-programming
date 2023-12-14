function [W, W0] = initialize_weights(LayerSizes, type)
%INITIALIZE_WEIGHTS Initialize the wieghts of the network according to the
%desired type of initialization
%   inputs:
%       o LayerSizes{L+1x1} Cell array containing the sizes of each layers.
%       Also contains the size of A0 input layer
%       o type (string) type of the desired initialization
%       ('random' or 'zeros')
%
%   outputs:
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
L = size(LayerSizes,2)-1;
W=cell(L,1);
W0=cell(L,1);

for l = 1:L
    switch type
        case 'random'
            W{l} = randn(LayerSizes{l+1},LayerSizes{l});
            W0{l} = randn(LayerSizes{l+1},1);
        case 'zeros'
            W{l} = zeros(LayerSizes{l+1},LayerSizes{l});
            W0{l} = zeros(LayerSizes{l+1},1);
    end
end
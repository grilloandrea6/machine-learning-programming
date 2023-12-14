function [Y, A, Z] = forward_pass(X, W, W0, Sigmas)
%FORWARD_PASS This function calculate the forward pass of the network with
%   inputs:
%       o X (NxM) The input data
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o Y (PxM) The output of the network, result of the activation
%       function of the last layer
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contain the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer

L = size(W, 1);

A = cell(L + 1, 1);
Z = cell(L, 1);

A{1} = X;

for l = 1 : L
    Z{l} = W{l} * A{l} + W0{l};
    A{l + 1} = forward_activation(Z{l}, Sigmas{l});
end

Y = A{L + 1};

end

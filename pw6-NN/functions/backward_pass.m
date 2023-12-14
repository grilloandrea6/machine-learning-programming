function [dZ, dW, dW0] = backward_pass(dE, W, A, Z, Sigmas)
%BACKWARD_PASS Perform a backward propogation through
%   inputs:
%       o dE (PxM) The derivative dE/dZL
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o b {Lx1} cell array containing the bias matrices for all the
%       layers
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contains the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o dZ {Lx1} cell array containing the derivatives dE/dZl values at
%       each layer
%       o dW {Lx1} cell array containing the derivatives of the weights at
%       each layer
%       o dW0 {Lx1} cell array containing the derivatives of the bias at
%       each layer

M = size(dE, 2);
L = size(W, 1);

dZ = cell(L, 1);
dW = cell(L, 1);
dW0 = cell(L, 1);

dZ{L} = dE;

for l = L - 1 : -1 : 1
    dZ{l} = (W{l+1}' * dZ{l+1}) .* backward_activation(Z{l}, Sigmas{l});
end    
for l = 1:L
    dW{l} = dZ{l} * A{l}' / M;
    dW0{l} = mean(dZ{l}, 2);
end

end
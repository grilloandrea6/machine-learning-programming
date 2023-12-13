function [newW, newW0] = update_weights(W, W0, dW, dW0, eta)
%UPDATE_WEIGHTS Compute the new values of the weights after backpropagation
%using the gradient descent rule
%   inputs:
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
%       o dW {Lx1} cell array containing the derivative of the weight
%       matrices for all the layers 
%       o dW0 {Lx1} cell array containing the derivative of the bias
%       matrices for all the layers
%       o eta (float) learning rate value
%
%   outputs:
%       o newW {Lx1} cell array containing the new weight matrices for
%       all the layers 
%       o newW0 {Lx1} cell array containing the new bias matrices for
%       all the layers
end
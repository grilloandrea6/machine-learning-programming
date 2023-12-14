function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function
[N, M] = size(Z);

switch Sigma
    case 'sigmoid'
        dZ = exp(-(Z)) ./ (exp(-(Z)) + 1).^2;
    case 'tanh'
        dZ = 1 - (exp(-Z) - exp(Z)).^2 ./ (exp(-Z) + exp(Z)).^2;
    case 'relu'
        %relu = max(0,Z);
        for n = 1:N
            for m = 1:M
                if Z(n,m) > 0
                    dZ(n,m) = 1;
                else
                    dZ(n,m) = 0;
                end
            end
        end
    case 'leakyrelu'
        %leakyrelu = max(.01*Z,Z);
        for n = 1:N
            for m = 1:M
                if .01*Z(n,m) > 0
                    dZ(n,m) = .01;
                else
                    dZ(n,m) = 0;
                end
            end
        end
        
        

end
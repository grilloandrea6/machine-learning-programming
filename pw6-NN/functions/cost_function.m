function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error
[P, M] = size(Y);

E = 0;

switch(type)
    case 'LogLoss'
        for m = 1:M
            E = E - (1 - Yd(:,m))' * log(1 - Y(:,m)) - Yd(:,m)' * log(Y(:,m));
        end
        E = E / M;
    case 'CrossEntropy'
        for p = 1:P
            for m = 1:M
                E = E - Yd(p, m) * log(Y(p, m));
            end
        end
        E = E / M;

end


end
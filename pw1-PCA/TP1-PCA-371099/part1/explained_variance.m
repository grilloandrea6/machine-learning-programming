function [ExpVar, CumVar, p_opt] = explained_variance(EigenValues, var_threshold)
%EXPLAINED_VARIANCE Function that returns the optimal p given a desired
%   explained variance.
%
%   input -----------------------------------------------------------------
%   
%       o EigenValues     : (N x 1), Diagonal Matrix composed of lambda_i 
%       o var_threshold   : Desired Variance to be explained
%  
%   output ----------------------------------------------------------------
%
%       o ExpVar  : (N x 1) vector of explained variance
%       o CumVar  : (N x 1) vector of cumulative explained variance
%       o p_opt   : optimal principal components given desired Var

    sumEig = sum(EigenValues);
    done = 0;
    CumVar = [];
    ExpVar = [];
    for i=1:length(EigenValues)
        if sum(EigenValues(1:i))/sumEig > var_threshold && done == 0
            p_opt = i;
            done = 1;
        end
        CumVar(i) = sum(EigenValues(1:i))/sumEig;
        ExpVar(i) = EigenValues(i)/sumEig;
    end

    CumVar = CumVar';
    ExpVar = ExpVar';

end


function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(y,2);

MSE = 0;
sumy = 0;
sumyest = 0;
sumcov = 0;
var = 0;

mu_y = mean(y,2);
mu_yest = mean(yest,2);

for i = 1:M
    MSE = MSE + (yest(:,i) - y(:,i))^2;
    var = var + (y(:,i) - mu_y)^2;

    sumy = sumy + (y(:,i) - mu_y)^2;
    sumyest = sumyest + (yest(:,i) - mu_yest)^2;
    sumcov = sumcov + (y(:,i) - mu_y) * (yest(:,i) - mu_yest);
end

MSE = MSE / M;
var = var / (M - 1);
NMSE = MSE / var;
Rsquared = sumcov^2 / (sumy * sumyest);

end


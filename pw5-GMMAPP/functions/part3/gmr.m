function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
M = size(X,2);
P = length(out);
K = length(Priors);

y_est = zeros(P,M);
var_est = zeros(P,P,M);

Mu_in = Mu(in,:);
Mu_out = Mu(out,:);

Sigma_in = Sigma(in,in,:);
Sigma_out = Sigma(out,out,:);

Sigma_inout = Sigma(in,out,:);
Sigma_outin = Sigma(out,in,:);

for m = 1:M
    denSum = 0;
    for k = 1:K
        denSum = denSum + Priors(k) * gaussPDF(X(:, m), Mu_in(:, k), Sigma_in(:, :, k));
    end
    for k = 1:K
        beta = Priors(k) * gaussPDF(X(:, m), Mu_in(:, k), Sigma_in(:, :, k)) / denSum;

        mutilde = Mu_out(:, k) + Sigma_outin(:, :, k) * inv(Sigma_in(:, :, k)) * (X(:, m) - Mu_in(:, k));
        y_est(:, m) = y_est(:, m) + beta * mutilde;

        sigmatilde = Sigma_out(:, :, k) - (Sigma_outin(:, :, k) * inv(Sigma_in(:, :, k)) * Sigma_inout(:, :, k));
        var_est(:, :, m) = var_est(:, :, m) + beta * (mutilde.^2 + sigmatilde);
    end

    var_est(:, :, m) = var_est(:, :, m) - y_est(:, m).^2;
end

end

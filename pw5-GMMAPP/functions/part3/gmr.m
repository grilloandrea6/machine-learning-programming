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
[N, M] = size(X);
P = length(out);
[D, K] = size(Mu);

y_est = zeros(P,M);
var_est = zeros(P,P,M);

MuX = Mu(1:N,:);
MuY = Mu(N+1:D,:);
SXX = Sigma(1:N,1:N,:);
SYY = Sigma(N+1:D,N+1:D,:);
SXY = Sigma(1:N,N+1:D,:);
SYX = Sigma(N+1:D,1:N,:);

for m = 1:M
    denSum = 0;
    for k = 1:K
        denSum = denSum + Priors(k) * gaussPDF(X(:, m), MuX(:, k), SXX(:, :, k));
    end
    for k = 1:K
        beta = Priors(k) * gaussPDF(X(:, m), MuX(:, k), SXX(:, :, k)) / denSum;

        mutilde = MuY(:, k) + SYX(:, :, k) / (SXX(:, :, k)) * (X(:, m) - MuX(:, k));
        y_est(:, m) = y_est(:, m) + beta * mutilde;

        sigmatilde = SYY(:, :, k) - (SYX(:, :, k) / (SXX(:, :, k)) * SXY(:, :, k));
        var_est(:, :, m) = var_est(:, :, m) + beta * (mutilde.^2 + sigmatilde);
    end

    var_est(:, :, m) = var_est(:, :, m) - y_est(:, m).^2;
end

end

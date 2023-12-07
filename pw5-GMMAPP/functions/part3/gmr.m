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
% % [N, M] = size(X);
% % K = length(Priors);
% % for i = 1:M
% %     denSum = 0
    % %     for k = 1:K
% %         denSum = denSum + gmmLogLik(X(in,i),Priors(k),Mu(:,k));
% %     end
% %     for k = 1:K
% %         beta(k) = gmmLogLik(X(in,i),Priors(k),Mu(:,k)) / denSum;
% %     end
% % 
% %     % now foreach point we have beta
% %     muTildeK = 
% % 
% % end


PXYT = zeros(1,size(X,2));
y_est = zeros(size(out,2),size(X,2));
var_est = zeros(size(out,2),size(out,2),size(X,2));

MuX = Mu(1:size(in,2),:);
MuY = Mu(size(in,2)+1:size(Mu,1),:);
SXX = Sigma(1:size(in,2),1:size(in,2),:);
SYY = Sigma(size(in,2)+1:size(Mu,1),size(in,2)+1:size(Mu,1),:);
SXY = Sigma(1:size(in,2),size(in,2)+1:size(Mu,1),:);
SYX = Sigma(size(in,2)+1:size(Mu,1),1:size(in,2),:);

for a = 1:size(X,2)
    summ = 0;
    for b = 1:size(Mu,2)
        PXYT(a) = PXYT(a) + (Priors(b)*gaussPDF(X(:, a), MuX(:, b), SXX(:, :, b)));
    end
    for b = 1:size(Mu,2)
        var_CD = SYY(:, :, b) - (SYX(:, :, b) / SXX(:, :, b) * SXY(:, :, b));
        beta = gaussPDF(X(:, a), MuX(:, b), SXX(:, :, b)) * Priors(b);
        lrf = MuY(:, b) + SYX(:, :, b) / SXX(:, :, b) * (X(:, a) - MuX(:, b));
        y_est(:, a) = y_est(:, a) + (beta * lrf / PXYT(a));
        summ = summ + (beta*(lrf.^2 + var_CD) / PXYT(a));
    end
    var_est(:, :, a) = summ - (y_est(:, a).^2);
end


end


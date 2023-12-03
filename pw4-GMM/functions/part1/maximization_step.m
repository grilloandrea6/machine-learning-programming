function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

[K, M] = size(Pk_x);
N = size(X,1);

Priors = zeros(1,K);
Mu = zeros(N,K);
Sigma = zeros(N,N,K);

for k = 1:K
    sum = 0;
    sumXi = 0;
    sumCov = 0;
    sumIso = 0;
    for i = 1:M
        gauss= Pk_x(k,i);
        sum = sum + gauss;
        sumXi = sumXi + gauss * X(:,i);
    end

    Priors(k) = sum/M;
    Mu(:,k) = sumXi/sum;

    for i = 1:M
        gauss= Pk_x(k,i);
        sumCov = sumCov + gauss * (X(:,i)-Mu(:,k))*(X(:,i)-Mu(:,k))';
        sumIso = sumIso + gauss * norm(X(:,i) - Mu(:,k))^2;
    end

    fullCov = sumCov / sum;
    switch params.cov_type
        case "full"
            Sigma(:,:,k) = fullCov;
        case "diag"
            Sigma(:,:,k) = diag(diag(fullCov));
        case "iso"
            Sigma(:,:,k) = eye(N) * sumIso / (N * sum);
    end
    
   Sigma(:,:,k) = Sigma(:,:,k) + 1e-5*eye(N);

end
end


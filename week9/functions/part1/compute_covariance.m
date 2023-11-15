function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

M = size(X,2);
N = size(X,1);
XX = X-X_bar;

switch type
    case 'full'
        Sigma = XX*XX' / (M-1);
    case 'diag'
        Sigma = XX*XX' / (M-1);

        Sigma = diag(Sigma(sub2ind(size(Sigma), 1:length(Sigma), 1:length(Sigma))));
    case 'iso'
        sum = 0;
        for i = 1:M
            sum = sum + norm(X(:,i) - X_bar)^2;
        end
        sum = sum / (N*M);
        Sigma = diag(ones(1,N)*sum);

end


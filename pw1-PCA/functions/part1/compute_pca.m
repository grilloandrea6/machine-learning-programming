function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix
    
    Mu = mean(X')';
    
    for i=1:size(X,2)    
        X(:,i) = X(:,i) - Mu;
    end
    
    C = (X * X') / (size(X,2) - 1);

    [vect,val] = eig(C);
    
    val = diag(val);
    
    [EigenValues,sorting_index] = sort(val,'descend');
    
    EigenVectors = vect(:,sorting_index);

end



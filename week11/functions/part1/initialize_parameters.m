function [data, Xtrain, Ytrain, Xtest, Ytest, params] = initialize_parameters(dataset_type)
%INITIALIZE_PARAMETERS Initialize the parameters to train a GMM classifier on the given data

%   input------------------------------------------------------------------
%       o dataset_type: (string) The choosen dataset (twospirals, halfernel or corners)
%
%   output ----------------------------------------------------------------
%       o data : (N x M) the loaded dataset
%       o Xtrain : (N x M_train), the matrix of features for  training 
%       o Ytrain : (1 x M_train), the vector of ground truth labels for
%                  training \in {0,...,N_classes} corresponding to Xtrain
%       o Xtest  : (N x M_test), the matrix of features for  testing 
%       o Ytest  : (1 x M_test), the vector of ground truth labels for
%                  testing \in {0,...,N_classes} corresponding to Xtest
%       o params : structure containing the hyperparameters corresponding
%                  to the selected dataset. Contains:
%           * valid_ratio: (double) selected validation ratio between train
%                          and test sets
%           * k: (int) number of Gaussians of the GMM
%           * cov_type: (string) type of covariance matrix (among iso, diag
%                        or full)
%%

% already initialized parameters to keep
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

switch dataset_type
    case 'twospirals'
        data = twospirals()';
        params.k = 10;
        params.cov_type = 'full';
        params.valid_ratio = 0.25;

    case 'halfkernel'
        data = halfkernel()';
        params.k = 4;
        params.cov_type = 'full';
        params.valid_ratio = 0.8;

    case 'corners'
        data = corners()';
        params.k = 2;
        params.cov_type = 'diag';
        params.valid_ratio = 0.25;
end
valid_trasf = 1/(1 + params.valid_ratio);
N = size(data,1);
[Xtrain, Ytrain, Xtest, Ytest] = split_data(data(1:N-1,:), data(N,:), valid_trasf);
data = data';



end


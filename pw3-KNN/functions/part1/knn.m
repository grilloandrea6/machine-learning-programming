function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_train = size(y_train,2);
M_test = size(X_test,2);

y_est = zeros(1,M_test);
d = zeros(1,M_train);

% for each point in the testing set
for i = 1:M_test
    
    %compute the distance from every point in the training set
    for j = 1:M_train
        d(j) = compute_distance(X_train(:,j),X_test(:,i),params);
    end

    [~,index] = sort(d,"ascend");
    
    index = index(1:params.k);

    y_est(i) = mode(y_train(index));
end


end
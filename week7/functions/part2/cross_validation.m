function [avgTP, avgFP, stdTP, stdFP] =  cross_validation(X, y, F_fold, valid_ratio, params)
%CROSS_VALIDATION Implementation of F-fold cross-validation for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (1 x M), a vector with labels y \in {1,2} corresponding to X.
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Training/Testing Ratio.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------
%
%       o avgTP  : (1 x K), True Positive Rate computed for each value of k averaged over the number of folds.
%       o avgFP  : (1 x K), False Positive Rate computed for each value of k averaged over the number of folds.
%       o stdTP  : (1 x K), Standard Deviation of True Positive Rate computed for each value of k.
%       o stdFP  : (1 x K), Standard Deviation of False Positive Rate computed for each value of k.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% K = length(params.k_range);
% FP_ = zeros(1,F_fold);
% TP_ = zeros(1,F_fold);
% 
% avgTP = zeros(1,K);
% avgFP = zeros(1,K);
% stdTP = zeros(1,K);
% stdFP = zeros(1,K);
% 
% 
% for k = 1:K
%     params.k = params.k_range(k);
% 
%     for i = 1:F_fold
%         [X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);
% 
%         y_est = knn(X_train,  y_train, X_test, params);
%         C = confusion_matrix(y_test, y_est);
%         TP_(i) = C(1,1)/(C(1,1) + C(1,2));
%         FP_(i) = C(2,1)/(C(2,1)+C(2,2));
%     end
% 
%     avgTP(k) = mean(TP_);
%     avgFP(k) = mean(FP_);
%     stdTP(k) = std(TP_);
%     stdFP(k) = std(FP_);
% end


TP_ = zeros(F_fold,length(params.k_range));
FP_ = zeros(F_fold,length(params.k_range));

for f = 1:F_fold
    [X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);

    [ tproc, fproc ] = knn_ROC( X_train, y_train, X_test, y_test,  params );
    TP_(f,:) = tproc(:);
    FP_(f,:) = fproc(:);

end

avgTP = mean(TP_);
avgFP = mean(FP_);
stdTP = std(TP_);
stdFP = std(FP_);
end
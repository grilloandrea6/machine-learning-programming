function [F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, true_labels)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%       o true_labels : (1 x M) the real labels for the F1 measure
%                       computation
%
%   output ----------------------------------------------------------------
%       o F1_curve   : (1 X K_range), F1 values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F1_ = zeros(1,repeats);

F1_curve = zeros(1,size(K_range,2));

for i=1:size(K_range,2)
    for j=1:repeats
        [labels, ~, ~, ~] = kmeans(X,K_range(i),init,type,MaxIter,false);
        F1_(j) = f1measure(labels,true_labels);
    end

    F1_curve(i) = mean(F1_,2);
end

end
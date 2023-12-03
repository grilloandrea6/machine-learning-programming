function [X1, Y1, X2, Y2] = split_dataset(features, labels, ratio, shuffle)
%SPLIT_DATASET Summary of this function goes here
%   Detailed explanation goes here

% first shuffle
if shuffle
    [Xshuffled, Yshuffled] = pick(randperm(length(features)), features, labels);
else
    [Xshuffled, Yshuffled] = pick(1:length(features), features, labels);
end

% pick only the first part
cut_idx = floor(ratio * length(features));
[X1, Y1] = pick(1:cut_idx, Xshuffled, Yshuffled);
[X2, Y2] = pick(cut_idx+1:length(features), Xshuffled, Yshuffled);
end


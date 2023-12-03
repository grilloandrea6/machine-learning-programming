function [X1, Y1, X2, Y2] = split_dataset_kept_ratio(features, labels, ratio, shuffle)
%SPLIT_DATASET Summary of this function goes here
%   Detailed explanation goes here

unique_labels = unique(labels(:,2));
nb_labels = length(unique_labels);

X1 = [];
Y1 = [];
X2 = [];
Y2 = [];
for i=1:nb_labels
    c = string(unique_labels{i});
    [Xtemp, Ytemp] = pick(labels(:,2) == c, features, labels);
    [X1temp, Y1temp, X2temp, Y2temp] = split_dataset(Xtemp, Ytemp, ratio, shuffle);
    X1 = [X1; X1temp];
    Y1 = [Y1; Y1temp];
    X2 = [X2; X2temp];
    Y2 = [Y2; Y2temp];
end
end


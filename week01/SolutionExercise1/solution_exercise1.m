clc;
clear;
close all;

load fisheriris

%% PICK, SHUFFLE AND SORT
% store the whole dataset
[Xall, Yall] = pick(1:length(meas), meas, species);
[Xodd, Yodd] = pick(1:2:length(meas), meas, species);

% sepal width > 3
[Xcond, Ycond] = pick(meas(:,2) > 3, meas, species);

% all versicolor
[Xversicolor, Yversicolor] = pick(species == "versicolor", meas, species);

% shuffled
[Xshuffled, Yshuffled] = pick(randperm(length(meas)), meas, species);

% sort but will not restore to the original dataset
[Ysorted, idx] = sort(Yshuffled);
Xsorted = Xshuffled(idx,:);

% add index column
Xindexed = [(1:length(meas)).', meas];
Yindexed = [num2cell(1:length(species)).', species];

% indexed shuffled
[Xindexed_suffled, Yindexed_shuffled] = pick(randperm(length(Xindexed)), Xindexed, Yindexed);

% indexed sorted
[~,idx] = sort(Xindexed_suffled(:,1));
[Xindexed_sorted, Yindexed_sorted] = pick(idx, Xindexed_suffled, Yindexed_shuffled);

%% SLICING
ratio = 0.75;
shuffle = true;
[X1, Y1, X2, Y2] = split_dataset(Xindexed, Yindexed, ratio, shuffle);
[X1k, Y1k, X2k, Y2k] = split_dataset_kept_ratio(Xindexed, Yindexed, ratio, shuffle);

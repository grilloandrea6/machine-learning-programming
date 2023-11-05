clc;
close all;
clear all;

load fisheriris;

%first four
[x, y] = pick([1,2,3,4], meas, species);

%whole dataset
[x, y] = pick(1:length(meas), meas, species);

%odd indexes
%conditional indexint, interesting!

%just 75 times the repetition of the 1:2 vector
rep = repmat(1:2,1,75);

% 1 if 
idx = (rep == 1);
[x, y] = pick(idx, meas, species);


% All the flowers of sepal width, i.e. second feature of meas, greater than 3
index = 1:length(meas);
[x, y] = pick((meas(index,2) > 3), meas, species);

% All the versicolor flowers
[x, y] = pick((species(index) == "versicolor"), meas, species);

%% sorting and shuffling

%random array of indexes
[x, y] = pick(1:length(meas),meas,species);

x = [(1:length(x))', x];

idx  = randperm(length(meas));
x_shuffled = x(idx,:);
y_shuffled = y(idx);

%try to sort data again
[x_sorted,sorting_index] = sort(x_shuffled(:,1));

x_original = x_shuffled(sorting_index,:);
y_original = y_shuffled(sorting_index,:);

assert(all(all((x_original-x) < 1e-4)))

% do NOT do this, messes with the associations between labels and data
%X = meas(randperm(length(meas)),:);
%y = species(randperm(length(species)),:);


%% SLICING DATA
ratio = 0.3;
[X1, y1, X2, y2] = split_dataset(meas, species, ratio);

% just have to implement the shuffling in the function and then run the
% tests from the exercise

assert(length(X1) == ratio * length(meas))
assert(all(all((sort(meas) - sort([X1;X2])) < 1e-4)))

assert(sum(y1 == "setosa") == ratio * length(meas) / 3);

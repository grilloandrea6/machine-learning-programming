load fisheriris
close all;

%% my_grp2idx testing
assert(length(unique(my_grp2idx(species))) == 3)
assert(all(grp2idx(species) == my_grp2idx(species)))
idx = 75;
categories = grp2idx(species);
unique_categories = unique(species);
assert(species(idx) == string(unique_categories(categories(idx))))

%% part4 - data visualization

clear all;
load fisheriris

X = meas;
y = grp2idx(species);

%size(X) and y

labels = {'sepal length','sepal width','petal length','petal width'};
pairs = combnk(1:4,2); %all the combinations of 1:4 by couples
Xsetosa = X(y == 1,:);
Xversicolor = X(y == 2,:);
Xvirginica = X(y == 3,:);

figure(1)
plot2dsamples(Xsetosa, Xversicolor, Xvirginica, pairs, labels)

figure(2)
plothistogram(Xsetosa, Xversicolor, Xvirginica, labels)

figure(3)
plotboxplots(X, species, labels)



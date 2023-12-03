function [X1, y1, X2, y2] = split_dataset(features, labels, ratio)
    firstLenght = length(features)*ratio;

    [X1, y1] = pick(1:firstLenght,features,labels);

    idx  = randperm(length(X1));
    X1 = X1(idx,:);
    y1 = y1(idx);


    [X2, y2] = pick(firstLenght+1:length(features),features,labels);
    
    idx  = randperm(length(X2));
    X2 = X2(idx,:);
    y2 = y2(idx);
end
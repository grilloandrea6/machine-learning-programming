function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[elementsPerClass,classes] = groupcounts(class_labels');
[elementsPerCluster,clusters] = groupcounts(cluster_labels');

nClasses = size(classes,1);
nClusters = size(clusters,1);

M = size(class_labels,2);

P = zeros(nClusters,nClasses);
R = zeros(nClusters,nClasses);
F1 = zeros(nClusters,nClasses);


for i=1:nClusters
    for j=1:nClasses
        
        nik = 0;

        for idx=1:M
            if cluster_labels(idx) == clusters(i) && class_labels(idx) == classes(j)
                nik = nik + 1;
            end
        end
        
        R(i,j) = nik/elementsPerClass(j);
        P(i,j) = nik/elementsPerCluster(i);
        if(R(i,j)+P(i,j) == 0)
            F1(i,j) = 0;
        else
            F1(i,j) = 2*R(i,j)*P(i,j) / (R(i,j)+P(i,j));
        end
    end
end


F1_overall = 0;

for j=1:nClasses
    F1_overall = F1_overall + (elementsPerClass(j) * max(F1(:,j))/ M);
end

end
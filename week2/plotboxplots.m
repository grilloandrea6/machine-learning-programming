function [] = plotboxplots(X, species, labels)
for i = 1:length(labels)
    subplot(2,2,i)
    

    boxplot(X(:,i), species)
    xlabel('Species')
    ylabel(labels(i))

end

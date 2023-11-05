function [] = plothistogram(Xsetosa, Xversicolor, Xvirginica, labels)
for i = 1:length(labels)
    subplot(2,2,i)
    
    histogram(Xsetosa(:,i), 'FaceAlpha', .7, 'FaceColor', 'b');
    hold on
    histogram(Xversicolor(:,i), 'FaceAlpha', .7, 'FaceColor', 'g');
    hold on
    histogram(Xvirginica(:,i), 'FaceAlpha', .7, 'FaceColor', 'r');
    xlabel(labels{i})
    ylabel("count")
end
end
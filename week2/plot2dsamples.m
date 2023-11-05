function [] =  plot2dsamples(Xsetosa, Xversicolor, Xvirginica, pairs, labels)

%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:length(pairs)
    subplot(2,3, i)
    plot([Xsetosa(:,pairs(i,1)) Xversicolor(:,pairs(i,1)) Xvirginica(:,pairs(i,1))], ...
     [Xsetosa(:,pairs(i,2)) Xversicolor(:,pairs(i,2)) Xvirginica(:,pairs(i,2))],'.')
    xlabel(labels{pairs(i,1)})
    ylabel(labels{pairs(i,2)})
end



end
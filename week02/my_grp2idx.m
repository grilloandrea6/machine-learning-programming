function [indexRet] = my_grp2idx(array)
%UNTITLED2 Summary of this function goes here

len = 0;

values = ["setosa"];


indexRet = [];

for i = 1:length(array)
    if not(any(values == string(array(i))))
        values(end+1) = string(array(i));
    end

    indexRet(i) = find(values==string(array(i)));
end

indexRet = indexRet';
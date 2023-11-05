function [feature, species] = pick(i, features_table, species_table)
%PICK Summary of this function goes here
%   Detailed explanation goes here
feature = features_table(i,:);
species = species_table(i,:);
end


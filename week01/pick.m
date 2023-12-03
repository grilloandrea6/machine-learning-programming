function [feature,species] = pick (i, features_table, species_table)
    feature = features_table(i,:);
    species = species_table(i);
end
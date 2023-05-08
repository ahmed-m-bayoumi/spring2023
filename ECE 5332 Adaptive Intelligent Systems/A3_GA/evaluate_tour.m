function distance = evaluate_tour(tour, dist_matrix)
% Evaluate total distance of tour
num_cities = length(tour);
distance = 0;
for i = 1:num_cities
    j = mod(i, num_cities) + 1;
    distance = distance + dist_matrix(tour(i),tour(j));
end
end
function dist_matrix = generate_distance_matrix(num_cities)
% Generate random distance matrix
dist_matrix = rand(num_cities) * 10;
dist_matrix = triu(dist_matrix,1) + triu(dist_matrix,1)';
end
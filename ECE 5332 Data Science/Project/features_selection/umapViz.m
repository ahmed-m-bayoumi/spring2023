% Create a UMAP object
umap_obj = run_umap('n_components', 2, 'n_neighbors', 15, 'min_dist', 0.1);

% Fit the UMAP object to your data
reduced_data = umap_obj.fit(feature_matrix);

% Plot the reduced data
figure;
scatter(reduced_data(:, 1), reduced_data(:, 2));
xlabel('UMAP1');
ylabel('UMAP2');
title('UMAP Plot');
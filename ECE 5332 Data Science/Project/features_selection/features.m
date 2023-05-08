% Load NIfTI files
func_filename = 'C:\Users\abayoumi\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RawData\DATI\AD\subj_01\warsubj_01_functional.nii';
struct_filename = 'C:\Users\abayoumi\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RawData\DATI\AD\subj_01\y_subj_01_structural.nii';

func_data = niftiread(func_filename);
struct_data = niftiread(struct_filename);

% Convert 3D/4D images to 2D feature matrices
func_data = double(func_data);
struct_data = double(struct_data);

if ndims(func_data) == 4
    [x, y, z, t] = size(func_data);
    func_data = reshape(func_data, [x * y * z, t]);
else
    [x, y, z] = size(func_data);
    func_data = reshape(func_data, [x * y * z, 1]);
end

[x, y, z] = size(struct_data);
struct_data = reshape(struct_data, [x * y * z, 1]);

% Perform simple feature selection (e.g., variance threshold)
% Adjust the threshold value as needed
var_threshold = 0.1;

% For functional data
func_var = var(func_data, 0, 2);
selected_func_features = find(func_var > var_threshold);

% For structural data
struct_var = var(struct_data);
selected_struct_features = find(struct_var > var_threshold);

% Output the selected features as vectors
selected_func_feature_vector = func_data(selected_func_features, :);
selected_struct_feature_vector = struct_data(selected_struct_features);
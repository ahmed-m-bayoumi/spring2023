subjects = [01 02 03 04 06 07 08 09 10]; % Replace with a list of all of the subjects you wish to analyze
                                         % note: subj_05 is removed

for subject=subjects

    subject = num2str(subject, '%02d');

    % Load NIfTI files
    func_filename = ['C:\Users\abayoumi\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RawData\DATI\NCS\subj_' subject '\warsubj_' subject '_functional.nii'];

    V = niftiread(func_filename);
    [x, y, z, t] = size(V);
    func_data = reshape(V, [x * y * z, t]);
    func_var = var(double(func_data), 0, 2);
    selected_func_features = find(func_var > 0.1);
    selected_func_feature_vector = func_data(selected_func_features, :);

    save(['subj_' subject '_functional_feature_vector'],  'selected_func_feature_vector');
end
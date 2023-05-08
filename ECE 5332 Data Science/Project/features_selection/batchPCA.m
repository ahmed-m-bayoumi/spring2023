subjects = [01]; % Replace with a list of all of the subjects you wish to analyze
                                         % note: subj_05 is removed
feature_matrix = [];

numComponents = 3;

for subject=subjects
tic
    subject = num2str(subject, '%02d');

    % Load NIfTI files
    func_filename = ['C:\Users\ahmed\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RawData\DATI\AD\subj_' subject '\warsubj_' subject '_functional.nii'];

    % Read NIFTI files
    V = niftiread(func_filename);
%     [x, y, z, t] = size(V);
%     nifti_data = single(reshape(V, [x * y * z, t]));

    % Perform PCA
%     [~, score, ~, ~, explained, ~] = pca(nifti_data);

toc
%     feature = score(:, 1);
%     feature_matrix = [feature_matrix, feature];
end
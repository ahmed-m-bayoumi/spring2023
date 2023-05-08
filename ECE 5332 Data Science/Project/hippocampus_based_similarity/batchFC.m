% Load the AAL atlas
aal = spm_vol('AAL3v1.nii');
[atlas, XYZ] = spm_read_vols(aal);

% Create a binary mask for the left hippocampus (label 37) and right hippocampus (label 38)
hippocampus_mask = (atlas == 37) | (atlas == 38);

% Save the hippocampus mask as a NIfTI file
hippocampus_mask_nii = aal;
hippocampus_mask_nii.fname = 'hippocampus_mask.nii';
spm_write_vol(hippocampus_mask_nii, hippocampus_mask);


% Batch processing:
subjects = [01 02 03 04 06 07 08 09 10]; % Replace with a list of all of the subjects you wish to analyze
                                         % note: subj_05 is removed
feature_matrix = [];

numComponents = 3;

for subject=subjects
tic
    subject = num2str(subject, '%02d');

    % Load NIfTI files
    func_filename = ['C:\Users\abayoumi\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RawData\DATI\AD\subj_' subject '\warsubj_' subject '_functional.nii'];

    % Read NIFTI files
    fmri_data = niftiread(func_filename);
    [x, y, z, t] = size(fmri_data);

    % Define the seed region using a mask or atlas
    % Assuming 'seed_mask' is a 3D binary matrix (x, y, z) with 1's for voxels in the seed region and 0's elsewhere
    % You can create this mask based on MNI coordinates or using an anatomical atlas

    % Extract the time series for the seed region
    seed_mask = hippocampus_mask;

    seed_voxels = find(seed_mask);
    num_seed_voxels = numel(seed_voxels);
    seed_time_series = zeros(num_seed_voxels, t);
   %combining all time series for our seed region (hippocampus)
    for i = 1:num_seed_voxels
        [voxel_x, voxel_y, voxel_z] = ind2sub(size(seed_mask), seed_voxels(i));
        seed_time_series(i, :) = squeeze(fmri_data(voxel_x, voxel_y, voxel_z, :));
    end

    % Calculate the mean time series for the seed region
    mean_seed_time_series = mean(seed_time_series, 1);

    % Initialize the correlation matrix
    correlation_matrix = zeros(x, y, z);

    % Compute the correlation between the mean time series of the seed region and all other voxels
    for i = 1:x
        for j = 1:y
            for k = 1:z
                voxel_time_series = squeeze(fmri_data(i, j, k, :));
                correlation_matrix(i, j, k) = corr(mean_seed_time_series', voxel_time_series);
            end
        end
    end

    % Apply a threshold to the correlation matrix if needed (e.g., r > 0.3)
    threshold = 0.3;
    correlation_matrix(correlation_matrix < threshold) = 0;
toc
    feature_matrix = [feature_matrix, correlation_matrix];
end
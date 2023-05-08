% Load the AAL atlas
aal = spm_vol('AAL3v1.nii');
[atlas, XYZ] = spm_read_vols(aal);

% Create a binary mask for the left hippocampus (label 37) and right hippocampus (label 38)
hippocampus_mask = (atlas == 37) | (atlas == 38);

% Save the hippocampus mask as a NIfTI file
hippocampus_mask_nii = aal;
hippocampus_mask_nii.fname = 'hippocampus_mask.nii';
spm_write_vol(hippocampus_mask_nii, hippocampus_mask);

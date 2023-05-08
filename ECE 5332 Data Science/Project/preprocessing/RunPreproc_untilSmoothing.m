% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'C:\Users\abayoumi\OneDrive - Texas Tech University\Documents\MATLAB Drive\ECE 5332 Data Science\Project\RunPreproc_untilSmoothing_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});

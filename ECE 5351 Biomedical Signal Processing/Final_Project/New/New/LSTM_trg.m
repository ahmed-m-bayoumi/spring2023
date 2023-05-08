% Load the clean and noisy audio files

[cleanAudio, fs1] = audioread('Combined_Clean_8k.wav');
[noisyAudio, fs2] = audioread('Combined_Noisy_8k.wav');

% Normalize the audio signals
cleanAudio = cleanAudio / max(abs(cleanAudio));
noisyAudio = noisyAudio / max(abs(noisyAudio));

% Split the data into training and validation sets (80% training, 20% validation)
[trainClean, valClean] = splitData(cleanAudio, 0.8);
[trainNoisy, valNoisy] = splitData(noisyAudio, 0.8);


numFeatures = 1;
numHiddenUnits = 192; %changed from 128 to 192
numOutputs = 1;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits, 'OutputMode', 'sequence')
    fullyConnectedLayer(numOutputs)
    regressionLayer];

options = trainingOptions('adam', ...
    'MaxEpochs', 200, ... %changed from 100 to 200
    'InitialLearnRate', 0.003, ... %changed from 0.001 to 0.003
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropPeriod', 50, ... %changed from 30 to 50
    'LearnRateDropFactor', 0.2, ...%changed from 0.1 to 0.2
    'ValidationData', {valNoisy', valClean'}, ...
    'ValidationFrequency', 30, ...
    'Plots', 'training-progress', ...
    'Verbose', 1);


net = trainNetwork(trainNoisy', trainClean', layers, options);



% 
% % Save the denoised audio
% audiowrite('test_denoised_audio.wav', testDenoisedAudio, fs);


function [trainData, valData] = splitData(data, trainRatio)
    n = length(data);
    idx = round(n * trainRatio);
    trainData = data(1:idx);
    valData = data(idx+1:end);
end

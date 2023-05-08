% Load your inputData and targetData matrices
% inputData = ...; % Noisy signal data (number of samples x number of features)
% targetData = ...; % Clean signal data (number of samples x number of features)

targetData = audioread('Combined_Clean_8k.wav');
inputData = audioread('Combined_Noisy_8k.wav');

% Split the data into training and validation sets (80% training, 20% validation)
[trainInd, ~, valInd] = dividerand(size(inputData, 1), 0.8, 0, 0.2);
trainInputData = inputData(trainInd, :);
trainTargetData = targetData(trainInd, :);
valInputData = inputData(valInd, :);
valTargetData = targetData(valInd, :);

% Create a feedforward neural network with one hidden layer containing 50 neurons
layers = [
    featureInputLayer(size(inputData, 2))
    fullyConnectedLayer(50)
    reluLayer
    fullyConnectedLayer(size(targetData, 2))
    regressionLayer
];

% Set training options
options = trainingOptions('adam', ...
    'MiniBatchSize', 64, ...
    'MaxEpochs', 100, ...
    'InitialLearnRate', 1e-4, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 50, ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {valInputData, valTargetData}, ...
    'ValidationFrequency', 30, ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% Train the FNN
net = trainNetwork(trainInputData, trainTargetData, layers, options);

% Save the trained FNN
% save('trainedFNN.mat', 'net');

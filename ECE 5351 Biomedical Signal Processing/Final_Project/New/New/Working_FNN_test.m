% Load the trained FNN
load('trained_FNN.mat', 'net');

% Load the noisy speech signal you want to filter
[noisy_audio, fs] = audioread('Test_Noisy.wav');

% Apply the FNN to filter the noisy speech signal
filtered_audio = predict(net, noisy_audio);

% Play the original and filtered signals
soundsc(noisy_audio, fs);
pause(25);
soundsc(filtered_audio, fs);

% Save the filtered audio
% audiowrite('filtered_audio.wav', filtered_audio, fs);

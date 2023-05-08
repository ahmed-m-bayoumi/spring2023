% Load the trained FNN
load('trained_LSTM.mat', 'net');



[testNoisyAudio, fs] = audioread('Test_Noisy.wav');
testNoisyAudio = testNoisyAudio / max(abs(testNoisyAudio));

testDenoisedAudio = predict(net, testNoisyAudio');
testDenoisedAudio = testDenoisedAudio';

% Play the original and filtered signals
soundsc(testNoisyAudio, fs);
pause(25);
soundsc(testDenoisedAudio, fs);

% Save the filtered audio
% audiowrite('testDenoisedAudio.wav', testDenoisedAudio, fs);

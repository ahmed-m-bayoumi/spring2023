% Load clean and noisy audio signals
[clean_audio, fs] = audioread('Combined_Clean_8k.wav');
[noisy_audio, ~] = audioread('Test_Noisy.wav');

% Ensure both signals have the same length
min_len = min(length(clean_audio), length(noisy_audio));
clean_audio = clean_audio(1:min_len);
noisy_audio = noisy_audio(1:min_len);

% Parameters for STFT
window = hamming(1024); % Window function (Hamming window)
noverlap = 512; % Overlap between adjacent frames
nfft = 2048; % Number of points for FFT

% Compute STFT of clean and noisy signals
[s_clean, f, t] = stft(clean_audio, 'Window', window, 'OverlapLength', noverlap, 'FFTLength', nfft);
[s_noisy, ~, ~] = stft(noisy_audio, 'Window', window, 'OverlapLength', noverlap, 'FFTLength', nfft);

% Compute power spectra of clean and noisy signals
pxx_clean = abs(s_clean).^2;
pxx_noisy = abs(s_noisy).^2;

% Calculate the Wiener filter coefficients
H_wiener = pxx_clean ./ (pxx_clean + pxx_noisy);

% Apply the Wiener filter to the noisy signal
s_filtered = s_noisy .* H_wiener;

% Compute inverse STFT to obtain filtered audio
filtered_audio = istft(s_filtered, 'Window', window, 'OverlapLength', noverlap, 'FFTLength', nfft);

% Ensure the filtered audio is real and cast it to a floating-point format
filtered_audio = real(filtered_audio);
filtered_audio = cast(filtered_audio, 'single');

% Play the original and filtered signals
% soundsc(noisy_audio, fs);
% pause(1);
soundsc(filtered_audio, fs);

% Save the filtered audio
% audiowrite('filtered_audio.wav', filtered_audio, fs);

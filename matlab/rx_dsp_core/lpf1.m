function coef_out = lpf1
%LPF1 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.10 and Signal Processing Toolbox 8.6.
% Generated on: 16-Feb-2022 19:35:28

% Equiripple Lowpass filter designed using the FIRPM function.

% All frequency values are in MHz.
Fs = 500;  % Sampling Frequency

Fpass = 40;              % Passband Frequency
Fstop = 62.5;            % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.0001;          % Stopband Attenuation
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
coef_out  = firpm(N, Fo, Ao, W, {dens});

% [EOF]

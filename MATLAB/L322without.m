% Read test matrix 
test = dlmread('freeresp.txt','',1,0); 
% Read time data from file t = test(:,1); 
% Read amplitude data from file 
amp = test(:,2); 
% Length of signal 
L = length(amp); 
% Sampling frequency 
Fs = 1000;   
% Compute fast fourier transform of signal 
Y = fft(amp); 
% Compute the two-sided spectrum P2.  
% Then compute the single-sided spectrum P1 based on P2 
%and the even-valued signal length L. 
f = Fs*(0:(L/2))/L; 
P2 = abs(Y/L); 
P1 = P2(1:L/2+1); 
P1(2:end-1) = 2*P1(2:end-1); 
% Create FFT plot 
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of Signal') 
xlabel('freq (Hz)') 
ylabel('|P1(f)|')
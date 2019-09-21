% This code is property of 
%  * David Francisco Calles Milla
%  * Andrés Felipe Corredor Pablos
%  * Santiago Torres Borda

%% Data already captured
Fs = 8000;
L = 40000;
load('Aaudio.mat');
load('AEIOU.mat');
FTransform = (abs(fft(AEIOUaudio)))/L;
t = 0:1/8000:((40000/Fs))-(1/Fs);
f = Fs*(0:((L/2)-(1/L)))/L;

% Filter coefficients
% Butterworth, Order 2, f1: 720 Hz, f2: 920 Hz
NUMIIR = [ 0.072959657268266864260652937446138821542,0.0,-0.072959657268266864260652937446138821542];
DENIIR = [1.0,-1.487264620237079837394844616937916725874, 0.854080685463466271478694125107722356915];
% Rectangular window, Order 8, f1: 1264 Hz, f2: 1464 Hz
NUMFIR = [-0.093685796392882450533967642058996716514,-0.227136278609472219702780648731277324259,-0.123866612891250310601876094551698770374, 0.109985263188692575231364401133760111406, 0.229851375411773223289557677162520121783, 0.109985263188692575231364401133760111406,-0.123866612891250310601876094551698770374,-0.227136278609472219702780648731277324259,-0.093685796392882450533967642058996716514];
DENFIR = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0];

% Plot the waveform.
figure
plot(t,Aaudio)
grid on
xlabel("t(s)")
title('Signal along time')

figure
plot(f,FTransform(1:20000))
%xlim([])
grid on
xlabel("f(Hz)")
xlim([0 2000])
title('Signal along frequency')

F1filt = filter(NUMIIR,DENIIR,AEIOUaudio);
F1filtFFT = (abs(fft(F1filt)))/L;

F2filtFFT = (abs(fft(filter(NUMFIR,DENFIR,AEIOUaudio))))./L;

% Plot the waveform, again.
figure
plot(f,F1filtFFT(1:20000))
%xlim([])
grid on
xlabel("f(Hz)")
xlim([0 2000])
title('IIR filter')

figure
plot(f,F2filtFFT(1:20000))
%xlim([])
grid on
xlabel("f(Hz)")
title('FIR filter')

%% Show results
figure
imshow('1.jpg')
title('Banda de rechazo | Frecuencias bajas')

figure
imshow('2.jpg')
title('Frecuencia central')

figure
imshow('3.jpg')
title('Banda de rechazo | Frecuencias altas')

figure
imshow('4.jpg')
title('Banda de rechazo | Frecuencias bajas')

figure
imshow('5.jpg')
title('Frecuencia central')

figure
imshow('6.jpg')
title('Banda de rechazo | Frecuencias altas')
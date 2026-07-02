%stopexplow = butterGCxGCMain(stopexp,low=1,ordr=4,cutoff=60);
%{
atens = makeTensor(stoplowexp);
btens = makeTensor(stopexplow);
atic = stoplowexp.tic;
btic = stopexplow.tic;
%}

figure; 
subplot(1,2,1);
N = length(stoplowexp.tic);
fs = stoplowexp.dataRate;
fax_bins = 0 : N-1;
fax_hz = fax_bins*fs/N; %frequency axis in Hz
N_2 = floor(N/2);
mag = abs(stoplowexp.tic);
plot(fax_hz(1:N_2), mag(1:N_2)); 

title('StopLowExp');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis tight
xlim([0 fax_hz(N_2)]);
ylim([0 5.5e8]);

subplot(1,2,2);
mag = abs(stopexplow.tic);
plot(fax_hz(1:N_2), mag(1:N_2));
title('StopExpLow');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis tight
xlim([0 fax_hz(N_2)]);
ylim([0 5.5e8]);

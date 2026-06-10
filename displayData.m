f = figure('Name','userFig');
ax1 = subplot(3,1,1);
plot(dataOut.tic);
title('TIC, Pre-FFT Denoise')
xlabel('Retention (s)')
ylabel('Abundance')

ax2 = subplot(3,1,2);
plot(abs(ifft(tic_filtered)));
title('TIC, Post-FFT Denoise')
xlabel('Retention (s)')
ylabel('Abundance')

linkaxes([ax1,ax2],'xy');

subplot(3,1,3);
X_mags = abs(tic_filtered);
plot(fax_hz(1:N_2), X_mags(1:N_2));
xlim([0 fax_hz(N_2)]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Single-sided Magnitude spectrum');
axis tight
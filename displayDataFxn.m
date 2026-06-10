function displayDataFxn(pegIn)

    figure;

%     f = figure('Name','userFig');
%     ax1 = subplot(2,1,1);
%     plot(pegIn.tic);
%     title('TIC, Pre-FFT Denoise')
%     xlabel('Retention (s)')
%     ylabel('Abundance')

    tic_FFTed = fft(pegIn.tic);
    N = length(pegIn.tic);
    fs = pegIn.dataRate;
    fax_bins = [0 : N-1];
    fax_hz = fax_bins*fs/N; %frequency axis in Hz
    N_2 = floor(N/2);
    
%     subplot(2,1,2);
    X_mags = abs(tic_FFTed);
    plot(fax_hz(1:N_2), X_mags(1:N_2));
    xlim([0 fax_hz(N_2)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum');
    axis tight

end
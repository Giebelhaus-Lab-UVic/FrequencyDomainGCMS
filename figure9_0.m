fs = gstopexp.dataRate;
N = length(gstopexp.tic);
fax_bins = 0 : N-1;
fax_hz = fax_bins*fs/N;
loc = find(fax_hz==60);
ftic = fft(gstopexp.tic);

ftic(loc:N) = 0;
gstopexp.tic_2 = abs(ifft(ftic));


N_2 = floor(N/2);
    mag = abs(ftic);
    figure;
    plot(fax_hz(1:N_2), mag(1:N_2)); 
    %xlim([0 fax_hz(N_2)]);
    xlim([0 100])
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
   % title('Single-sided Magnitude spectrum');
    axis tight
    ylim([0 5.5e8]);
    %ylim([0 9.0e7]);
    ax = gca;
    ax.FontSize = 14;
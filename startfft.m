function [fstruc] = startfft(dstruc, plt,fft_)
% Convert TIC of 2D chromatographic data into frequency domain using
% fft.

if fft_
    ftic = fft(dstruc.tic);
    spec = dstruc.specdata;
    sz = size(spec);
    fspec = zeros(sz(1), sz(2));

    for i = 1:sz(2)

           fspec(:,i) = fft(spec(:,i));
    end
else
    ftic = dstruc.tic;
    fspec = dstruc.specdata;
end
if plt
    figure;
    N = length(ftic);
    fs = dstruc.dataRate;
    fax_bins = 0 : N-1;
    fax_hz = fax_bins*fs/N; %frequency axis in Hz
    N_2 = floor(N/2);
    mag = abs(ftic);
    plot(fax_hz(1:N_2), mag(1:N_2)); 
    %xlim([0 fax_hz(N_2)]);
    xlim([0 100])
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum');
    axis tight
    ylim([0 5.5e8]);
    
end

fstruc = dstruc;
fstruc.tic = ftic;
fstruc.specdata = fspec;
end




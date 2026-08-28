function startfft(dstruc, plt,fft_)
% Convert TIC of 2D chromatographic data into frequency domain using
% fft.

if fft_
    ftic = fft(dstruc.tic);
    spec = dstruc.specdata;
    sz = size(spec);
    fspec = zeros(sz(1), sz(2));

   % for i = 1:sz(2)
%
  %         fspec(:,i) = fft(spec(:,i));
 %   end
else
    ftic = dstruc.tic;
%    fspec = dstruc.specdata;
end
if plt
    fig= figure;
    N = length(ftic);
    fs = dstruc.dataRate;
    fax_bins = 0 : N-1;
    fax_hz = fax_bins*fs/N; %frequency axis in Hz
    N_2 = floor(N/2);
    mag = abs(ftic);
    length(fax_hz(1:N));
    plot(fax_hz(1:N), mag(1:N)); 
    xlim([0 fax_hz(N_2)]);
  %  xlim([0 100])
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
   % title('Single-sided Magnitude spectrum');
  %  axis tight
    %ylim([0 5.5e8]);
    %ylim([0 9.0e7]);
    ylim([0 16e7]);
    ax = gca;
    ax.FontSize = 14;

    fig.Units = 'inches';
    fig.Position = [1 1 8 4];


   % exportgraphics(fig, 'SI5_hill.png', 'Resolution', 600);
    
    
    
end

%fstruc = dstruc;
%fstruc.tic = ftic;
%fstruc.specdata = fspec;
end




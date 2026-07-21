function [dataOut] = fftMain(dataIn,plt,opts)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% Data must be passed in the form of a data structure
arguments (Input)
    dataIn struct
    plt 
    opts.bwstop = 0
    opts.bwlow = 0
    opts.exp = 0
    opts.width = []
    opts.notches = []
    opts.stop_ordr = []
    opts.low_ordr = []
    opts.cutoff = []
end

dataIn.tic = sum(dataIn.specdata,2);
% --- Step 2: Apply butterworth band filter if applicable

dataOut = dataIn;
if opts.bwstop
    if opts.bwlow
        dataOut = butterMain(dataIn,stop=1,low=1,notches=opts.notches,bw=opts.width,s_ordr=opts.stop_ordr,l_ordr=opts.low_ordr,cutoff=opts.cutoff);
    else 
        dataOut = butterMain(dataIn,stop=1,notches=opts.notches,bw=opts.width,s_ordr=opts.stop_ordr);
    end
else 
    if opts.bwlow
        dataOut = butterMain(dataIn,low=1,l_ordr=opts.low_ordr,cutoff=opts.cutoff);
    end
end

% --- Step 2: Apply exponential fit if applicable


if opts.exp
    [etic,espec] = expModFFT(dataOut);
    %scaled = rescale(abs(etic), 0, max(abs(fft(dstruc.tic))));
    %{
    scaled = abs(etic) * max(abs(fft(dstruc.tic)))/max(abs(etic));
    dataOut.tic = scaled; % are adding an abs to this; need to check if this is ok as output or if we should keep with imaginary #s
    dataOut.specdata = espec;% will need to rescale this
    spec_scaled = abs(espec) * max(abs(fftspec(:)))/max(abs(espec(:)));
    dataOut.specdata = spec_scaled;
    dataOut.ExpVals = evals;
    %}
    
    ietic = abs(ifft(etic));
    iespec = abs(ifft(espec));
    max_out = max(dataIn.tic);
    loc_max = dataIn.tic==max_out;
    scaletic = ietic * max_out/ietic(loc_max);
   % scaletic = ietic;
    dataOut.tic = scaletic;
  
    scalespec = iespec * max(dataIn.specdata(:))/max(iespec(:));
    dataOut.specdata = scalespec;
    
   
    
end

%{
figure;
    N = length(dataOut.tic);
    fs = dstruc.dataRate;
    fax_bins = 0 : N-1;
    fax_hz = fax_bins*fs/N; %frequency axis in Hz
    N_2 = floor(N/2);
    mag = abs(dataOut.tic);
    plot(fax_hz(1:N_2), mag(1:N_2)); 
   
    
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum');
    axis tight
    xlim([0 fax_hz(N_2)]);
    ylim([0 5.5e8]);
%}

if plt
    if dataIn.modTime == 0
        plotchr(dataIn,1,'Before Denoising');
        plotchr(dataOut,1, 'After Denoising');
    else     
        plotchr(dataIn,2,'Before Denoising');
        plotchr(dataOut,2, 'After Denoising');
    end
end

end

%startfft(dataOut,1,1);

% add in before and after plotting of tic
% put fft plotting as other function and we can just call it
% should only need specdata, mod time, etc coming in and we will sum to get
%  tic. minimal params needed as the input


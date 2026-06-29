function [dataOut] = fftMain(dstruc,opts)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    dstruc struct
    opts.bwstop = 0
    opts.bwpass = 0
    opts.exp = 0
    opts.width = []
    opts.notches = []
    opts.ordr = []
    opts.cutoff = []
end


% --- Step 2: Apply butterworth band filter if applicable


if opts.bwstop
    if opts.bwpass
        dataOut = butterGCxGCMain(dstruc,stop=1,less=1,notches=opts.notches,bw=opts.width,ordr=opts.ordr,cutoff=opts.cutoff);
    else 
        dataOut = butterGCxGCMain(dstruc,stop=1,notches=opts.notches,bw=opts.width,ordr=opts.ordr);
    end
else 
    if opts.bwpass
        dataOut = butterGCxGCMain(dstruc,less=1,cutoff=opts.cutoff);
    end
end

% --- Step 2: Apply exponential fit if applicable


if opts.exp
    [etic,espec,evals] = expModFFT(dataOut);
    scaled = rescale(abs(etic), 0, max(bstruc.tic));
    dataOut.tic = scaled;
    dataOut.specdata = espec; % will need to rescale this
    dataOut.ExpVals = evals;
end



figure;
    N = length(dataOut.tic);
    fs = dstruc.dataRate;
    fax_bins = 0 : N-1;
    fax_hz = fax_bins*fs/N; %frequency axis in Hz
    N_2 = floor(N/2);
    mag = abs(scaled);
    plot(fax_hz(1:N_2), mag(1:N_2)); 
   
    
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title('Single-sided Magnitude spectrum');
    axis tight
    xlim([0 fax_hz(N_2)]);
    ylim([0 5.5e8]);
end


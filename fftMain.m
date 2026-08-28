function [dataOut] = fftMain(dataIn,plt,opts)
% Denoises one- or two-dimensional gas chromatography data in the frequency 
% domain using a user-specified selection of Butterworth lowpass filtering, 
% Butterworth band-stop fitering, and/or the fitting of an exponential
% function to the data. 
% dataIn is a structure with the following fields:
% Tic = vector of total ion count data.
% Spec = matrix of spectral data, where each row is an acquisition and 
% each column is a mass channel.
% Scans = total number of acquisitions
% Rate = acquisition rate (in Hz or spectra/s)
% ModPeriod = modulation period in seconds; must be 0 or omitted for 1D data.
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
dataOut = dataIn;                       % Initialize output structure

% --- Step 1: Apply Butterworth filters if applicable.

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

% --- Step 2: Apply exponential fit if applicable.

if opts.exp
    if ~isfield(dataIn, 'Tic')
        dataIn.Tic = sum(dataIn.Spec,2);
    end

    [etic,espec] = expModFFT(dataOut);  % Scale TIC and specdata to the 
    ietic = abs(ifft(etic));            % size of the original data
    iespec = abs(ifft(espec));
    max_in = max(dataIn.Tic);
    loc_max = dataIn.Tic==max_in;
    scaletic = ietic * max_in/ietic(loc_max);
    max_in_spec = max(dataIn.Spec(:));
    loc_smax = dataIn.Spec(:)==max_in_spec;
    flat_spec = iespec(:);
    scalespec = iespec * max_in_spec/flat_spec(loc_smax);

    dataOut.Spec = scalespec;       % Update output structure
    dataOut.Tic = scaletic;
 
end

% --- Step 3: Plot data before and after denoising if applicable. 

if plt
    if ~isfield(dataIn, 'ModPeriod') || dataIn.ModPeriod == 0 
        plotChrom(dataIn,1,'Before Denoising');
        plotChrom(dataOut,1, 'After Denoising');
    else     
        plotChrom(dataIn,2,'Before Denoising');
        plotChrom(dataOut,2, 'After Denoising');
    end
end

end




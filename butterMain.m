function [dataOut] = butterMain(dataIn, opts)
% Applies lowpass and/or band-stop Butterworth filters to one- or two-
% dimensional gas chromatography data in the frequency domain.
arguments 
    dataIn
    opts.stop = 0
    opts.low = 0
    opts.notches = []
    opts.bw = []
    opts.s_ordr = []
    opts.l_ordr = []
    opts.cutoff = []
end

% --- Step 1: Fold data into a tensor.

[tensOut] = makeTensor(dataIn);
szTens = size(tensOut);
numMods = szTens(2);

% --- Step 2: Normalize frequencies to Nyquist frequency.

Wns = [];                                   
fs = dataIn.dataRate;                   % Obtain sampling rate

if opts.stop
    upLim = zeros(1, length(opts.notches)); 
    dwnLim = zeros(1, length(opts.notches));

    % Prepare notches according to specified width
    for i = 1:length(opts.notches)      
        upLim(i) = opts.notches(i) + opts.bw; 
        dwnLim(i) = opts.notches(i) - opts.bw;
    end

    edges = sort([upLim dwnLim]); 
    Wns = edges/(fs/2);                 % Normalize notch frequencies
end

Wnl = [];
if opts.low
    Wnl = opts.cutoff/(fs/2);           % Normalize cutoff frequency
end

% --- Step 3: Apply filters modulation-by-modulation.

dim1 = szTens(1);
specDataOut = zeros(numMods*dim1, szTens(3));

for ii = 1:numMods                    
    curMod = squeeze(tensOut(:,ii,:)); 
    [specDataFFT] = butterFilt(curMod,opts.stop,opts.low,opts.s_ordr,opts.l_ordr,Wns,Wnl);
    ind = (ii-1)*dim1 + (1:dim1);
    specDataOut(ind,:) = specDataFFT;
end

% --- Step 4: Update fields in data structure.

dataOut = dataIn;
ticBW = sum(specDataOut, 2);
dataOut.specdata = specDataOut;
dataOut.tic = ticBW;

end
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
    Wns = edges/(fs/2);                 % Normalize
end

Wnl = [];
if opts.low
    Wnl = opts.cutoff/(fs/2);           % Normalize
end
dim1 = szTens(1);
specDataOut = zeros(numMods*dim1, szTens(3));
for ii = 1:numMods
    %get the current modulation
    curMod = squeeze(tensOut(:,ii,:)); 
    [specDataFFT] = butterFilt(curMod,opts.stop,opts.low,opts.s_ordr,opts.l_ordr,Wns,Wnl);
    %specDataOut = [specDataOut; specDataFFT]; 
    ind = (ii-1)*dim1 + (1:dim1);
    specDataOut(ind,:) = specDataFFT;
end

%make the dataOut structure
dataOut = dataIn;

%just doing this to get the tensor out
%dataIn.specdata = specDataOut; 

%new tensor for 2d
%if isfield(dataIn,'modTime')
 %   [tensorBW] = makeTensor(dataIn);
%end
ticBW = sum(specDataOut, 2);

%make the dataout structure complete
%dataOut.tensor = tensorBW;
dataOut.specdata = specDataOut;
%infoFFT is just metadata about the FFT
  %  info.notches = opts.notches;
   % info.bandWidth = opts.bw;
    %info.order = opts.ordr;
%dataOut.info = info;
dataOut.tic = ticBW;

end
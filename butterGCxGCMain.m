%butterworth main

%to do
    %output the data into a plot
    %tweak to handle GCMS data as well
    %parallelize to do for loop as parfor

function [dataOut] = butterGCxGCMain(dataIn, opts)
arguments 
    dataIn
    opts.stop = 0
    opts.low = 0
    opts.notches = []
    opts.bw = []
    opts.ordr = []
    opts.cutoff = []
end

%call this to make the tensor
[tensOut] = makeTensor(dataIn);
szTens = size(tensOut);
numMods = szTens(2);
%specDataOut = [];
Wns = [];
Wnl = [];
fs = dataIn.dataRate;

if opts.stop
    upLim = zeros(1, length(opts.notches)); %row vectors
    dwnLim = zeros(1, length(opts.notches));

    for i = 1:length(opts.notches)
        upLim(i) = opts.notches(i) + opts.bw;
        dwnLim(i) = opts.notches(i) - opts.bw;
    end
    edges = sort([upLim dwnLim]); %horizontal concat and 
    % sorts into ascending order
    Wns = edges/(fs/2);
end
if opts.low
    Wnl = opts.cutoff/(fs/2);
end
dim1 = szTens(1);
specDataOut = zeros(numMods*dim1, szTens(3));
for ii = 1:numMods
    %get the current modulation
    curMod = squeeze(tensOut(:,ii,:)); 
    [specDataFFT] = butterGC(curMod,opts.stop,opts.low,opts.ordr,Wns,Wnl);
    %specDataOut = [specDataOut; specDataFFT]; 
    ind = (ii-1)*dim1 + (1:dim1);
    specDataOut(ind,:) = specDataFFT;
end

%make the dataOut structure
dataOut = dataIn;

%just doing this to get the tensor out
dataIn.specdata = specDataOut; 

%new tensor for 2d
if isfield(dataIn,'modTime')
    [tensorBW] = makeTensor(dataIn);
end
ticFFT = sum(specDataOut, 2);

%make the dataout structure complete
dataOut.tensorBW = tensorBW;
dataOut.specdataBW = specDataOut;
%infoFFT is just metadata about the FFT
    infoBW.notches = opts.notches;
    infoBW.bandWidth = opts.bw;
    infoBW.order = opts.ordr;
dataOut.infoBW = infoBW;
dataOut.ticBW = ticFFT;

end
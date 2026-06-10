%butterworth main

%to do
    %output the data into a plot
    %tweak to handle GCMS data as well
    %parallelize to do for loop as parfor

    function [dataOut] = butterGCxGCMain(dataIn, notches, bandWidth, ordr)

    %call this to make the tensor
    [tensOut] = makeTensor(dataIn);

    szTens = size(tensOut);
    numbMods = szTens(2);

    specDataOut = [];

    fs = dataIn.dataRate;

    %going to call butterGCxGC in a loop for the number of modulations
    for ii = 1:numbMods
        
        %get the current modulation
        curMod = squeeze(tensOut(:,ii,:)); 

        [specDataFFT] = butterGC(fs, curMod, notches, bandWidth, ordr);

        specDataOut = [specDataOut specDataFFT]; %#ok

    end
    
    %make the dataOut structure
    dataOut = dataIn;

    %just doing this to get the tensor out
    dataIn.specdata = specDataOut;
    
    %new tensor
    [tensorFFT] = makeTensor(dataIn);

    ticFFT = sum(specDataOut, 2);

    %make the dataout structure complete
    dataOut.tensorFFT = tensorFFT;
    dataOut.specdataFFT = specDataOut;
    %infoFFT is just metadata about the FFT
        infoFFT.notches = notches;
        infoFFT.bandWidth = bandWidth;
        infoFFT.order = ordr;
    dataOut.infoFFT = infoFFT;
    dataOut.ticFFT = ticFFT;

end
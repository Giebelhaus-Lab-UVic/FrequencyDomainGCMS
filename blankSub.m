function [signalStruct] = blankSub(signalStruct, blkStruct)

    %get the fft for signal and blank
    %compute the FFT of the input data (starting with the TIC)
    fftSig = fft(signalStruct.tic);
    fftBlk = fft(blkStruct.tic);
    
    %have to FFT the specData
    %preallocate the specdata_ffted
    szSig = size(signalStruct.specdata);
    szBlk = size(blkStruct.specdata);

    if szSig ~= szBlk

        disp("Signal size does not match blank size.");

    end
        
    specDataFFT_sig = zeros(szSig(1), szSig(2));
    specDataFFT_blk = specDataFFT_sig;
    sigCleanSD = specDataFFT_blk;
    
    for page = 1:szSig(2)
    
        specDataFFT_sig(:,page) = fft(signalStruct.specdata(:,page));
        specDataFFT_blk(:,page) = fft(blkStruct.specdata(:,page));
    
    end

    sigClean = specDataFFT_sig - specDataFFT_blk;

    for page = 1:szSig(2)
    
        sigCleanSD(:,page) = ifft(sigClean(:,page));

    end

    sigCleanSD = abs(sigCleanSD);
    sigCleanTIC = sum(sigCleanSD, 2);

    signalStruct.tic = sigCleanTIC;
    signalStruct.specdata = sigCleanSD;

end
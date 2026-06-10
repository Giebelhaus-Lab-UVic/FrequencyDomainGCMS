%Butterworth passband filter for GC-TOFMS and GCXGC-TOFMS Data
%Ryland T. Giebelhaus, Robin J. Abel, A. Paulina de la Mata, and James J.
%Harynuk, 2023.


%dataIn is a structure with the following fields
%dataIn.tic = total ion count vector of data
%dataIn.specdata = matrix of spectral data, where each row is an
    %acquisition and each column is a mass channel
%dataIn.numScans = total number of acquisitions
%dataIn.dataRate = acquisition rate (in Hz or spectra/s)

%edges = vector of start and stop of each notch region in Hz.

function [specDataFFT] = butterGC(fs, curData, notches, bandWidth, ordr)
    
    %only works for TIC right now, will just expand this sub function to
    %apply to specdata in the near future

    %get vars from the input structure
    %fs = dataIn.dataRate; %sampling frequency (Hz)
    %t = 0:1/fs:(size(curData,1)/fs); %time vector
    %t(length(t)) = [];
    %pull out the tic
    %ticData = sum(curMod, 2);
    specData = curData;
    %dataOut = dataIn;
    %specDataFFT = zeros(size(specData, 1), size(specData, 2));

    %need to make edges vector
    upLim = zeros(1, length(notches));
    dwnLim = zeros(1, length(notches));

    for i = 1:length(notches)

        upLim(i) = notches(i) + bandWidth;
        dwnLim(i) = notches(i) - bandWidth;

    end

    edges = sort([upLim dwnLim]);

    i = 1;
    j = 2;

    while j <= length(edges)

        curEdg = edges(i:j);
    
        %need to do this to multiple signals
    
        %filter design
        Wn = curEdg/(fs/2); %passband egde frequencies
        [b,a] = butter(ordr, Wn, 'stop'); %build butterworth filter
    
        %ticData = filtfilt(b, a, ticData); % zero-phase filtering to avoid phase distortion

        %to go over specdata
        for k = 1:size(specData, 2)
        
            specData(:,k) = filtfilt(b, a, specData(:,k));

        end

        i = i + 2;
        j = j + 2;

    end

    %ticFiltered = ticData;
    specDataFFT = specData;

    %ticFiltered = sum(specData, 2);

%     % Plot the original and filtered signals
%     figure;
%     plot(t, dataIn.tic', 'b', t, ticFiltered', 'r');
%     xlabel('Time (s)');
%     ylabel('Intensity');
%     legend('Original signal', 'Filtered signal');

    %dataOut.ticFFT = ticFiltered;
    %dataOut.specdataFFT = specDataFFT;

end
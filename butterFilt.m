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

function [specDataFFT] = butterFilt(curMod,stop,low,s_ordr,l_ordr,Wns,Wnl)

    
%only works for TIC right now, will just expand this sub function to
%apply to specdata in the near future

%get vars from the input structure
%fs = dataIn.dataRate; %sampling frequency (Hz)
%t = 0:1/fs:(size(curData,1)/fs); %time vector
%t(length(t)) = [];
%pull out the tic
%ticData = sum(curMod, 2);
%dataOut = dataIn;
%specDataFFT = zeros(size(specData, 1), size(specData, 2));

%need to make edges vector

%{
if gc1
    upLim = zeros(1, length(notches)); %row vectors
    dwnLim = zeros(1, length(notches));
    for i = 1:length(notches)
        upLim(i) = notches(i) + bandWidth;
        dwnLim(i) = notches(i) - bandWidth;
    end
    edges = sort([upLim dwnLim]); %horizontal concat and 
    % sorts into ascending order
    if cln 
        msk = edges < 60-bandWidth;
        edges = [edges(msk) 60];
        ind = length(edges);

    end
else 
    edges = notches;
end
%}
if stop
    i = 1;
    j = 2;
    while j <= length(Wns)
        [b,a] = butter(s_ordr, Wns(i:j), 'stop'); %build butterworth filter
        % use stop because want a stopband; ie don't let some freq. thru.    
        %to go over specdata
        for k = 1:size(curMod, 2)
            curMod(:,k) = filtfilt(b, a, curMod(:,k)); 
        % apply butterworth column by column
        end
        i=i+2;
        j=j+2;
    end
end
if low
    [b,a] = butter(l_ordr,Wnl,'low');
    for k = 1:size(curMod, 2)
        curMod(:,k) = filtfilt(b, a, curMod(:,k)); 
    end
end



%ticFiltered = ticData;
specDataFFT = curMod;

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
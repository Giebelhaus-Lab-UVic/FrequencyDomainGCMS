function [curMod_filt] = butterFilt(curMod,stop,low,s_ordr,l_ordr,Wns,Wnl)
% Designs Butterworth band-stop and/or lowpass filters for the frequency 
% domain of one-dimensional gas chromatography data or a single modulation
% of two-dimensional gas chromatography data. 
    
% --- Step 1: Design band-stop filter if applicable.

if stop
    i = 1;
    j = 2;
    while j <= length(Wns)              % Design filter for each notch frquency
        [b,a] = butter(s_ordr, Wns(i:j), 'stop');   
        for k = 1:size(curMod, 2)       % Apply column-by-column                 
            curMod(:,k) = filtfilt(b, a, curMod(:,k)); 
        end
        i=i+2;
        j=j+2;
    end
end

% --- Step 2: Design lowpass filter if applicable.

if low
    [b,a] = butter(l_ordr,Wnl,'low');   % Design filter for cutoff frequency
    for k = 1:size(curMod, 2)           % Apply column-by-column
        curMod(:,k) = filtfilt(b, a, curMod(:,k)); 
    end
end

% --- Step 3: Return filtered data

curMod_filt = curMod;

end
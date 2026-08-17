function [curMod_filt] = butterFilt(curMod,stop,low,s_ordr,l_ordr,Wns,Wnl)
% 
    

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

curMod_filt = curMod;

end
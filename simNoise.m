function [PegOut] = simNoise(pegIn, freqs, intent)

%first want to see if the data loaded in is a peg file or just a csv
%its going to be better to take in a structure always I think
%also need to get the data from the user
    %frequencey
%need some logical tests to determine if the data is 2 dimensional or just
%contains a single dimension (could accept FID or VUV data).

%next want to put the data into FFTDenoise

%call uploaded data pegStr
PegOut = pegIn;

%I wanted a waitbar
f = waitbar(0/5, 'Adding Noise. Please be patient.');
%pause it to start
pause(1.2);

%dispDataPrior
%dispDataPrior;

%get the low and high notches from the notches var
lowNotches = freqs(1:2:end);
highNotches = freqs(2:2:end);

%make sure all are vertical
if size(highNotches, 2) > size(highNotches, 1)

    %transpose both
    highNotches = highNotches';
    lowNotches = lowNotches';

end

%sanity check on the notches
if size(lowNotches) ~= size(highNotches)

    errNotches = msgbox("Notches variable formatted incorrectly. Please check documentation in README.","Error","error");

end

szNotches = size(highNotches, 1);

for j = 1:szNotches

    %get the notches for particular itteration
    lowNotch = lowNotches(j);
    highNotch = highNotches(j);

    %literally the waitbar
    f = waitbar(j/szNotches, f, 'Denoising Data with FFT');

    %for i = 1:itter
        
        %loop over the FFTDenoise Function
        [PegOut] = addNoiseFxn(pegIn, 1, 1, lowNotch, highNotch, intent);
    
    %end

end

waitbar(1, f, 'Finishing Up Noise Simulation');
pause(1);
close(f);

%save the data as dataOut
PegOut = PegOut; %#ok

%display the data
%displayData;

%next want to loop over the FFTDenoise function as many times as requested
%by numbIter

%finally want to output the data, I dont see any point of outputting plots
%for the time being.


end
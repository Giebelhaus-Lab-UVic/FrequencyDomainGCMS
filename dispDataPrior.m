function [dataBlock] = dispDataPrior(dataBlock)

%need to separate the data
if isa(dataBlock, 'struct')

    %Perform FFT on TIC & spectral data
    %just perform the FFT as usual
    tic_ffted = fft(dataBlock.tic);
    for page = 1:size(dataBlock.specdata,2)
        specdata_ffted(:,page) = fft(dataBlock.specdata(:,page));
    end

%I dont want to take doubles for now, users can build their own structs if
%they want.
% elseif isa(dataBlock, 'double')
%     
%     %generate a TIC
%     ticData = sum(dataBlock, 2);
% 
%     %gotta clear the dataBlock var
%     FullSpecData = dataBlock;
%     clear dataBlock;
%     
%     %I am lazy so just make the exact same structure.
%     dataBlock.tic = ticData;
%     dataBlock.specdata = FullSpecData;
% 
%     %%%%NEEED TO FIX%%%%
%     %The scan rate of the instrument needs to be known for other data
%     %perhaps require the user to input data as a structure...
%     %for now assume the datarate is 100Hz for a quad (pretty quick)
%     dataBlock.dataRate = 100;
%     
%     %do the same as before
%     tic_ffted = fft(dataBlock.tic);
%     for page = 1:size(dataBlock.specdata,2)
%         specdata_ffted(:,page) = fft(dataBlock.specdata(:,page));
%     end

else

    errorMsg = msgbox("Data type not supported. Please see the documentation in the README for supported file types.","Error","error");

end

N = length(dataBlock.tic);
fs = dataBlock.dataRate;
X_mags = abs(tic_ffted);
fax_bins = [0 : N-1];
fax_hz = fax_bins*fs/N; %frequency axis in Hz
N_2 = floor(N/2);


f = figure('Name','userFig');
plot(fax_hz(1:N_2), X_mags(1:N_2));
xlim([0 fax_hz(N_2)]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Single-sided Magnitude spectrum');
axis tight

mess = msgbox('Please review the magnitude spectrum plot, then press enter when done.');

end
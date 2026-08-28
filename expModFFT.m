function [fftTIC_expMod, fftSD_expMod] = expModFFT(dataIn)
% Fits an exponential function to the frequency domain of 2D gas
% chromatography data

% --- Step 1: Compute the FFT of the input data. 

fftTIC = fft(dataIn.Tic); 

sz = size(dataIn.Spec);                                 
specdata_ffted = zeros(sz(1), sz(2));
for page = 1:sz(2)                  % Preallocate the specdata_ffted
    specdata_ffted(:,page) = fft(dataIn.Spec(:,page));
end

% --- Step 2: Locate maxima of FFT signals with a minimum distance of 1000.

[intensityPeak, locationPeak] = findpeaks(abs(fftTIC), 'MinPeakDistance', 1000);

if size(intensityPeak, 1) >= 40     % Take the first 40 most intense peaks
    intensityPeak = intensityPeak(1:40);
    locationPeak = locationPeak(1:40);
end

% --- Step 3: Calculate exponential fit of the form y = a*exp(b*x).

% Exponential fit intensityPeak = a*exp(b*locationPeak)
expOfBestFit = fit(locationPeak, intensityPeak, 'exp1');


for i = 1:sz(2)                     % Repeat for Spec
    [tempIntentSpecData, tempLocPeak] = findpeaks(abs(specdata_ffted(:,i)), 'MinPeakDistance', 1000);
    if size(tempIntentSpecData, 1) >= 40 
         tempIntentSpecData = tempIntentSpecData(1:40);
         tempLocPeak = tempLocPeak(1:40);
    end

    aSpecData = zeros(sz(2), 1);    % Preallocate a and b 
    bSpecData = zeros(sz(2), 1);
    
    % Fit to exponential 
    specDataExpFit = fit(tempLocPeak, tempIntentSpecData, 'exp1'); 

    % Storing coefficents for exponential formula
    aSpecData(i) = specDataExpFit.a;    
    bSpecData(i) = specDataExpFit.b;

 end

% --- Step 4: Generate the independent variables (number of acquisitions).

xvals = 1:size(dataIn.Tic, 1);

% --- Step 5: Calculate the function.

depVals1TIC = expOfBestFit.a*exp(expOfBestFit.b*xvals); % Column vector

% Calculate the functions for each mass channel
depValsSpecData = zeros(sz(2), sz(1));
parfor i = 1:sz(2)
     depValsSpecData(i,:) = aSpecData(i)*exp(bSpecData(i)*xvals);
end

% --- Step 6: Flip and add double sided power spectrum to get total
% intensity

depVals2 = flip(depVals1TIC);
depValsSpecDataBack = flip(depValsSpecData, 2);
expModValues = depVals1TIC + depVals2;
expModValuesSD = depValsSpecData + depValsSpecDataBack;

% --- Step 7: Multiply the complex numbers by the expModValues to improve the
% S/N ratio

fftTIC_expMod = fftTIC .* expModValues'; % Element wise multiplication
fftSD_expMod = specdata_ffted .* expModValuesSD';

end
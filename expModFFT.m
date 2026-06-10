function [fftTIC_expMod, modByTIC, expModValues] = expModFFT(pegstruct)

%check if curve fitting toolbox is installed as this is required.
if license('test','curve_fitting_toolbox') == 0

    errCurveFitting = msgbox("CurveFittingToolBox is required for this package. Please save work and install.","Error","error");

end

%compute the FFT of the input data (starting with the TIC)
fftTIC = fft(pegstruct.tic);

%have to FFT the specData
%preallocate the specdata_ffted
sz = size(pegstruct.specdata);
specdata_ffted = zeros(sz(1), sz(2));

for page = 1:sz(2)

    specdata_ffted(:,page) = fft(pegstruct.specdata(:,page));

end

%first find the maxima of the signals in the FFT
%1000 is the minimum distance between the peaks, this can be changed if the
%FFT is very different.
[intensityPeak, locationPeak] = findpeaks(abs(fftTIC), 'MinPeakDistance', 1000);

%take the first 40 most intense peaks (if more than 40, which there should
%be)
if size(intensityPeak, 1) >= 40

    intensityPeak = intensityPeak(1:40);
    locationPeak = locationPeak(1:40);

end

%going to calculate exponential function for every mass channel in one
%shot. Buckle up CPU.
%exponential has the general structure y = a*exp(b*x)
%need to store a and b
%a will be aSpecData and b bSpecData
% aSpecData = zeros(sz(2), 1);
% bSpecData = zeros(sz(2), 1);

% for i = 1:sz(2)
%     
%     %creating a temp var
%     [tempIntentSpecData, tempLocPeak] = findpeaks(abs(specdata_ffted(:,i)), 'MinPeakDistance', 1000);
%     
%     %just shortening to first 40 since double sided power spectrum
%     if size(intensityPeak, 1) >= 40
% 
%         tempIntentSpecData = tempIntentSpecData(1:40);
%         tempLocPeak = tempLocPeak(1:40);
% 
%     end
%     
%     %fitting to exponential 
%     specDataExpFit = fit(tempLocPeak, tempIntentSpecData, 'exp1');
% 
%     %storing coefficents for exponential formula
%     aSpecData(i) = specDataExpFit.a;
%     bSpecData(i) = specDataExpFit.b;
% 
%     %need to reset to empty
%     tempIntentSpecData = [];
%     tempLocPeak = [];
% 
% end

%next need to fix an exponential to this. This requires the 
%determine the exponential of best fit
%of the general structure:
%intensityPeak = a*exp(b*locationPeak)
expOfBestFit = fit(locationPeak, intensityPeak, 'exp1');

%need to get the exponential function
%first generate the independent variables, number of acquisitions.
indepVals = 1:size(pegstruct.tic, 1);

%next calc the function
depVals1TIC = expOfBestFit.a*exp(expOfBestFit.b*indepVals);

%calculate the functions for each mass channel
depValsSpecData = zeros(sz(2), sz(1));

% parfor i = 1:sz(2)
% 
%     depValsSpecData(i,:) = aSpecData(i)*exp(bSpecData(i)*indepVals);
%     
% end

%double sided power spectrum, so need to flip the depVals1
depVals2 = flip(depVals1TIC);
%doing the same with depValsSpecData
depValsSpecDataBack = flip(depValsSpecData, 2);


%add together
expModValues = depVals1TIC + depVals2;
% %add together the depValSpecData
% expModValuesSD = depValsSpecData + depValsSpecDataBack;

%time to multiply the complex numbers by the expModValues to improve the
%S/N ratio
fftTIC_expMod = fftTIC .* expModValues'; 

%multiple the TIC exponential against all spectra
modByTIC = zeros(sz(1), sz(2));

for i = 1:sz(2)

    modByTIC(:,i) = specdata_ffted(:,i) .* expModValues';

end

% %multiply the FFT'ed spectra by the exponential modifier
% fftSD_expMod = specdata_ffted .* expModValuesSD';

% %plot the TIC reconstructed
% specDataiFFT = abs(ifft(modByTIC));
% ticReconPlot = sum(specDataiFFT, 2);
% plot(ticReconPlot);

end
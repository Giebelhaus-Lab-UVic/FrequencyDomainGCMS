function [pegOut, expModValues] = mainFFT(pegIn, notches, itter)

    %ask if want to notch filter first
    promptIn = "Notch Filter Data? (y/n)";
    inPrompt = input(promptIn, 's');
    
    if inPrompt == 'y'
    
        [pegIn] = fftItter(pegIn, notches, itter);

    else

        pegOut = pegIn; %#ok
    
    end
    
    promptInExp = "Weighting by Exponential Modification? (y/n)";
    inPromptExp = input(promptInExp, 's');

    if inPromptExp == 'y'

        %exponential modification
        [fftTIC_expMod, modByTIC, expModValues] = expModFFT(pegIn);
    
        pegOut = pegIn;

        %pegOut.tic = fftTIC_expMod;
    
        normFact = max(abs(ifft(fftTIC_expMod)))/max(pegIn.tic);

        ticOutNorm = fftTIC_expMod/normFact;

        specDataOut = (abs(ifft(modByTIC)));

        pegOut.specdata = specDataOut;
        pegOut.tic = abs(ifft(ticOutNorm));

    else

        pegOut = pegIn;
        expModValues = [];

    end

    f = figure('Name','userFig'); %#ok
    ax1 = subplot(2,1,1);
    plot(pegIn.tic);
    title('TIC, Pre-FFT Denoise')
    xlabel('Acquisitions')
    ylabel('Abundance')
    
    ax2 = subplot(2,1,2);

    plot(pegOut.tic);

%     if inPromptExp == 'y'
%         plot(ticOutNorm);
%     else
%         plot(pegOut.tic);
%     end

    title('TIC, Post-FFT Denoise')
    xlabel('Acquisitions')
    ylabel('Abundance')
    
    linkaxes([ax1,ax2],'xy');

end
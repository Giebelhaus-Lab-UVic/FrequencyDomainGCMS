function[chr] = plotChrom(struc,dim,title1)
% Visualizes a one- or two-dimensional gas chromatogram before or after
% denoising in the frequency domain.
arguments
    struc
    dim
    title1 = []
end

% --- Step 1: Plot 1D or 2D chromatogram.

if dim ==2                              % 2D data
    tens = makeTensor(struc);           % Fold data into tensor
    chr = sum(tens,3);
    figure; 
    imagesc(chr);
    colormap(jet);
    colorbar;
    axis xy;
    xlabel('First Dimension Acquisitions');
    ylabel('Second Dimension Acquisitions');  
end

if dim==1                               % 1D data
    figure;
    plot(struc.tic);
end

% --- Step 2: Label as before or after denosing.

if title1
    title(title1);                 
end

end




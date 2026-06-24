function [outputArg1,outputArg2] = fftMain(dstruc,opts)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    dstruc struct
    opts.bwstop = 0
    opts.bwpass = 0
    opts.exp = 0
    opts.width = []
    opts.notches = []
    opts.ordr = []
    opts.cutoff = []
end


% --- Step 2: Apply butterworth band filter if applicable


if opts.bwstop
    if op1.bwpass
        bstruc = butterGCxGCMain(dstruc,stop=1,less=1,notches=opts.notches,bw=opts.width,ordr=opts.ordr,cutoff=opts.cutoff);
    else 
        bstruc = butterGCxGCMain(dstruc,stop=1,notches=opts.notches,bw=opts.width,ordr=opts.ordr);
    end
else 
    if opt2.bwpass
        bstruc = butterGCxGCMain(dstruc,less=1,cutoff=opts.cutoff);
    end
end

% --- Step 2: Apply exponential fit if applicable



expModFFT(bstruc);


% --- Step 3: Apply exponential weighting function.
expModFFT(bout)


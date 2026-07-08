%btens = makeTensor(stopexplow);
%atens = makeTensor(stoplowexp);
%{
Rstopexplow = stopexplow;



sz = size(Rstopexplow.specdata);
bspec_ifft = zeros(sz(1), sz(2));
for page = 1:sz(2)
    bspec_ifft(:,page) = ifft(Rstopexplow.specdata(:,page));
end
Rstopexplow.specdata = abs(bspec_ifft);
Rstopexplow.tic = aRstopexplow.tic));
%}

%{
stopexp.tic = abs(ifft(stopexp.tic));
sz1 = size(stopexp.specdata);
aspec_ifft1 = zeros(sz1(1), sz1(2));
for page = 1:sz1(2)
    aspec_ifft1(:,page) = abs(ifft(stopexp.specdata(:,page)));
end
stopexp.specdata = aspec_ifft1;

stopexplow = fftMain(stopexp, bwlow=1,ordr=4,cutoff=60);
%}


%{
Rstoplowexp = stoplowexp;
sz = size(Rstoplowexp.specdata);
aspec_ifft = zeros(sz(1), sz(2));
for page = 1:sz(2)
    aspec_ifft(:,page) = abs(ifft(Rstoplowexp.specdata(:,page)));
end
Rstoplowexp.specdata = aspec_ifft;
Rstoplowexp.tic = abs(ifft(Rstoplowexp.tic));
%}
%{
Rstoplowexp = stoplowexp;
Rstoplowexp.specdata = abs(ifft(Rstoplowexp.specdata));
Rstoplowexp.tic = abs(ifft(Rstoplowexp.tic));
%}
plotchr(stoplowexp,'Exp After');
plotchr(stopexplow, 'Exp Before');


%ifft is somehow cooking it. not sure what is going on.

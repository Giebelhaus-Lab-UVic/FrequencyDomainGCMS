%btens = makeTensor(stopexplow);
%atens = makeTensor(stoplowexp);

Rstopexplow = stopexplow;



sz = size(Rstopexplow.specdata);
bspec_ifft = zeros(sz(1), sz(2));
for page = 1:sz(2)
    bspec_ifft(:,page) = ifft(Rstopexplow.specdata(:,page));
end
Rstopexplow.specdata = abs(bspec_ifft);
Rstopexplow.tic = abs(ifft(Rstopexplow.tic));


Rstoplowexp = stoplowexp;
sz = size(Rstoplowexp.specdata);
aspec_ifft = zeros(sz(1), sz(2));
for page = 1:sz(2)
    aspec_ifft(:,page) = ifft(Rstoplowexp.specdata(:,page));
end
Rstoplowexp.specdata = abs(aspec_ifft);
Rstoplowexp.tic = abs(ifft(Rstoplowexp.tic));
%{
Rstoplowexp = stoplowexp;
Rstoplowexp.specdata = abs(ifft(Rstoplowexp.specdata));
Rstoplowexp.tic = abs(ifft(Rstoplowexp.tic));
%}
plotchr(Rstoplowexp,'Exp After');
plotchr(Rstopexplow, 'Exp Before');
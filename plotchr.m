function[chr] = plotchr(struc)
arguments
    struc
end

tens = makeTensor(struc);
chr = sum(tens,3);
figure; 
imagesc(chr);
colormap(jet);
axis xy;
axis equal;
hold on;
end



% acq = dataRate*modTime
% x = numScans/acq
% y = reshape(specdata,  acq, x, massRange)
% z = sum(y,3) -> this is 1d and 2d data
% mz = y(num,num,:) will give specific region u want to look in

% whatever = LoadPEG("filename.peg", 1)

% can extraxt two peaks that are "overlapping" from each other using:

% y(a:b, c:d, e) and y(a:b, c:d, e)

% where a:b is range in one dimension, c:d is range in other, and e is
% position of mass spec peak. this "cuts" data out.

% Acut = A1cube(241,202,:);
% ms(Acut);
% figure; bar(Acut);
% figure; bar(squeeze(Acut));

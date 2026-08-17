function [tensOut] = makeTensor(pegIn)
% Folds one- and two-dimensional gas chromatography data into a tensor.

try
    tensOut = reshape(pegIn.specdata, pegIn.dataRate*pegIn.modTime, (pegIn.numScans)/(pegIn.dataRate*pegIn.modTime), []);
catch
    tensOut = reshape(pegIn.specdata,size(pegIn.specdata,1),1,size(pegIn.specdata,2));
end

end
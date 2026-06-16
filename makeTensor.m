function [tensOut] = makeTensor(pegIn)

   tensOut = reshape(pegIn.specdata, pegIn.dataRate*pegIn.modTime, (pegIn.numScans)/(pegIn.dataRate*pegIn.modTime), pegIn.massRange);

   tensOut = flip(tensOut);

end
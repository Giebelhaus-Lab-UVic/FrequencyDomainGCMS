function [tensOut] = makeTensor(struc)
% Folds one- and two-dimensional gas chromatography data into a tensor.

try
    tensOut = reshape(struc.Spec, struc.Rate*struc.ModPeriod, (struc.Scans)/(struc.Rate*struc.ModPeriod), []);
catch
    tensOut = reshape(struc.Spec,size(struc.Spec,1),1,size(struc.Spec,2));
end

end
function dist = distChiSquare(dataVec_1, dataVec_2)
% =======INPUT=============
% data_1, data_2    two feature vectors
% =======OUTPUT=============
% the Chi square distance between two feature vectors from data_1 and data_2


subVec = dataVec_1 - dataVec_2;
subVec2 = subVec.^2;
subVec3 = dataVec_1 + dataVec_2;

idxZero = find(subVec3 == 0);
subVec3(idxZero) = 1;
subVec4 = subVec2 ./ subVec3;
dist = sum(subVec4 ,2);
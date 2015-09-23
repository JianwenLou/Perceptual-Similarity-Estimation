function deviation = accurPrediction(dataVec_1, dataVec_2)
% =======INPUT=============
% data_1    vector of dissimilarities predicted
% data_2    vector of dissimilarities used to validate(ground truth - perceptual dissimilarity)
% =======OUTPUT=============
% the accuracy to predict perceptual similarity using similarity based on
% computational features


subVec1 = abs(dataVec_1 - dataVec_2);
% subVec2 = dataVec_2;

% idxZero = find(subVec2 == 0);
% subVec2(idxZero) = 1;
% subVec3 = subVec1 ./ subVec2;
subVec3 = subVec1;
deviation = sum(subVec3 ,1) / size(dataVec_1, 1);
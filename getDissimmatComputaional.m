%function dissimmatComputaional = getDissimMatofComFea(feaMat)
% =======INPUT=============
% feaMat    The matrix of computational features(e.g. PCANet feature, Gabor
%           feature), each column represents the feature vector of a texture 
% =======OUTPUT============
% simMatofComFea    The similarity matrix of procedural textures based on
%                   computational features. We regard the Chi-square distance 
%                   between two PCANet features as the measurment of
%                   similarity between the related two textures

close all;
clear all;
clc;

data = load('.\Results\featuresPCANet_Overlap_0.mat');
feaMat = data.ftrn';
numImg = size(feaMat, 1);     % the number of textures in the matrix
numDimFea = size(feaMat, 2);  % the number of dimensions of each feature

dissimmatComputaional = zeros(numImg, numImg);
tic;

for i = 1:numImg
    for j = i:numImg
        if j ~= i
%             for k = 1:numDimFea
%                 if (feaMat(k, i) + feaMat(k, j)) ~= 0 
%                     dissimmatComputaional(i, j) = dissimmatComputaional(i, j) + 0.5 * ((feaMat(k, i) - feaMat(k, j))^2) / (feaMat(k, i) + feaMat(k, j));
%                 end
%             end
            dissimmatComputaional(i, j) = distChiSquare(feaMat(i, :), feaMat(j, :));
        end
        dissimmatComputaional(j, i) = dissimmatComputaional(i, j);
        fprintf('\n  dissimmatComputaional(%d, %d), dissimmatComputaional(%d, %d): %.2f \n', i, j, j, i, dissimmatComputaional(i, j));
    end
end

fprintf('\n Running time: %.2f secs \n', toc);

save .\Results\dissimmatComputaional.mat dissimmatComputaional -v7.3;
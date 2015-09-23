close all;
clear all;
clc;

addpath('.\RandomForest\RF_Reg_C');
data = load('.\Results\dissimmatComputaional.mat');
dissimMat_ComFea = data.dissimMatofComFea;
data = load('.\Data\dissimmatPerceptual.mat');
dissimMat_Percep = data.dissimmat;

numImg = size(dissimMat_ComFea, 1);
sizeData = (numImg + 1) * numImg / 2;
dataMat = zeros(sizeData, 1);
targetMat = zeros(sizeData, 1);
k = 1;
for i = 1:numImg
    for j = i:numImg
        dataMat(k) = dissimMat_ComFea(i, j);
        targetMat(k) = dissimMat_Percep(i, j);
        k = k + 1;
    end
end


% Refulle the whole dataset, choose randomly some of it as the training set and the
% rest as the testing set.
% propTrain = 0.2; % The proption of training set compared with the whole data set
% sizeTrain = sizeData * propTrain;
% indexRand = randperm(sizeData);
% dataMat_train = dataMat(indexRand(1:sizeTrain));
% targetMat_train = targetMat(indexRand(1:sizeTrain));
% 
% dataMat_test = dataMat(indexRand(sizeTrain+1:end));
% targetMat_validation = targetMat(indexRand(sizeTrain+1:end));
%  
% model=regRF_train(dataMat_train, targetMat_train);
% targetMat_predict = regRF_predict(dataMat_test, model);

% k-fold cross validation
k = 1;
cv = cvpartition(sizeData,'kfold',k);

dataMat_train = cell(k, 1);
targetMat_train = cell(k, 1);

dataMat_test = cell(k ,1);
targetMat_validation = cell(k, 1);
targetMat_prediction = cell(k, 1);

deviation = zeros(k, 1); % deviation for each validation
tic;
for i = 1:k
    trainingIndices = find(training(cv, i));
    testIndices = find(test(cv, i));
    
    dataMat_train{i} = dataMat(trainingIndices);
    targetMat_train{i} = targetMat(trainingIndices);
    
    dataMat_test{i} = dataMat(testIndices);
    targetMat_validation{i} = targetMat(testIndices);
    
    model=regRF_train(dataMat_train{i}, targetMat_train{i});
    targetMat_prediction{i} = regRF_predict(dataMat_test{i}, model);
    
    deviation(i) = accurPrediction(targetMat_prediction{i}, targetMat_validation{i});
    
    fprintf('\n Cross validation %d finished, Running time: %.2f; \n', i, toc);
end


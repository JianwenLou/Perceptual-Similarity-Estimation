% ==== Extract PCANet features from procedural textures =======
% ========================

clear all; 
close all; 
clc; 

imgSize = 512; 
imgFormat = 'gray'; %'color' or 'gray'

%% Loading data from generated procedural textures
% load procedural textures data
trnData = load('.\Results\proceduralTextures.mat'); 
trnData = trnData.allImg';

%% PCANet parameters (they should be funed based on validation set; i.e., ValData & ValLabel)
% We use the parameters in our IEEE TPAMI submission
PCANet.NumStages = 2;
PCANet.PatchSize = [7 7];
PCANet.NumFilters = [8 8];
PCANet.HistBlockSize = [128 128]; 
PCANet.BlkOverLapRatio = 0.1;
PCANet.Pyramid = [];

fprintf('\n ====== PCANet Parameters ======= \n')

%% PCANet Feature Extraction 
fprintf('\n ====== PCANet Training ======= \n')
trnData_ImgCell = mat2imgcell(trnData,imgSize,imgSize,imgFormat); % convert columns in TrnData to cells 
clear trnData; 
tic;
[ftrn V BlkIdx] = PCANet_train(trnData_ImgCell,PCANet,1); % BlkIdx serves the purpose of learning block-wise DR projection matrix; e.g., WPCA
PCANet_TrnTime = toc;
clear trnData_ImgCell; 
fprintf('\n     PCANet training time: %.2f secs.    \n', PCANet_TrnTime);

save .\Results\featuresPCANet_Overlap_0.mat ftrn -v7.3;


    
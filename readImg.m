% Read images, and store them into one matrix, each column of the matrix is
% a image.

close all;
clear all;
clc;

% Get list of all  files in this directory
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
imgFiles = dir('.\Data\PerTex\rendered_1024x1024\*.png');      
nfiles = length(imgFiles);    % Number of files found

img = imread(imgFiles(1).name);
if(size(img, 3) == 3)
    img = rgb2gray(img);
end
height = size(img, 1);
width = size(img, 2);
imgMat = zeros(height*width, nfiles); % each column represents an image
imgMat(:, 1) = reshape(img, height*width, 1); 

for i = 2:nfiles
   img = imread(imgFiles(i).name);
   if(size(img, 3) == 3)
        img = rgb2gray(img);
   end
   imgMat(:, 1) = reshape(img, height*width, 1); 
   fprintf('\n Reading %s \n', imgFiles(i).name);
end

% function [panorama] = main(folder)
clear all;close all;clc;

%% Reading images from the folder
disp("Reading images from the folder...");
folder = '../glacier4';
img_arr = readFolder(folder);

%% Preprocessing the images.
disp("Preprocessing Images...");
img_arr = preprocessing(img_arr);
k = size(img_arr,2);

%% Get Features.
feat = {};points = {};
disp('Extracting SURF features...');
for i = 1:k
    [points{i},feat{i}] = getSURFFeatures(img_arr{i});
end

%% Finding all possible image matches
disp("Finding the image matches...");
[matches,pairs] = image_match(points,feat);


%% RANSAC algorithm to find inlier points
disp("Running RANSAC for matched images...");
[inliers,best] = RANSAC(matches,k,pairs);
plot_SURF(img_arr,matches,pairs,inliers);

%% Bundle Adjustment

% end
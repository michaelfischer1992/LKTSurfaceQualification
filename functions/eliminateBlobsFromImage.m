function [originalImageNoMatIslands] = eliminateBlobsFromImage(thisImage)
%% eliminateBlobsFromImage

%% Script Description
% this function eliminates all searched regions (e.g. material islands)
% Michael Fischer, 08.11.2020

%% Parameters
%

thisImage_tmp = thisImage; 
% declare regionprops -- previously always used bwlabel, but this is not
% necessary. You can directly use the logical image, which is the input
% of this function already. 
% PERFORMANCE - ISSUE - but there's no alternative to regionprops
% with 'PixelList': 3,2 sec - without: 0,8 sec
blobMeasurements = regionprops(thisImage_tmp, 'Area', 'PixelList');
% eliminate largest area (actual material, which was detected as regionprop) 
[~, ab, ~] = intersect(vertcat(blobMeasurements(:).Area), max(vertcat(blobMeasurements(:).Area)));
blobMeasurements(ab) = [];

% eliminate material islands
% PERFORMANCE - NO ISSUE
allPoints = vertcat(blobMeasurements(:).PixelList);
for i = 1 : length(allPoints)
    thisImage_tmp(allPoints(i, 2), allPoints(i, 1)) = 0;
end
% output
originalImageNoMatIslands = thisImage_tmp; 
%% 
%% EOF 
%%
end

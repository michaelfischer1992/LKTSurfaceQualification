function [image_tmp] = drawVerticalLinesForUndercuts(image)
%% drawVerticalLinesForUndercuts

%% Script Description
% 
% Michael Fischer, 08.11.2020

%% Parameters
%


[~, width] = size(image);
image_tmp = image; 
%% first put another 1-pixel layer over everything
for i = 1 : width
    thisRowIdx = image_tmp(:, i) == 1;
    [~, thisRow, ~] = intersect(thisRowIdx, 1);
    image_tmp(thisRow + 1, i) = 1;
end
image_orig = image_tmp; 
%% draw vertical lines 
for i = 2 : width
    thisRowIdx = image_orig(:, i) == 1;
    previousRowIdx = image_orig(:, i - 1) == 1;
    [~, thisPixelRow, ~] = intersect(thisRowIdx, 1);
    [~, previousPixelRow, ~] = intersect(previousRowIdx, 1);
    %% if jump to this pixel was more than 1 pixel upwards --> draw a line
    if (previousPixelRow - thisPixelRow) > 1
        for j = 1 : (previousPixelRow - thisPixelRow)
            image_tmp(previousPixelRow - j, i - 1) = 1;
        end
    end
    %% if jump to this pixel was more than 1 pixel downwards --> draw a line
    if (thisPixelRow - previousPixelRow) > 1
        for j = 1 : abs(thisPixelRow - previousPixelRow)
            image_tmp(previousPixelRow + j, i - 1) = 1;
        end        
    end
end
end

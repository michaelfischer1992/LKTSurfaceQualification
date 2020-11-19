function [outputArg] = calculateSurfaceParameters(app, thisImage, ...
    filterCriteria, parameterType, varargin)
%% calculateSurfaceParameters

%% Script Description
%
% Michael Fischer, 08.11.2020

%% Parameters
%

%% invert originalImage
if isequal(filterCriteria, 'pores')
    originalImageIdx = thisImage == 1;
    originalImageIdxInverted = ~originalImageIdx;
    thisImage = 1*originalImageIdxInverted;
end

[height, width] = size(thisImage);

if ~strcmp(class(thisImage), 'logical')
thisImage = thisImage > 0; 
end
%% calculations
blobMeasurements = regionprops(thisImage, 'Area', 'SubarrayIdx', 'PixelList', 'BoundingBox');
colors = rand(length(blobMeasurements), 3);
emptyIndex = find(arrayfun(@(blobMeasurements) isempty(blobMeasurements.PixelList), blobMeasurements));
blobMeasurements(emptyIndex) = [];
% [~, ab, ~] = intersect(vertcat(blobMeasurements(:).Area), max(vertcat(blobMeasurements(:).Area)));
% blobMeasurements(ab) = [];

% calculate width and height of blob and write it in array (actually not
% necessary) 
quantLabels = length(blobMeasurements);
allBlobs = zeros(quantLabels,4);
for k = 1 : quantLabels
    thisBlob = blobMeasurements(k);
    thisBlobArea = thisBlob.Area;
    [~,thisBlobWidth] = size(thisBlob.SubarrayIdx{1, 2});
    [~,thisBlobHeight] = size(thisBlob.SubarrayIdx{1, 1});
    allBlobs(k,1) = k;
    allBlobs(k,2) = thisBlobArea;
    allBlobs(k,3) = thisBlobWidth;
    allBlobs(k,4) = thisBlobHeight;
end
% delete largest Blob
deleteIdx = allBlobs(:, 2) == max(allBlobs(:, 2));
allBlobs = allBlobs(~deleteIdx, :);

% sort all blobs so we have them in correct order when plotting
allBlobsSorted = sortrows(allBlobs, 2, 'descend');
overallArea = sum(allBlobsSorted(:,2));
VerhaeltnisFlaeche = overallArea / (height*width);

% labelled image (pretty fast)
labeledImage = bwlabel(thisImage, 8);
if nnz(labeledImage == 1) > (0.2*height*width)
    labeledImage(labeledImage == 1) = 0;
elseif nnz(labeledImage == 2) > (0.2*height*width)
    labeledImage(labeledImage == 2) = 0;
end

%% Plot
if app.Data.doPlot
    coloredLabels = label2rgb(labeledImage, colors);
    sqrtBlobs = sqrt(quantLabels);
    prozent = 0.5;
    if sqrtBlobs > 10
        WertInBreite = 10;
        WertInHoehe = 6;
        quantLabels = 61;
    else
        WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
        WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
    end
    figure
    for k = 1 : quantLabels
        % plot blobs in subplot 
        currentBlob = allBlobsSorted(k, 1);
        thisBlob = blobMeasurements(currentBlob);
        thisBlobsBoundingBox = thisBlob.BoundingBox;
        subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
        subplot(WertInHoehe, WertInBreite, k);
        imshow(subImage);
        %% title
        formatSpec = '#%d, Flaeche %d px\nBreite %d px\nHoehe %d px';
        caption = sprintf(formatSpec,k, allBlobsSorted(k, 2), ...
            allBlobsSorted(k, 3), allBlobsSorted(k, 4));
        title(caption, 'FontSize', 8);
    end
    outputArg.coloredLabels = coloredLabels;
end
%% plot overlay image with colored blobs 
if app.Data.doPlot
    imOrig = app.Data.imgOriginal;
    for j = 1 : length(allBlobsSorted)
        currentBlob = allBlobsSorted(j, 1);
        thisBlob = blobMeasurements(currentBlob);
        for i = 1 : size(thisBlob.PixelList, 1)
            imOrig(thisBlob.PixelList(i, 2), thisBlob.PixelList(i, 1), :) =  colors(j, :)*255;
        end
    end
    figure
    imshow(imOrig)
    ax = gca;
    ax.Clipping = 'off';
end
%% output
outputArg.labeledImage = labeledImage;
outputArg.blobMeasurements = blobMeasurements;
outputArg.allBlobs = allBlobs;
disp(['For parameter "', parameterType, '" ' num2str(quantLabels), ' objects were found.'])
disp(['Ratio to image area: ', num2str(ceil(VerhaeltnisFlaeche*100)), '%.'])

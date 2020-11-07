function [outputArg] = calculateSurfaceParameters(handles, thisImage, ...
    filterCriteria, parameterType, varargin)
%% invert originalImage
if isequal(filterCriteria, 'pores')
    originalImageIdx = thisImage == 1;
    originalImageIdxInverted = ~originalImageIdx;
    thisImage = 1*originalImageIdxInverted;
end
labeledImage = bwlabel(thisImage, 8);
%% unten links eine Pore? (--> Wert = 0 )
[height, width] = size(labeledImage);
if labeledImage(height, 1) == 0
    LabelMaterial = labeledImage(height, 1);
%     disp('ggfs. noch was implementieren');
end
%% calculations

if nnz(labeledImage == 1) > (0.2*height*width)
    labeledImage(labeledImage == 1) = 0;
elseif nnz(labeledImage == 2) > (0.2*height*width)
    labeledImage(labeledImage == 2) = 0;
end

    
blobMeasurements = regionprops(labeledImage, 'Area', 'SubarrayIdx', 'PixelList', 'BoundingBox');
colors = rand(length(blobMeasurements), 3);
emptyIndex = find(arrayfun(@(blobMeasurements) isempty(blobMeasurements.PixelList), blobMeasurements));
blobMeasurements(emptyIndex) = []; 

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
allBlobsSorted = sortrows(allBlobs, 2, 'descend');
overallArea = sum(allBlobsSorted(:,2));
VerhaeltnisFlaeche = overallArea / (height*width);
%% Plot
if handles.doPlot
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
%% output
outputArg.labeledImage = labeledImage;
outputArg.blobMeasurements = blobMeasurements;
outputArg.allBlobs = allBlobs;
disp(['For parameter "', parameterType, '" ' num2str(quantLabels), ' objects were found.'])
disp(['Ratio to image area: ', num2str(ceil(VerhaeltnisFlaeche*100)), '%.'])

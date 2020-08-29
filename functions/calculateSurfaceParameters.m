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
[h, ~] = size(labeledImage);
if labeledImage(h,1) == 0
    LabelMaterial = labeledImage(h,1);
    disp('ggfs. noch was implementieren');
end
%% calculations
quantLabels = max(unique(labeledImage));
colors = [0,0,0; rand(quantLabels, 3)];
coloredLabels = label2rgb(labeledImage, colors);
blobMeasurements = regionprops(labeledImage, 'Area', 'SubarrayIdx', 'PixelList', 'BoundingBox');
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
[h, w] = size(thisImage);
VerhaeltnisFlaeche = overallArea / (h*w);
%% Plot
if handles.doPlot
    sqrtBlobs = sqrt(quantLabels);
    prozent = 0.5;
    WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
    WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
    textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.
    h3 = figure;	% Create a new figure window.
    set(h3, 'WindowState', 'maximized', 'InvertHardCopy', 'off');
    for k = 2 : quantLabels
        %% plot image
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
        title(caption, 'FontSize', textFontSize);
    end
end
%% output
outputArg.labeledImage = labeledImage;
outputArg.blobMeasurements = blobMeasurements;
outputArg.allBlobs = allBlobs;
outputArg.coloredLabels = coloredLabels;
disp(['Zum Kennwert "', parameterType, '" wurden ' num2str(quantLabels), ' Elemente gefunden.'])
disp(['Verhältnis zur Gesamtfläche: ', num2str(ceil(VerhaeltnisFlaeche*100)), '%.'])
disp(['Ergebnisse als "', [datestr8601, 'reducedFieldData.mat'], '" abgespeichert.'])

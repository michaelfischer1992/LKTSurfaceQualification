function [originalImageNoMatIslands] = eliminateBlobsFromImage(thisImage)
labeledImage = bwlabel(thisImage, 8);
blobMeasurements = regionprops(labeledImage, 'PixelList');
for i = 2 : length(blobMeasurements)
    thisBlobInfo = vertcat(blobMeasurements(i).PixelList);
    for j = 1 : size(thisBlobInfo, 1)
        x = thisBlobInfo(j, 1);
        y = thisBlobInfo(j, 2);
        thisImage(y, x) = 0;
    end
end
originalImageNoMatIslands = thisImage; 
end

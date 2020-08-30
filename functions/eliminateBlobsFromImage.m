function [originalImageNoMatIslands] = eliminateBlobsFromImage(thisImage)
labeledImage = bwlabel(thisImage, 8);
blobMeasurements = regionprops(labeledImage, 'PixelList', 'Area');
[~, ab, ~] = intersect(vertcat(blobMeasurements(:).Area), max(vertcat(blobMeasurements(:).Area)));
blobMeasurements(ab) = [];
for i = 1 : length(blobMeasurements)
    thisBlobInfo = vertcat(blobMeasurements(i).PixelList);
    for j = 1 : size(thisBlobInfo, 1)
        x = thisBlobInfo(j, 1);
        y = thisBlobInfo(j, 2);
        thisImage(y, x) = 0;
    end 
end
originalImageNoMatIslands = thisImage; 
end

function analyzeOverallResults(app)
%% load files and set parameters
S = dir(fullfile(app.exportPath,'*.mat')); 
for k = 1:numel(S)
    info = S(k).name;
    S(k).filename = extractBefore(extractAfter(info, "_"), "_o");
end
disp(['Number of .mat-files: ', num2str(numel(S))])
options = {S(:).filename};
choice = menu('Was the scale removed successfully?', options);
thisResultFile = load(fullfile(S(choice).folder, [S(choice).name])).overallResults;
imgOriginal = thisResultFile.imgOriginal;
imgEroded = thisResultFile.imgEroded;

%% parameters
heightImg = size(imgOriginal, 1);
widthImg = size(imgOriginal, 2);
rgbOnline = [66, 164, 245;
    224, 245, 66;
    245, 66, 99;
    40, 158, 57;
    40, 158, 144];
rgb255 = rgbOnline/255;
k1 = thisResultFile.Kennwert1;
k2 = thisResultFile.Kennwert2;
k3 = thisResultFile.Kennwert3;
k4 = thisResultFile.Kennwert4;
k5 = thisResultFile.Kennwert5;
notAnObjectIdxk1 = vertcat(k1.blobMeasurements(:).Area) > 0.07*heightImg*widthImg;
notAnObjectIdxk2 = vertcat(k2.blobMeasurements(:).Area) > 0.07*heightImg*widthImg;
notAnObjectIdxk3 = vertcat(k3.blobMeasurements(:).Area) > 0.07*heightImg*widthImg;
notAnObjectIdxk4 = vertcat(k4.blobMeasurements(:).Area) > 0.07*heightImg*widthImg;
notAnObjectIdxk5 = vertcat(k5.blobMeasurements(:).Area) > 0.07*heightImg*widthImg;
allPixelsK1 = vertcat(thisResultFile.Kennwert1.blobMeasurements(~notAnObjectIdxk1).PixelList);
allPixelsK2 = vertcat(thisResultFile.Kennwert2.blobMeasurements(~notAnObjectIdxk2).PixelList);
allPixelsK3 = vertcat(thisResultFile.Kennwert3.blobMeasurements(~notAnObjectIdxk3).PixelList);
allPixelsK4 = vertcat(thisResultFile.Kennwert4.blobMeasurements(~notAnObjectIdxk4).PixelList);
allPixelsK5 = vertcat(thisResultFile.Kennwert5.blobMeasurements(~notAnObjectIdxk5).PixelList);


%% original image
rgbImage = ind2rgb(imgOriginal, colormap('gray')); % im is a grayscale
plotResultsForEachImage(rgbImage, rgb255, allPixelsK1, allPixelsK2, allPixelsK3, allPixelsK4, allPixelsK5)

%% eroded image
uint8Image = uint8(255 * imgEroded);
rgbImage = ind2rgb(uint8Image, colormap('gray')); % im is a grayscale
plotResultsForEachImage(rgbImage, rgb255, allPixelsK1, allPixelsK2, allPixelsK3, allPixelsK4, allPixelsK5)
end

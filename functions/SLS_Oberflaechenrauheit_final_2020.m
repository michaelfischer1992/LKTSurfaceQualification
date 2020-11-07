function SLS_Oberflaechenrauheit_final_2020
%% paths
app.ImportpathEditField.Value = 'C:\git\LKTSurfaceQualification\images';

%% parameters
app.doPlot = 0;
app.programMode = 'single images'; % 'single image', 'multiple images'
app.LengthScaleEditField = 50; % mycrometer - Massstab 
app.MassstabLaenge = 50; % mycrometer - Massstab 
app.erosionType = 'diamond';
app.erosionValue = 2;
app.pixelsWidthCheckIfPore = 40; % just to make sure that no hard coded vals in code 
app.SurfaceRoughnessSections = 50; % surface Roughness
desiredWidth = 400; 
maxSizeOfImage = 4000000; % equals size of 2000 x 2000 pixel -- everything larger get's scaled down when in fastMode
fastMode = 1; % scaling down, if image is too big 

LKTPATH        = 'C:\git\LKTSurfaceQualification';
try
    cd(LKTPATH)
catch
    
end
% adding paths from git
app.currentFolder = pwd;
app.guiImagesPath = [app.currentFolder, '\gui_pics'];
app.logfiles = [app.currentFolder, '\log_files'];
app.exportPath = [app.currentFolder, '\export'];
app.functionPath = [app.currentFolder, '\functions'];
app.functionPath2017 = [app.currentFolder, '\functions\from2017'];
app.imagePath = [app.currentFolder, '\images'];
addpath(app.exportPath);
addpath(app.logfiles);
addpath(app.guiImagesPath);
addpath(app.functionPath);
addpath(app.functionPath2017);
addpath(app.imagePath);

% diary
diaryFile = fullfile(app.logfiles, [datestr8601, '_log.txt']);
diary(diaryFile)
diary on

%% load image



try
    if strcmp(app.programMode, 'multiple images')
        %% first: Check, if all images in the given folder have the same size
        % --> do this, even before the user clicks on load image.
        % Load image afterwards starts automatically - the user
        % only has to "scale" and "rectangle"
        
        importPath = 'C:\Users\micha\Documents\Master ME\Oberflaechenrauheit-LKT\PA_repaired\bilder_PA\Mikroskopiebilder\funktionieren'; 
        S = dir(fullfile(importPath, '*.jpg')); % pattern to match filenames.
        if numel(S) > 1
            %% everything alright
            disp([num2str(numel(S)), ' images found.'])
        else
            disp('no images here')
            keyboard
        end
        for k = 1:numel(S)
            info = imfinfo(fullfile(importPath,S(k).name));
            [ ~ , Imagesdata(k).name , ~ ] = fileparts(info.Filename);
            Imagesdata(k).height = info.Height;
            Imagesdata(k).width = info.Width;
            Imagesdata(k).filename = info.Filename;
        end
        S_tmp = Imagesdata;
        allImagesHeight = vertcat(Imagesdata(:).height);
        allImagesWidth = vertcat(Imagesdata(:).width);
        if length(unique([allImagesHeight, allImagesWidth])) == 2
            disp('all images the same')
        else
            [idxOmitted1] = throwOutImagesWithDifferenAspectRation(app, allImagesWidth, S_tmp);
            [idxOmitted2] = throwOutImagesWithDifferenAspectRation(app, allImagesHeight, S_tmp);
            idxOmitted = and(~idxOmitted1, ~idxOmitted2);
            S_tmp = S_tmp(idxOmitted);
        end
        disp([num2str(numel(S_tmp)), ' images remaining.'])
        %% read first image with scale bar
        message = ('Select your start image. IMPORTANT: The image has to show a scale!');
        msgbox(message, 'Important Notice','warn');
        app = userSelectsImageInExplorer(app);
        app.ImagesData = S_tmp;
    else
        app = userSelectsImageInExplorer(app);
    end
    %% load image
    imgPath = [app.BildPfad app.BildNamePlusExtention];
    app.imgOriginal = imread(imgPath);
    %% scale image down 
    if fastMode 
       scaleDownFactor = maxSizeOfImage / (size(app.imgOriginal, 2) * size(app.imgOriginal, 1)); 
    end
    app.imgOriginal = imresize(app.imgOriginal, scaleDownFactor);
    %% plot original image
    plotImageWindowsized(app, app.imgOriginal)
    %% plot figure into GUI
%     showFigureInGUI(app)
    %% let user draw two points to get the scale bar
    [app.MassstabXVals, app.MassstabYVals] = getScaleValues(app); 
catch
    disp('no image selected.')
end

%% perparation of image
%% delete the previously opened image and highlight buttons green

if strcmp(app.programMode, 'multiple images')
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% remove scale for 1st image
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% calculate scale and read out SI value
    app = calculateScaleFromPreviousUserSelection(app);
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Part I: Image preparation
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% calculate threshold
    app = calcGrayscaleThresholdInImage(app);
    %% grayscale to binary image
    app = convertGrayscaleToBinaryImage(app);
    %% eliminate scale through user interaction: User has to draw a rectangle around the scale
    app = elimateScaleThroughUserDrawingRectangle(app);
    %% prepare image (erode, dilate, etc.)
    app = prepareImageWithBWAreaOpenOpenCloseCtc(app);
    %% align image horizontally, cut off edges
    app = alignImageHorizontally(app);
    %% plot contours
    app = plotContoursInImage(app);
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Part II: Calculate parameters and export
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    app = runAllQualityParametersWithGivenParameters(app);
    exportAllResultsToMatFile(app, app.ImagesData(1).name); %% muss nicht zwingend das erste Bild das mit Scale sein.. Aber dann stimmt sowieso mehr nicht
    
    for i = 2 : numel(app.ImagesData)
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Part 0: Load this image
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        imgPath = app.ImagesData(i).filename;
        app.imgOriginal = imread(imgPath);
%         showFigureInGUI(app)
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Part I: Image preparation
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% calculate threshold
        app = calcGrayscaleThresholdInImage(app);
        %% grayscale to binary image
        app = convertGrayscaleToBinaryImage(app);
        %% remove scale
        app.imgBWnoScale = app.imgBW; 
        app.imgBWnoScale(app.yValsRectScale, app.xValsRectScale) = 1;
        %% prepare image (erode, dilate, etc.)
        app = prepareImageWithBWAreaOpenOpenCloseCtc(app);
        %% align image horizontally, cut off edges
        app = alignImageHorizontally(app);
        %% plot contours
        app = plotContoursInImage(app);
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Part II: Calculate parameters and export
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        app = runAllQualityParametersWithGivenParameters(app);
        disp('-')
        disp('-')
        disp('--------------------------------------------------------------------------------------------------------------------------')
        disp(['Image ', app.ImagesData(i).name])
        exportAllResultsToMatFile(app, app.ImagesData(i).name)
    end
    
else
    app = calculateScaleFromPreviousUserSelection(app);
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Part I: Image preparation
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% calculate threshold
    app = calcGrayscaleThresholdInImage(app);
    %% grayscale to binary image
    app = convertGrayscaleToBinaryImage(app);
    %% eliminate scale through user interaction: User has to draw a rectangle around the scale
    app = elimateScaleThroughUserDrawingRectangle(app);
    %% prepare image (erode, dilate, etc.)
    app = prepareImageWithBWAreaOpenOpenCloseCtc(app); 
    %% align image horizontally, cut off edges
    app = alignImageHorizontally(app); 
    %% plot contours
    app = plotContoursInImage(app);
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Part II: Calculate parameters and export
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    app = runAllQualityParametersWithGivenParameters(app);
    exportAllResultsToMatFile(app, app.BildName)
end

[app.overallResults.imgOriginal] = app.imgOriginal;
[app.overallResults.imgEroded] = app.imgEroded;
diary off
end


%% userSelectsImageInExplorer
function app = userSelectsImageInExplorer(app)
[FileName, PathName]  = uigetfile(  ...
    {'*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.psd',...
    'picture Files (*.jpg,*.jpeg,*.png,*.tif,*.tiff,*.psd)';
    '*.jpg;*.jpeg',  'jpg files (*.jpg,*.jpeg)'; ...
    '*.png',  'png files (*.png)'; ...
    '*.*',  'All Files (*.*)'}, 'Bitte wählen Sie ein Mikroskopiebild aus', app.ImportpathEditField.Value);
filename = [PathName, FileName];
[pathstr, name, ext] = fileparts(filename);
if isequal(FileName,0)
    disp('User selected Cancel')
else
    disp(['User selected ', filename])
end
app.BildPfad = [pathstr '\'];
app.BildName = name;
app.BildNamePlusExtention = [name, ext];
end

%% userChooseScaleRectangle
function [choice, imgBw_tmp, app] = userChooseScaleRectangle(app)
imshow(app.imgBW)
options = {'Yes','No - Try Again'};
text(200, 1800, ['Please draw a rectangle', newline, 'around the scale bar', newline, 'incl. the scale value'], ...
    "FontSize", 20, "Color", '#b02e4a', "FontWeight","bold")
imgBw_tmp = app.imgBW;
try
    rect = getrect;
    rectrd = round(rect);
    app.xValsRectScale = rectrd(1):(rectrd(1) + rectrd(3));
    app.yValsRectScale =  rectrd(2):(rectrd(2) + rectrd(4));
    imgBw_tmp(app.yValsRectScale, app.xValsRectScale) = 1;
    imshow(imgBw_tmp)
catch
    message = sprintf('Please draw the rectangle inside the figure.');
    msgbox(message, 'Scale Removal failed', 'error');
end
delete(findall(gcf,'type','text'))
choice = menu('Was the scale removed successfully?', options);
end

%% calcGrayscaleThresholdInImage
function app = calcGrayscaleThresholdInImage(app)
%% calculate threshold
[app.imageHeight, app.imageWidth, ~] = size(app.imgOriginal);
pxW = 5;
centeredValues = (round(app.imageWidth/2)-pxW):(round(app.imageWidth/2)+pxW);
upperFractionOfImage = app.imgOriginal(pxW:1:(pxW+10),centeredValues);
lowerFractionOfImage = app.imgOriginal((app.imageHeight-(3*pxW)):(app.imageHeight-pxW),centeredValues);
app.hintergrundwert =  mean2(upperFractionOfImage);
app.materialwert = mean2(lowerFractionOfImage);
app.schwellwert = (app.hintergrundwert + app.materialwert)/2;
end

%% convertGrayscaleToBinaryImage
function app = convertGrayscaleToBinaryImage(app)
img = app.imgOriginal;
if size(img, 3)==3
    img2 = rgb2gray(img);
else
    img2 = img;
end
app.imgBW = img2 > app.schwellwert;
if app.doPlot
    app.hfig = imshow(app.imgBW);
end
end
%% Functions that are not yet used
%% throwOutImagesWithDifferenAspectRation
function [idxOmitted] = throwOutImagesWithDifferenAspectRation(app, HorW, S_tmp)
disp('the following images have a different aspect ratio and are therefore omitted: ')
[~,~,ix1] = unique(HorW(:, 1));
if nnz(ix1 == 1) > 0.6*numel(S_tmp)
    idx1 = ix1 == 1;
    idxOmitted = ~idx1;
    if nnz(idxOmitted) ~= 0
        disp(num2str(S_tmp(idxOmitted).name))
    end
else
    %% debug
    keyboard
end
end


%% calculateScaleFromPreviousUserSelection
function app = calculateScaleFromPreviousUserSelection(app)
rx = app.MassstabXVals;
app.MassstabWert = app.MassstabLaenge/abs(rx(1) - (rx(2)));
end

%% elimateScaleThroughUserDrawingRectangle
function app = elimateScaleThroughUserDrawingRectangle(app)
figure
[choice, imgBw_tmp, app] = userChooseScaleRectangle(app);
while choice == 2
    %% try again
    [choice, imgBw_tmp, app] = userChooseScaleRectangle(app);
end
text(200, 1800, ['Looks good!', newline, 'Thanks :)'], ...
    "FontSize", 20, "Color", '#1ba843', "FontWeight","bold")
pause(1)
close all
app.imgBWnoScale = imgBw_tmp;
if app.doPlot
    figure
    imshow(app.imgBWnoScale)
end
end

%% prepareImageWithBWAreaOpenOpenCloseCtc
function app = prepareImageWithBWAreaOpenOpenCloseCtc(app)
%% decide weather it's a normal or panorama image
widthHeightRatio =  app.imageWidth / app.imageHeight;
if widthHeightRatio < 1.5
    imageType = 'normal';
else
    imageType = 'panorama';
end

%% count the material islands that are in the image right now
tic
initialRegionProps = regionprops(app.imgBWnoScale);
toc
quantInit = length(initialRegionProps);
%% filter all objects that are small than filterTS
if strcmp(imageType, 'normal')
    filterTS = 3;
    P = 1;
else
    filterTS = 10;
    P = 10;
end

%% Remove small objects from binary image
areasInit = sort(vertcat(initialRegionProps(:).Area));
areaAll = sum(areasInit(1:(quantInit-1)));
initialAreasSmallerTS = nnz((areasInit) <= filterTS);
BW_tmp = app.imgBWnoScale;
initialAreasSmallerTS_tmp = initialAreasSmallerTS;
initialRegionProps_tmp = regionprops(BW_tmp);
while initialAreasSmallerTS_tmp > 1
    BW_tmp = bwareaopen(BW_tmp, P);
    initialRegionProps_tmp = regionprops(BW_tmp);
    disp(['bwareaopen: Of ', num2str(initialAreasSmallerTS), ' objects (< ', ...
        num2str(filterTS), 'px) ', num2str(initialAreasSmallerTS - length(initialRegionProps_tmp)), ...
        ' have been eliminated (current size: ', num2str(P), ')'])
    initialAreasSmallerTS_tmp = nnz(sort(vertcat(initialRegionProps_tmp(:).Area)) <= filterTS);
    P = P + 1;
end

se = strel(app.erosionType, app.erosionValue);

%% Morphologically close image
BW_tmp = imclose(BW_tmp, se);
i0 = length(initialRegionProps_tmp);
i1_tmp = length(regionprops(BW_tmp));
i1 = i0 - i1_tmp;
disp(['After imclose: ', num2str(i1_tmp), ' objects remain. (', num2str(i1), ' deleted)'])

%% Morphologically open image
BW_tmp = imopen(BW_tmp, se);
i2_tmp = length(regionprops(BW_tmp));
i2 = i1_tmp - i2_tmp;
disp(['After imopen: ', num2str(i2_tmp), ' objects remain. (', num2str(i2), ' deleted)'])

%% display results
i3 = round(((quantInit - i2_tmp) / quantInit) * 100, 1);
initialRegionProps = regionprops(BW_tmp);
quantInit = length(initialRegionProps);
areasInit = sort(vertcat(initialRegionProps(:).Area));
areaAll_after = sum(areasInit(1:(quantInit-1)));
i4 = round(((areaAll - areaAll_after) / areaAll) * 100, 1);
disp(['Overall reduction of objects ', num2str(i3), '%'])
disp(['Reduction in area ', num2str(i4), '%'])
if app.doPlot
    figure
    subplot(2,1,1)
    imshow(app.imgBWnoScale)
    subplot(2,1,2)
    imshow(BW_tmp)
end
app.imgEroded = BW_tmp;
app.imgErod = app.imgEroded;
end

%% alignImageHorizontally
function app = alignImageHorizontally(app)
boundary = realeKontur(app.imgEroded);
width = app.imageWidth;
height = app.imageHeight;
Start(1,2) = 1;
Start(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Start(1,2));
Ende(1,2) = width;
Ende(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Ende(1,2));
diffLR = Ende(1,1)-Start(1,1); % Unterschied der y-Komponenten
winkel = atand(diffLR/(width/2));
imgBWDreh = imrotate(app.imgEroded,winkel,'nearest','crop');
imgOrigDreh = imrotate(app.imgOriginal, winkel,'nearest','crop');
%% cut off black lines at corners. ceil: so don't cut off too less
linkeGrenze=abs(ceil(height/2 * diffLR/(width/2)));
if linkeGrenze <= 0
    linkeGrenze = 1;
end
rechteGrenze=width-floor(height/2 * diffLR/(width/2));
if rechteGrenze >= width
    rechteGrenze = width-1;
end
untereGrenze = ceil(height * tan(deg2rad(winkel)));
imgBWSchnitt = imgBWDreh(1:(height - abs(untereGrenze)), linkeGrenze:rechteGrenze);
imgOrigSchnitt = imgOrigDreh(:,linkeGrenze:rechteGrenze);
app.imgErod = imgBWSchnitt;
app.imgOrig = imgOrigSchnitt;
if app.doPlot
    app.hfig = imshow(app.imgErod);
    app.hfig = imshow(app.imgOrig);
end

%% usually there wouldn't be a pore now in the lower left corner.
[height, ~, ~] = size(app.imgErod);
for i = height : -1 : 1
    if app.imgErod(i,1) == 0
        continue
    else
        lastLine = i + 1;
        break
    end
end
for i = 1 : size(app.imgErod,2)
    if app.imgErod(height,i) == 0
        continue
    else
        lastRow = i;
        break
    end
end
app.imgErod(lastLine:height, 1:lastRow) = 1;

%% if the first 40 pixels are all black, then it's surely no pore
if nnz(app.imgErod(height,1:app.pixelsWidthCheckIfPore)) == 0
    %% crop the image up to 'lastLine'
    imgBWSchnittSecond = imgBWSchnitt(1 : lastLine, :);
    app.imgErod = imgBWSchnittSecond;
    imgOrigSchnittSecond = imgOrigSchnitt(1 : lastLine, :);
    app.imgOrig = imgOrigSchnittSecond;
    if app.doPlot
        app.hfig = imshow(app.imgErod);
        app.hfig = imshow(app.imgOrig);
    end
end
end

%% plotContoursInImage
function app = plotContoursInImage(app)
Massstab = app.MassstabWert;
img = app.imgErod;
boundary = realeKontur(img);
[heightBoundary,~] = size(boundary);
[height,width,~] = size(img);

% calculate length of real contour
laengeOberfl=0;
for i =2:heightBoundary
    laengeOberfl = laengeOberfl + sqrt((boundary(i,1)-boundary(i-1,1))^2 + (boundary(i,2)-boundary(i-1,2))^2);
end
app.realeKonturY = boundary(:,1);
app.realeKonturX = boundary(:,2);
disp(['real contour length: ', num2str(round(laengeOberfl*Massstab)), ' µm / ', ...
    num2str(laengeOberfl), ' px.']);
disp(['picture width: ', num2str(round(width*Massstab)), ' µm / ', ...
    num2str(width), ' px.']);
disp(['ratio: ', num2str(round(laengeOberfl/width, 1))]);

%% calculate top view surface
count = 0;
iZeile = 0;
zWerte = zeros(width*5,2);
for i = 1:(width*5)
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if img(j,i) == 1
            zWerte(iZeile,1) = j;
            if i > 1
                a = zWerte(iZeile,1);
                b = zWerte(iZeile-1,1);
                if abs(b - a) > 1
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2);
                    zWerte(iZeile,1) = j;
                    count = count + 1;
                end
            end
            break;
        end
    end
    if iZeile - count >= width - 1
        break
    end
end

zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];
app.aufKontur = zWerte;
Mittel = mean2(app.realeKonturY); % Bild bereits ausgerichtet, deshalb Mittelwertberechnung nun trivial

if app.doPlot
    app.hfig = imshow(app.imgErod);
    hold on;
    plot(app.realeKonturX, app.realeKonturY, 'g', 'Linewidth', 2);
    plot(app.aufKontur(:,2), app.aufKontur(:,1),'r','Linewidth',2);
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
    
    app.hfig = imshow(app.imgOrig);
    hold on;
    plot(app.realeKonturX, app.realeKonturY, 'g', 'Linewidth', 2);
    plot(app.aufKontur(:,2), app.aufKontur(:,1),'r','Linewidth',2);
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
end

% imshow(app.imgOrig, 'Parent', app.UIAxes_2);
% hold(app.UIAxes_2,'on')
% plot(app.realeKonturX, app.realeKonturY, 'g', 'Linewidth', 2, 'Parent', app.UIAxes_2); % g: gruen; Linewidth: 2 Pixel (breite Linie)
% plot(app.aufKontur(:,2), app.aufKontur(:,1),'r','Linewidth',2, 'Parent', app.UIAxes_2);
% plot([1 width],[Mittel Mittel],'b','Linewidth', 2, 'Parent', app.UIAxes_2);
% hold(app.UIAxes_2,'off')
% set(app.CalculateButton, 'BackgroundColor', 'green');
end

%% exportAllResultsToMatFile
function exportAllResultsToMatFile(app, imgName)
filename = fullfile(app.exportPath, [datestr8601, '_', imgName, '_overallResults.mat']);
overallResults = app.overallResults;
save(filename, 'overallResults')
disp(['Results saved as "', [datestr8601, '_overallResults.mat'], '" in export folder: "', app.exportPath, '"'])
disp('--------------------------------------------------------------------------------------------------------------------------')
disp('-')
disp('-')
winopen(app.exportPath);
end

%% plotImageWindowsized
function plotImageWindowsized(app, image)
figure
imshow(image)
%             set(gcf, 'WindowState', 'maximized', 'InvertHardCopy', 'off', 'Name', 'Original Image');
set(gcf, 'Name', 'Original Image');
end

%% getScaleValues
function [x, y] = getScaleValues(app)
[choice, x, y] = letUserDrawEdgesOfScale(app);
while choice == 2
    %% try again
    [choice, x, y] = letUserDrawEdgesOfScale(app);
end
delete(findall(gcf,'type','text'))
text(200, 1800, ['Looks good!', newline, 'Thanks :)'], ...
    "FontSize", 20, "Color", '#1ba843', "FontWeight","bold")
pause(1)
close all
end


%% letUserDrawEdgesOfScale
function [choice, x, y] = letUserDrawEdgesOfScale(app)
delete(findall(gcf,'type','text'))
delete(findall(gcf,'type','line'))
text(200, 1800, ['Please make two points on each side of scale bar. ', newline, 'Make second point by double-click'], ...
    "FontSize", 20, "Color", '#b02e4a', "FontWeight","bold")
[x,y] = getpts;
% loop to check if it's two points that were selected 
while length(x) ~= 2 
    warning('You have to select two points!')
    [x,y] = getpts;
end
    
hold on
% draw marker crosses in image
scaleVerification = drawPoint(x,y);
set(scaleVerification, ...
    'marker'          , '+'         , ...
    'MarkerSize'      , 50           , ...
    'Color' , '#bf4204'      , ...
    'MarkerEdgeColor' , '#bf4204'      , ...
    'DisplayName' , 'Legend Entry'      , ...
    'MarkerFaceColor' , '#bf4204'  );
options = {'Yes','No - Try Again'};
choice = menu('Are the points laying nicely on both ends of the scale bar?', options);
end



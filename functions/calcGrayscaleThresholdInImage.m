function app = calcGrayscaleThresholdInImage(app)
%% calcGrayscaleThresholdInImage

%% Script Description
% 
% Michael Fischer, 08.11.2020


%% parameters 
pxW = 5;
dist2Border = 20; % start from bottom at 20 pixel 
sampleHeight = 10; % pixel height of sample = 10
% take sample at 25%, 50% and 75% of image width, and take the smallest for
% background, the largest for material 
positionsOfSamples = [0.05, 0.25, 0.5, 0.75, 0.95]; 
% initialize arrays 
hintergrundwert = NaN(length(positionsOfSamples), 1); 
materialwert = NaN(length(positionsOfSamples), 1); 

%% 
% convert rgb to grayscale 
if size(app.Data.imgOriginal, 3)==3
    img = rgb2gray(app.Data.imgOriginal);
else
    img = app.Data.imgOriginal;
end
% plot imgOriginal
if app.Data.doPlot
    figure, imshow(img)
    ax = gca;
    ax.Clipping = 'off';    % turn clipping off
end
[imageHeight, imageWidth, ~] = size(img);
for i = 1 : length(positionsOfSamples)
    xPos = round(imageWidth * positionsOfSamples(i)); 
    centeredValues = (xPos - pxW) : (xPos + pxW);
    upperFractionOfImage = img(dist2Border : (dist2Border + sampleHeight), centeredValues);
    yRange = (imageHeight - (dist2Border + sampleHeight)) : (imageHeight - dist2Border); 
    lowerFractionOfImage = img(yRange, centeredValues);
    hintergrundwert(i, :) =  mean2(upperFractionOfImage);
    materialwert(i, :) = mean2(lowerFractionOfImage);
end

% calculate threshold
schwellwert = (min(hintergrundwert) + max(materialwert))/2;

% convert grayscale image to binary image
imgBW = img > schwellwert;
if app.Data.doPlot
    figure, imshow(imgBW)
    ax = gca;
    ax.Clipping = 'off';    % turn clipping off
end

%%
% fill up the image with white, where there is background at the bottom of
% material (e.g. in panoramic images '1B_3mm_l1_2048', starting from bottom
% left) --> makes sense to do it with binary image (easy to identify the
% area

% determine max height 
critHeight = imageHeight; 
while imgBW(critHeight, 1) == 0 
    critHeight = critHeight - 1; 
end

% only if such a phenomenom exists 
if (imageHeight - critHeight) > 0
    % clip this region and make regionprops on it. The largest regionprops is
    % then the one we need to fill with ONES
    imgBW_clipped = imgBW(critHeight:imageHeight, :);
    imgBW_clipped_RegionProps = regionprops(~imgBW_clipped, 'Area', 'PixelList');
    % take the largest area 
    [~, ab, ~] = intersect(vertcat(imgBW_clipped_RegionProps(:).Area), max(vertcat(imgBW_clipped_RegionProps(:).Area)));
    relevantPixelList = imgBW_clipped_RegionProps(ab).PixelList;
    imgBW_tmp = imgBW;
    for i = 1 : length(relevantPixelList)
        imgBW_tmp( relevantPixelList(i, 2) + critHeight - 1, relevantPixelList(i, 1)) = 1;
    end
    if app.Data.doPlot
        figure, imshow(imgBW_tmp)
        ax = gca;
        ax.Clipping = 'off';    % turn clipping off
    end
    % output on command line
    disp(['Background area at the bottom filled with ones (area: ', ... 
        num2str(length(relevantPixelList)) , ' px, width: ', num2str(max(relevantPixelList(:, 1))) , ' px).'])
else
    imgBW_tmp = imgBW;
end

%% output 
app.Data.imageHeight = imageHeight;
app.Data.imageWidth = imageWidth;
app.Data.schwellwert = schwellwert;
app.Data.imgBW = imgBW_tmp;

%% 
%% EOF 
%%
end
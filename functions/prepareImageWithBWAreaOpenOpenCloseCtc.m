function app = prepareImageWithBWAreaOpenOpenCloseCtc(app)

%% prepareImageWithBWAreaOpenOpenCloseCtc

%% Script Description
% especially important for panormaic images: Reduce number of elements in
% image, otherwise calculation time is way too high. 

% Michael Fischer, 08.11.2020

%% Parameters
aspectRatioTS = 1.5; 

%% decide weather it's a normal or panorama image
widthHeightRatio =  app.Data.imageWidth / app.Data.imageHeight;
if widthHeightRatio < aspectRatioTS
    imageType = 'normal';
else
    imageType = 'panorama';
end

%% filter all objects that are small than filterTS
if strcmp(imageType, 'normal')
    filterMatIslands = 3;
    filterPores = 3;
    P = 1;
    interval4P = 2; 
else
    filterMatIslands = 100;
    filterPores = 20;
    P = 20;
    interval4P = 30; 
    app.Data.erosionValue = 3;
end

%% count the material islands that are in the image right now
tic
initialRegionProps = regionprops(app.Data.imgBWnoScale, 'Area');
toc
% eliminate largest area (actual material, which was detected as regionprop) 
[~, ab, ~] = intersect(vertcat(initialRegionProps(:).Area), max(vertcat(initialRegionProps(:).Area)));
initialRegionProps(ab) = [];
% quantity of regionprops
quantInit = length(initialRegionProps);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remove small objects (material islands) from binary image
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the regions smaller threshold
areasInit = sort(vertcat(initialRegionProps(:).Area));
areaAll = sum(areasInit);
initialAreasSmallerTS = nnz((areasInit) <= filterMatIslands);
% initialize image 
BW_bwAreaOpen = app.Data.imgBWnoScale;
initialAreasSmallerTS_tmp = initialAreasSmallerTS;
while initialAreasSmallerTS_tmp > 1
    tic
    BW_bwAreaOpen = bwareaopen(BW_bwAreaOpen, P);
    toc
    if app.Data.doPlot 
        figure, imshow(BW_bwAreaOpen)
        set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
        ax = gca; 
        ax.Clipping = 'off';    % turn clipping off
    end
    tic
    initialRegionProps_tmp = regionprops(BW_bwAreaOpen, 'Area');
    toc
    disp(['bwareaopen: Of ', num2str(initialAreasSmallerTS), ' objects (< ', ...
        num2str(filterMatIslands), 'px) ', num2str(initialAreasSmallerTS - length(initialRegionProps_tmp)), ...
        ' have been eliminated (current size: ', num2str(P), ')'])
    initialAreasSmallerTS_tmp = nnz(sort(vertcat(initialRegionProps_tmp(:).Area)) <= filterMatIslands);
    P = P + interval4P;
end
BW_tmp = BW_bwAreaOpen; 
% save black background (with very distinct undercuts) for later)
tic
blackRegionProps = regionprops(~BW_tmp, 'Area', 'PixelList'); 
toc
[~, ab, ~] = intersect(vertcat(blackRegionProps(:).Area), max(vertcat(blackRegionProps(:).Area)));
backgroundRegionPropMostDistinct = blackRegionProps(ab).PixelList; 
% remember the big pores to preserve their shape 
[~, ab, ~] = intersect(vertcat(blackRegionProps(:).Area), max(vertcat(blackRegionProps(:).Area)));
blackRegionProps(ab) = [];
largePores = vertcat(blackRegionProps(:).Area) > 150;
largePoresRegionProps = blackRegionProps(largePores); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Morphologically close image
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
se = strel(app.TypDropDown.Value, app.SizeSpinner.Value);
BW_imClose = imclose(BW_tmp, se);
% print results
tic
initialRegionProps_tmp2 = regionprops(BW_imClose, 'Area');
toc
disp(['Imclose: Of ', num2str(initialAreasSmallerTS), ' objects (< ', ...
    num2str(filterPores), 'px) ', num2str(initialAreasSmallerTS - length(initialRegionProps_tmp2)), ...
    ' have been eliminated', newline, '(current size (app.Data.erosionValue): ', num2str(app.Data.erosionValue), ')'])
% add the large pores again to image
allPixels = vertcat(largePoresRegionProps(:).PixelList);
BW_tmp_LargePoresDeleted = BW_imClose;
tic
for i = 1 : length(allPixels)
    BW_tmp_LargePoresDeleted(allPixels(i, 2), allPixels(i, 1)) = 0;
end
toc
% add distinct background with undercuts again to image 
tic
for i = 1 : length(backgroundRegionPropMostDistinct)
    BW_tmp_LargePoresDeleted(backgroundRegionPropMostDistinct(i, 2), backgroundRegionPropMostDistinct(i, 1)) = 0;
end
toc
BW_tmp = BW_tmp_LargePoresDeleted; 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Morphologically open image
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BW_imOpen = imopen(BW_tmp, se);
i2_tmp = length(regionprops(BW_imOpen)); 
BW_tmp = BW_imOpen; 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% %% remove again the last pores (still a lot of small pores included 
% se = strel(app.Data.erosionType, app.Data.erosionValue);
% BW_imClose = imclose(BW_tmp, se);

%% display results
i3 = round(((quantInit - i2_tmp) / quantInit) * 100, 1);
initialRegionProps = regionprops(BW_tmp, 'Area');
quantInit = length(initialRegionProps);
areasInit = sort(vertcat(initialRegionProps(:).Area));
areaAll_after = sum(areasInit(1:(quantInit-1)));
i4 = round(((areaAll - areaAll_after) / areaAll) * 100, 1);
disp(['Overall reduction of objects ', num2str(i3), '%'])
disp(['Reduction in area ', num2str(i4), '%'])

%% final overview plot (Original image vs. BW vs. filtered image) 
if app.Data.doPlot
    figure
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    
    subplot(1, 5, 1)
    imshow(app.Data.imgOriginal(:, 1:1000,  :))
    title('RGB image original')
    
    subplot(1, 5, 2)
    imshow(BW_bwAreaOpen(:, 1:1000))
    title('BW image original')
    
    subplot(1, 5, 3)
    imshow(BW_imClose(:, 1:1000))
    title('Morphologically closed')
  
    subplot(1, 5, 4)
    imshow(BW_tmp_LargePoresDeleted(:, 1:1000))
    title('Added: Large pores & bwAreaOpen-Background')
  
    subplot(1, 5, 5)
    imshow(BW_tmp(:, 1:1000))
    title('Morphologically opened')
end
if app.Data.doPlot
    figure, imshow(BW_tmp)
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    ax = gca;
    ax.Clipping = 'off'; % turn clipping off
end
app.Data.imgEroded = BW_tmp;
app.Data.imgErod = app.Data.imgEroded;
end
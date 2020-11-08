function app = prepareImageAndcalculateAllParameters(app)
if strcmp(app.ProgrammodeDropDown.Value, 'multiple images')
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
end

function app = calculateScaleFromPreviousUserSelection(app)
rx = app.Data.MassstabXVals;
app.Data.MassstabWert = app.Data.MassstabLaenge/abs(rx(1) - (rx(2)));
end
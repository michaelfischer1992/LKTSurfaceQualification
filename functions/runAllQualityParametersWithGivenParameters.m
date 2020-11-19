function app = runAllQualityParametersWithGivenParameters(app)
tic
[app] = CalcQualityParam1(app);
disp('calculating surface quality parameter 1 took ')
toc

tic
[app] = CalcQualityParam2(app);
disp('calculating surface quality parameter 2 took ')
toc
tic
[app] = CalcQualityParam3(app);
disp('calculating surface quality parameter 3 took ')
toc
tic
[app] = CalcQualityParam4(app);
disp('calculating surface quality parameter 4 took ')
toc
tic
[app] = CalcQualityParam5(app);
disp('calculating surface quality parameter 5 took ')
toc
end

function app = CalcQualityParam1(app)
[results] = calculateSurfaceParameters(app, app.Data.imgEroded, 'matIslands', 'Materialinseln');
% visualUpdateOfGUIAfterFirstParameter(app)
% defineKennwertAsCompleted(app, results, '1') 
%% save results
[app.Data.overallResults.Kennwert1] = results; 
end

function app = CalcQualityParam2(app)
%% find material islands and eliminate
[originalImageNoMatIslands] = eliminateBlobsFromImage(app.Data.imgEroded);
%% find pores and eliminate 
[originalImageBothEliminated] = eliminateBlobsFromImage(~originalImageNoMatIslands);
%% draw vertical lines around undercuts
[thirdStepImage] = drawVerticalLinesForUndercuts(~originalImageBothEliminated);
%% detect undercuts ( = detect pores) 
[results] = calculateSurfaceParameters(app, thirdStepImage, 'pores', 'Materialinseln');
if app.Data.doPlot
    figure
    subplot(2, 3, 1)
    imshow(app.Data.imgEroded)
    title('1: Original SW-Image')
    subplot(2, 3, 2)
    imshow(originalImageNoMatIslands)
    title('2. Elimination of Material Islands')
    subplot(2, 3, 3)
    imshow(~originalImageBothEliminated)
    title('3. Elimination of Pores')
    subplot(2, 3, 4)
    imshow(thirdStepImage)
    title('4. Drawing vertical Lines')
    subplot(2, 3, 5)
    imshow(results.coloredLabels)
    title('5. Detected Undercuts')
end
%% save results
[app.Data.overallResults.Kennwert2] = results; 
end

function app = CalcQualityParam3(app)
[results] = calculateSurfaceParameters(app, app.Data.imgEroded, 'pores', 'Materialinseln');
%% save results
[app.Data.overallResults.Kennwert3] = results; 
end

function app = CalcQualityParam4(app)
%% find material islands and eliminate
[originalImageNoMatIslands] = eliminateBlobsFromImage(app.Data.imgEroded);
%% find pores and eliminate 
[originalImageBothEliminated] = eliminateBlobsFromImage(~originalImageNoMatIslands);
%% draw vertical lines around undercuts
[vertLinesForUndercuts] = drawVerticalLinesForUndercuts(~originalImageBothEliminated);
%% fill out undercuts
[undercutsEliminated] = eliminateBlobsFromImage(~vertLinesForUndercuts); 
%% detect hills and valleys
[roughnessImage] = calcSurfaceRoughness(app, undercutsEliminated);
%% find roughness areas
[results] = calculateSurfaceParameters(app, roughnessImage, 'pores', 'Roughness Areas');
%% save results
[app.Data.overallResults.Kennwert4] = results; 
end

function app = CalcQualityParam5(app)
%% find pores and eliminate 
[poresEliminated] = eliminateBlobsFromImage(~app.Data.imgEroded);
%% store matIslands data
[resultsMatIslands] = calculateSurfaceParameters(app, ~poresEliminated, 'matIslands', 'Materialinseln');
%% detect matIslands data and delete
[matIslandsEliminated] = eliminateBlobsFromImage(~poresEliminated);
%% draw vertical lines around undercuts
[vertLinesForUndercuts] = drawVerticalLinesForUndercuts(matIslandsEliminated);
%% fill out undercuts
[undercutsEliminated] = eliminateBlobsFromImage(~vertLinesForUndercuts); 
%% include material islands again
againWithMatIslands = undercutsEliminated; 
for i = 2 : length(resultsMatIslands.blobMeasurements)
    thisMatIsland = vertcat(resultsMatIslands.blobMeasurements(i).PixelList); 
    for j = 1 : size(thisMatIsland, 1)
        x = thisMatIsland(j, 2);
        y = thisMatIsland(j, 1);
        againWithMatIslands(x, y) = 0;
    end
end
%% draw vertical lines around matIslands
[imageUndercutsBehindMatIslands] = drawVerticalLinesForUndercuts(~againWithMatIslands);
%% detect undercuts ( = detect pores) 
[results] = calculateSurfaceParameters(app, imageUndercutsBehindMatIslands, 'pores', 'Materialinseln'); 
%% save results
[app.Data.overallResults.Kennwert5] = results; 
end


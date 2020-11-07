function handles = runAllQualityParametersWithGivenParameters(handles)
tic
[handles] = CalcQualityParam1(handles);
disp('calculating surface quality parameter 1 took ')
toc
tic
[handles] = CalcQualityParam2(handles);
disp('calculating surface quality parameter 2 took ')
toc
tic
[handles] = CalcQualityParam3(handles);
disp('calculating surface quality parameter 3 took ')
toc
tic
[handles] = CalcQualityParam4(handles);
disp('calculating surface quality parameter 4 took ')
toc
tic
[handles] = CalcQualityParam5(handles);
disp('calculating surface quality parameter 5 took ')
toc
end

function handles = CalcQualityParam1(handles)
[results] = calculateSurfaceParameters(handles, handles.imgEroded, 'matIslands', 'Materialinseln');
% visualUpdateOfGUIAfterFirstParameter(handles)
% defineKennwertAsCompleted(handles, results, '1') 
%% save results
[handles.overallResults.Kennwert1] = results; 
end

function handles = CalcQualityParam2(handles)
%% find material islands and eliminate
[originalImageNoMatIslands] = eliminateBlobsFromImage(handles.imgEroded);
%% find pores and eliminate 
[originalImageBothEliminated] = eliminateBlobsFromImage(~originalImageNoMatIslands);
%% draw vertical lines around undercuts
[thirdStepImage] = drawVerticalLinesForUndercuts(~originalImageBothEliminated);
%% detect undercuts ( = detect pores) 
[results] = calculateSurfaceParameters(handles, thirdStepImage, 'pores', 'Materialinseln');
if handles.doPlot
    figure
    subplot(2, 3, 1)
    imshow(handles.imgEroded)
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
[handles.overallResults.Kennwert2] = results; 
end

function handles = CalcQualityParam3(handles)
[results] = calculateSurfaceParameters(handles, handles.imgEroded, 'pores', 'Materialinseln');
%% save results
[handles.overallResults.Kennwert3] = results; 
end

function handles = CalcQualityParam4(handles)
%% find material islands and eliminate
[originalImageNoMatIslands] = eliminateBlobsFromImage(handles.imgEroded);
%% find pores and eliminate 
[originalImageBothEliminated] = eliminateBlobsFromImage(~originalImageNoMatIslands);
%% draw vertical lines around undercuts
[vertLinesForUndercuts] = drawVerticalLinesForUndercuts(~originalImageBothEliminated);
%% fill out undercuts
[undercutsEliminated] = eliminateBlobsFromImage(~vertLinesForUndercuts); 
%% detect hills and valleys
[roughnessImage] = calcSurfaceRoughness(handles, undercutsEliminated);
%% find roughness areas
[results] = calculateSurfaceParameters(handles, roughnessImage, 'pores', 'Roughness Areas');
%% save results
[handles.overallResults.Kennwert4] = results; 
end

function handles = CalcQualityParam5(handles)
%% find pores and eliminate 
[poresEliminated] = eliminateBlobsFromImage(~handles.imgEroded);
%% store matIslands data
[resultsMatIslands] = calculateSurfaceParameters(handles, ~poresEliminated, 'matIslands', 'Materialinseln');
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
[results] = calculateSurfaceParameters(handles, imageUndercutsBehindMatIslands, 'pores', 'Materialinseln'); 
%% save results
[handles.overallResults.Kennwert5] = results; 
end


function runAllQualityParametersWithGivenParameters(hObject, eventdata, handles)
tic
[handles] = CalcQualityParam1(hObject, eventdata, handles);
disp('calculating surface quality parameter 1 took ')
toc
tic
[handles] = CalcQualityParam2(hObject, eventdata, handles);
disp('calculating surface quality parameter 2 took ')
toc
tic
[handles] = CalcQualityParam3(hObject, eventdata, handles);
disp('calculating surface quality parameter 3 took ')
toc
tic
[handles] = CalcQualityParam4(hObject, eventdata, handles);
disp('calculating surface quality parameter 4 took ')
toc
tic
[handles] = CalcQualityParam5(hObject, eventdata, handles);
disp('calculating surface quality parameter 5 took ')
toc
guidata(hObject,handles);
end

function handles = CalcQualityParam1(hObject, eventdata, handles)
[results] = calculateSurfaceParameters(handles, handles.imgEroded, 'matIslands', 'Materialinseln');
% visualUpdateOfGUIAfterFirstParameter(handles)
% defineKennwertAsCompleted(handles, results, '1') 
%% save results
[handles.overallResults.Kennwert1] = results; 
guidata(hObject,handles);
end

function handles = CalcQualityParam2(hObject, eventdata, handles)
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
%% Visuelles Update in der GUI
axes(handles.axes24)
imshow(results.coloredLabels)
set(handles.text57,'string','Fertiges Bild')
set(handles.uipanel36,'backgroundcolor', handles.gruen)
set(handles.uipanel36,'highlightcolor', handles.gruen)
set(handles.uipanel36,'shadowcolor', handles.gruen)
set(handles.Kennwert2, 'string', 'Fertig!')
set(handles.Kennwert2, 'BackgroundColor', handles.gruen)    
set(handles.Kennwert2, 'ForegroundColor','black')
%% save results
[handles.overallResults.Kennwert2] = results; 
guidata(hObject,handles);
end

function handles = CalcQualityParam3(hObject, eventdata, handles)
[results] = calculateSurfaceParameters(handles, handles.imgEroded, 'pores', 'Materialinseln');
%% Visuelles Update in der GUI
axes(handles.axes25)
imshow(results.coloredLabels)
set(handles.text58,'string','Fertiges Bild')
set(handles.uipanel37,'backgroundcolor', handles.gruen)
set(handles.uipanel37,'highlightcolor',  handles.gruen)
set(handles.uipanel37,'shadowcolor',  handles.gruen)
set(handles.Kennwert3, 'string', 'Fertig!')
set(handles.Kennwert3, 'BackgroundColor', handles.gruen)    
set(handles.Kennwert3, 'ForegroundColor','black')
%% save results
[handles.overallResults.Kennwert3] = results; 
guidata(hObject,handles);
end

function handles = CalcQualityParam4(hObject, eventdata, handles)
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
%% Visuelles Update in der GUI
axes(handles.axes29)
imshow(results.coloredLabels)
set(handles.text62,'string','Fertiges Bild')
set(handles.uipanel41,'backgroundcolor', handles.gruen)
set(handles.uipanel41,'highlightcolor', handles.gruen)
set(handles.uipanel41,'shadowcolor', handles.gruen)
set(handles.Kennwert4, 'string', 'Fertig!')
set(handles.Kennwert4, 'BackgroundColor', handles.gruen)
set(handles.Kennwert4, 'ForegroundColor','black')
set(handles.pushbutton77, 'BackgroundColor', handles.gruen)
set(handles.pushbutton77, 'ForegroundColor','black')
set(handles.pushbutton77, 'string', 'Fertig!')
set(handles.AnzahlUnterteilungenText,'BackgroundColor','green');
set(handles.text64,'backgroundcolor', handles.gruen)
%% save results
[handles.overallResults.Kennwert4] = results; 
guidata(hObject,handles);
end

function handles = CalcQualityParam5(hObject, eventdata, handles)
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
%% Visuelles Update in der GUI
axes(handles.axes27)
imshow(results.coloredLabels)
set(handles.text60,'string','Fertiges Bild')
set(handles.uipanel39,'backgroundcolor', handles.gruen)
set(handles.uipanel39,'highlightcolor', handles.gruen)
set(handles.uipanel39,'shadowcolor', handles.gruen)
set(handles.Kennwert5, 'string', 'Fertig!')
set(handles.Kennwert5, 'BackgroundColor', handles.gruen)    
set(handles.Kennwert5, 'ForegroundColor','black')    
%% save results
[handles.overallResults.Kennwert5] = results; 
guidata(hObject,handles);
end


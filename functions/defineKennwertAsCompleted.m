
function defineKennwertAsCompleted(handles, results, KennwertNr) 
axes(handles.axes26)
imshow(results.coloredLabels)
thisPrefix = (['Kennwert', KennwertNr]); 
thisText = ([thisPrefix, '_text']);
thisButton = ([thisPrefix, '_button']);
thisPanel = ([thisPrefix, '_panel']);
thisAxis = ([thisPrefix, '_axis']);
thisHilfe = ([thisPrefix, '_hilfe']);

set(handles.thisText, 'Fertiges Bild')
set(handles.thisPanel, 'backgroundcolor', handles.gruen)
set(handles.thisPanel, 'highlightcolor', handles.gruen)
set(handles.thisPanel, 'shadowcolor', handles.gruen)
set(handles.thisButton, 'string', 'Fertig!')
set(handles.thisButton, 'BackgroundColor', handles.gruen)    
set(handles.thisButton, 'ForegroundColor', 'black')    
end

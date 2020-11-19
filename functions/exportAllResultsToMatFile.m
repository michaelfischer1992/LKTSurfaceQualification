function exportAllResultsToMatFile(app, imgName)
%% exportAllResultsToMatFile

%% Script Description
% exports all calculated parameters to a mat file and opens that path 
% Michael Fischer, 08.11.2020

%% Parameters
%
[app.Data.overallResults.imgOriginal] = app.Data.imgOriginal;
[app.Data.overallResults.imgEroded] = app.Data.imgEroded;
filename = fullfile(app.Data.exportPath, [datestr8601, '_', imgName, '_overallResults.mat']);
overallResults = app.Data.overallResults;
save(filename, 'overallResults')
disp(['Results saved as "', [datestr8601, '_overallResults.mat'], '" in export folder: "', app.Data.exportPath, '"'])
disp('--------------------------------------------------------------------------------------------------------------------------')
disp('-')
disp('-')
winopen(app.Data.exportPath);
end
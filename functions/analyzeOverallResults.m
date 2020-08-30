allAreas = sort(vertcat(app.overallResults.Kennwert1.blobMeasurements(:).Area)); 
allAreas = allAreas(1:(length(allAreas) - 1));

figure
plot(allAreas)
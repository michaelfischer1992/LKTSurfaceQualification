function kill
allPlots = findall(0, 'Type', 'figure', 'FileName', []);
delete(allPlots);

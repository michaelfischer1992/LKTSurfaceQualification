app.hfig = imtool(app.overallResults.Kennwert1.coloredLabels, 'InitialMagnification', app.scaleResolution);
set(app.hfig, 'WindowState', 'maximized', 'InvertHardCopy', 'off', 'Name', '2. Schwarz-Weiß-Bild');

app.hfig = imtool(app.imgErod, 'InitialMagnification', app.scaleResolution);
set(app.hfig, 'WindowState', 'maximized', 'InvertHardCopy', 'off', 'Name', '2. Schwarz-Weiß-Bild');


Iblur1 = imgaussfilt(app.imgOriginal, 4);


app.hfig = imtool(Iblur1, 'InitialMagnification', app.scaleResolution);
set(app.hfig, 'WindowState', 'maximized', 'InvertHardCopy', 'off', 'Name', '2. Schwarz-Weiß-Bild');
title('Smoothed image, \sigma = 2')
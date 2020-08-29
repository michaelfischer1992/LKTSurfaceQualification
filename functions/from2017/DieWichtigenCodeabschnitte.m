%% 0. Funktionen, die immer benötigt werden

%% 0.1. Bilder in Excel-Tabelle einfuegen

% Step 1: The first step is to create a COM server which runs the Excel Application. 
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error. 
% You can put the above statement within a try-catch block: 
try
        Excel = actxserver('Excel.Application');
catch
        Excel = [];	
end 

% Step 2: In this step, we will open an Excel file “ResultFile.xls” in the current directory. 
ResultFile = [pwd '\20170615_kennwerte_template.xlsm']; 
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);  

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);  

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;


% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=258-10; % 91/0.352
myPicHeight=194 -10; % = 68.52/0.352
myPicWidth3=516 -10; % 182/0.352
myPicHeight3=241 -10; % = 85/0.352

left = Sheet1.Range('Y3').Left + 5;
top = Sheet1.Range('Y3').Top +5;
left2 = Sheet1.Range('AC3').Left + 5;
top2 = Sheet1.Range('AC3').Top + 5;
left3 = Sheet1.Range('Y4').Left + 5;
top3 = Sheet1.Range('Y4').Top + 5;
Shapes.AddPicture([pwd '\20170714T222833_MaterialinselnMikroskopie.tif'] ,0,1,left,top,myPicWidth,myPicHeight)
Shapes.AddPicture([pwd '\20170714T222828_MaterialinselnOverlay.tif'] ,0,1,left2,top2,myPicWidth,myPicHeight)
Shapes.AddPicture([pwd '\20170714T222842_MaterialinselnUebersicht.tif'] ,0,1,left3,top3,myPicWidth3,myPicHeight3)


% Shapes.AddPicture([pwd '\' img] ,0,1,leftPlacement,topPlacement,myPicWidth,myPicHeight);
% Ausdruck.AddPicture(Filename, LinkToFile, SaveWithDocument, Left, Top, Width, Height)
% Left - Die Position (in Punkten) der oberen linken Ecke des Bilds relativ zur oberen linken Ecke des Dokuments.
% Top - Die Position (in Punkten) der oberen linken Ecke des Bilds relativ zum oberen Rand des Dokuments.
% Width - Die Breite des Bilds in Punkten (Geben Sie „-1“ ein, um die Breite der vorhandenen Datei beizubehalten).
% Height - Die Höhe des Bilds in Punkten (Geben Sie „-1“ ein, um die Höhe der vorhandenen Datei beizubehalten).

% Zeilenhöhe: Excel gibt die Zeilenhöhe sowohl in Zoll als auch in "Punkt" an. Dabei gilt: 1 Punkt/Pixel = 0,35277778 mm. 
% Soll die Zeile also 1,5 cm hoch sein, müssen Sie 1,5/0,035277778 = 42,52 wählen.

% Spaltenbreite: Hier müssen Sie leider auf die Breite leider etwas aufwendiger berechnen, 
% da Excel die Punkte je nach Schriftart anders berechnet. 
% Allerdings druckt das Programm immer in der gleichen Auflösung. Deshalb gilt hier: 3,78 Punkt/Pixel = 1mm.

% Shapes are not attached to individual cells in the Excel Worksheet - 
% they float above them and have their own coordinates. If you want to float them above a particular cell, 
% you can get the coordinates of that cell and use those.
% So if you want to float it above cell C9, try:

% Save the workbook and Close Excel
invoke(Workbook, 'SaveAs', [pwd '\myfile.xls']);
invoke(Excel, 'Quit');

%% 0.1. Abspeichern von Bildern mit Benutzerabfragen

message = sprintf('Do you want to save the overview image?');
reply = questdlg(message, 'Save image?', 'Yes', 'No', 'No');
if strcmpi(reply, 'Yes')
    % Ask user for a filename.
    FilterSpec = {'*.PNG', 'PNG Images (*.png)'; '*.tif', 'TIFF images (*.tif)'; '*.*', 'All Files (*.*)'};
    DialogTitle = 'Save image file name';
    % Get the default filename.  Make sure it's in the folder where this m-file lives.
    % (If they run this file but the cd is another folder then pwd will show that folder, not this one.
    thisFile = mfilename('fullpath');
    [thisFolder, baseFileName, ext] = fileparts(thisFile);
    DefaultName = sprintf('%s_HinterschnitteMatInselnUebersicht.tif',datestr8601);
    [fileName, specifiedFolder] = uiputfile(FilterSpec, DialogTitle, DefaultName);
    if fileName ~= 0
        % Parse what they actually specified.
        [folder, baseFileName, ext] = fileparts(fileName);
        % Create the full filename, making sure it has a tif filename.
        fullImageFileName = fullfile(specifiedFolder, [baseFileName '.tif']);
        % Save the labeled image as a tif image.
        saveas(gcf, fullImageFileName)
    end
end
%% 0.1. realeKontur
function Kontur = realeKontur(img)
    %Finden des Startpunktes fuer die Kontur
    [height,width,~] = size(img);
    
    zaehler =0;
    startB =0;
    for i = 1:height
        if img(i,1) == 1
            if startB == 0
                startB = i;
                zaehler = 1;
            else
                zaehler = zaehler +1;
            end
        end
    end
    
    %Insel ueber der Oberflaeche am linken Rand abfangen
    if zaehler >1
        for i=startB:height
            img(i,1) = 1;
        end
    end
    
    %Auslesen der wahren Kontur
    boundary = bwtraceboundary(img,[startB, 1],'E');
    
    %Länge von 'boundary' auslesen
    [heightBoundary,~] = size(boundary);
        
    %Finden des rechten Randes der Kontur in 'boundary'
    for i =1:heightBoundary
       if boundary(i,2) == width
           endeBoundary = i;
           break;
       end
       if i == heightBoundary
           endeBoundary = i;
       end
    end
    
    Kontur = [boundary(1:endeBoundary,1),boundary(1:endeBoundary,2)];
end


%% 1./3. Poren und Materialinseln
% Identify pores/material islands by seeing which pixels are connected to each other.
% Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
% Do connected components labeling with either bwlabel() or bwconncomp().
labeledImage = bwlabel(originalImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
figure;
subplot(1, 3, 1);
imshow(labeledImage, []);  % Show the gray scale image.
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
title('Labeled Image, from bwlabel()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

% change of some values in binary image in case of matIslands: 
if isequal(criteria ,'matIslands')
    [height,width] = size(labeledImage);
    array_merk =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if labeledImage(a_1, a_2) == 1
                array_merk(a_1, a_2) = 1; 
            end
            if labeledImage(a_1, a_2) == 0 
                labeledImage(a_1, a_2) = 1; 
            end
        end
    end
    for a_1 = 1:height
        for a_2 = 1:width
            if array_merk(a_1, a_2) == 1 
                labeledImage(a_1, a_2) = 0;
            end
        end
    end
end 

% Let's assign each blob a different color to visually show the user the distinct blobs.
cm = [0 ,	0	,	0	; 0.80	,	0.41	,	0.81	; 0.66	,	0.01	,	0.67	; 0.63	,	0.32	,	0.70	; 0.19	,	0.24	,	0.34	; 0.86	,	0.42	,	0.13	; 0.77	,	0.52	,	0.27	; 0.84	,	0.41	,	0.76	; 0.20	,	0.36	,	0.41	; 0.06	,	0.25	,	0.23	; 0.01	,	0.50	,	0.04	; 0.71	,	0.83	,	0.24	; 0.12	,	0.59	,	0.86	; 0.37	,	0.97	,	0.68	; 0.88	,	0.71	,	0.05	; 0.40	,	0.40	,	0.21	; 0.01	,	0.80	,	0.27	; 0.76	,	0.59	,	0.45	; 0.11	,	0.04	,	0.82	; 0.87	,	0.18	,	0.46	; 0.16	,	0.64	,	0.92	; 0.22	,	0.78	,	0.07	; 0.75	,	0.56	,	0.64	; 0.66	,	0.95	,	0.38	; 0.83	,	0.73	,	0.52	; 0.20	,	0.09	,	0.51	; 0.02	,	0.54	,	0.16	; 0.22	,	0.84	,	0.08	; 0.21	,	0.51	,	0.42	; 0.61	,	1.00	,	0.75	; 0.59	,	0.30	,	0.55	; 0.35	,	0.08	,	0.19	; 0.12	,	0.59	,	0.38	; 0.81	,	0.05	,	0.45	; 0.87	,	0.83	,	0.73	; 0.49	,	0.96	,	0.85	; 0.30	,	0.53	,	0.54	; 0.95	,	0.91	,	0.59	; 0.50	,	0.48	,	0.21	; 0.44	,	0.81	,	0.21	; 0.48	,	0.79	,	0.22	; 0.53	,	0.63	,	0.77	; 0.20	,	0.23	,	0.56	; 0.14	,	0.13	,	0.79	; 0.60	,	0.90	,	0.64	; 0.60	,	0.64	,	0.82	; 0.69	,	0.98	,	0.44	; 0.41	,	0.97	,	0.37	; 0.07	,	0.86	,	0.28	; 0.76	,	0.07	,	0.55	; 0.38	,	0.63	,	0.50	; 0.51	,	1.00	,	0.91	; 0.55	,	0.89	,	0.69	; 0.30	,	0.11	,	0.97	; 0.18	,	0.84	,	0.17	; 0.28	,	0.57	,	0.23	; 1.00	,	0.60	,	0.83	; 0.14	,	0.93	,	0.23	; 0.16	,	0.50	,	0.21	; 0.14	,	0.81	,	0.03	; 0.73	,	0.56	,	0.60	; 0.37	,	0.80	,	0.72	; 0.33	,	0.69	,	0.03	; 0.97	,	0.36	,	0.01	; 0.21	,	0.60	,	0.54	; 0.13	,	0.30	,	0.27	; 0.75	,	0.86	,	0.18	; 0.60	,	0.65	,	0.54	; 0.07	,	0.76	,	0.04	; 0.10	,	0.38	,	0.68	; 0.87	,	0.45	,	0.25	; 0.68	,	0.85	,	0.73	; 0.62	,	0.72	,	0.15	; 0.06	,	0.62	,	0.04	; 0.85	,	0.19	,	0.09	; 0.61	,	0.90	,	0.98	; 0.57	,	0.01	,	0.21	; 0.16	,	0.46	,	0.89	; 0.29	,	0.57	,	0.88	; 0.02	,	0.43	,	0.34	; 0.98	,	0.78	,	0.95	; 0.86	,	0.69	,	0.13	; 0.38	,	0.65	,	0.29	; 0.71	,	0.72	,	0.84	; 0.35	,	0.35	,	0.10	; 0.94	,	0.58	,	0.58	; 0.07	,	0.67	,	0.98	; 0.77	,	0.33	,	0.86	; 0.17	,	0.94	,	0.00	; 0.98	,	0.39	,	0.30	; 0.16	,	0.58	,	0.90	; 0.98	,	0.02	,	0.98	; 0.31	,	0.57	,	0.02	; 0.55	,	0.33	,	0.12	; 0.27	,	0.13	,	0.45	; 0.39	,	0.72	,	0.65	; 0.91	,	0.63	,	0.78	; 0.49	,	0.74	,	0.79	; 0.45	,	0.91	,	0.62	; 0.44	,	0.08	,	0.43	; 0.13	,	0.27	,	0.66	; 0.14	,	0.61	,	0.02	; 0.35	,	0.23	,	0.60	; 0.10	,	0.14	,	0.89	; 0.43	,	0.51	,	0.43	; 0.41	,	0.47	,	0.18	; 0.73	,	0.62	,	0.56	; 0.91	,	0.52	,	0.17	; 0.91	,	0.31	,	0.99	; 0.50	,	0.54	,	0.58	; 0.36	,	0.04	,	0.83	; 0.83	,	0.98	,	0.15	; 0.93	,	0.67	,	0.60	; 0.94	,	0.94	,	0.70	; 0.81	,	0.82	,	0.14	; 0.88	,	0.58	,	0.87	; 0.82	,	0.47	,	0.64	; 0.08	,	0.76	,	0.15	; 0.70	,	0.04	,	0.25	; 0.52	,	0.59	,	0.68	; 0.33	,	0.25	,	0.59	; 0.91	,	0.56	,	0.66	; 0.79	,	0.74	,	0.34	; 0.94	,	0.29	,	0.33	; 0.33	,	0.80	,	0.69	; 0.64	,	0.50	,	0.53	; 0.33	,	0.25	,	0.23	; 0.11	,	0.02	,	0.24	; 0.02	,	0.43	,	0.36	; 0.65	,	0.27	,	0.38	; 0.76	,	0.85	,	0.45	; 0.48	,	0.93	,	0.96	; 0.47	,	0.27	,	0.18	; 0.02	,	0.47	,	0.41	; 0.53	,	0.46	,	0.08	; 0.33	,	0.48	,	0.13	; 0.18	,	0.79	,	0.25	; 0.36	,	0.88	,	0.47	; 0.06	,	0.36	,	0.65	; 0.64	,	0.82	,	0.74	; 0.52	,	0.24	,	0.64	; 0.88	,	0.16	,	0.55	; 0.43	,	0.39	,	0.86	; 0.23	,	0.51	,	0.69	; 0.33	,	0.03	,	0.41	; 0.74	,	0.35	,	0.52	; 0.08	,	0.18	,	0.97	; 0.74	,	0.54	,	0.64	; 0.06	,	0.68	,	0.58	; 0.55	,	0.80	,	0.80	; 0.11	,	0.45	,	0.20	; 0.05	,	0.96	,	0.60	; 0.82	,	0.35	,	0.52	; 0.68	,	0.27	,	0.26	; 0.93	,	0.78	,	0.26	; 0.33	,	0.16	,	0.31	; 0.51	,	0.19	,	0.59	; 0.77	,	0.29	,	0.62	; 0.88	,	0.57	,	0.81	; 0.15	,	0.72	,	0.38	; 0.55	,	0.59	,	0.64	; 0.44	,	0.89	,	0.24	; 0.05	,	0.74	,	0.55	; 0.70	,	0.12	,	0.01	; 0.30	,	0.60	,	0.29	; 0.18	,	0.57	,	0.55	; 0.38	,	0.38	,	0.85	; 0.10	,	0.78	,	0.17	; 0.96	,	0.04	,	0.41	; 0.15	,	0.91	,	0.35	; 0.56	,	0.87	,	0.99	; 0.40	,	0.02	,	0.10	; 0.81	,	0.85	,	0.30	; 0.92	,	0.14	,	0.47	; 0.69	,	0.71	,	0.83	; 0.43	,	0.44	,	0.99	; 0.46	,	0.38	,	0.13	; 0.04	,	0.99	,	0.88	; 0.79	,	0.87	,	0.07	; 0.10	,	0.94	,	0.97	; 0.75	,	0.32	,	0.60	; 0.26	,	0.39	,	0.81	; 0.17	,	0.88	,	0.60	; 0.86	,	0.09	,	0.18	; 0.51	,	0.50	,	0.47	; 0.22	,	0.18	,	0.70	; 0.16	,	0.15	,	0.97	; 0.71	,	0.32	,	0.51	; 0.83	,	0.89	,	0.75	; 0.24	,	0.29	,	0.39	; 0.04	,	0.73	,	0.10	; 0.38	,	0.46	,	0.63	; 0.92	,	0.55	,	0.06	; 0.80	,	0.80	,	0.77	; 0.59	,	0.21	,	0.01	; 0.63	,	0.30	,	0.76	; 0.64	,	0.54	,	0.48	; 0.93	,	0.83	,	0.30	; 0.01	,	0.10	,	0.48	; 0.11	,	0.74	,	0.30	; 0.19	,	0.57	,	0.48	; 0.80	,	0.34	,	0.45	; 0.48	,	0.02	,	0.88	; 0.06	,	0.77	,	0.18	; 0.75	,	0.15	,	0.81	; 0.37	,	0.61	,	0.80	; 0.75	,	0.33	,	0.50	; 0.79	,	0.08	,	0.76	; 0.09	,	0.60	,	0.99	; 0.88	,	0.44	,	0.39	; 0.66	,	0.04	,	0.39	; 0.75	,	0.03	,	0.93	; 0.03	,	0.64	,	0.56	; 0.99	,	0.76	,	0.34	; 0.41	,	0.36	,	0.67	; 0.64	,	0.12	,	0.50	; 0.66	,	0.38	,	0.46	; 0.94	,	0.56	,	0.43	; 0.36	,	0.44	,	0.32	; 0.70	,	0.96	,	0.64	; 0.88	,	0.22	,	0.28	; 0.33	,	0.83	,	0.81	; 0.78	,	0.14	,	1.00	; 0.43	,	0.91	,	0.06	; 0.61	,	0.99	,	0.87	; 0.72	,	0.40	,	0.28	; 0.50	,	0.12	,	0.93	; 0.83	,	0.34	,	0.06	; 0.91	,	0.95	,	0.21	; 0.76	,	0.26	,	0.24	; 0.94	,	0.44	,	0.25	; 0.14	,	0.64	,	0.63	; 0.34	,	0.16	,	0.16	; 0.99	,	0.65	,	0.73	; 0.56	,	0.46	,	0.35	; 0.99	,	0.42	,	0.27	; 0.63	,	0.56	,	0.92	; 0.57	,	0.40	,	0.56	; 0.83	,	0.27	,	0.51	; 0.41	,	0.07	,	0.63	; 0.09	,	0.23	,	0.22	; 0.71	,	0.13	,	0.35	; 0.83	,	0.78	,	0.09	; 0.10	,	0.29	,	0.36	; 0.01	,	0.43	,	0.84	; 0.45	,	0.09	,	0.58	; 0.67	,	0.37	,	0.29	; 0.18	,	0.35	,	0.75	; 0.98	,	0.12	,	0.61	; 0.55	,	0.29	,	1.00	; 0.95	,	0.67	,	0.51	; 0.25	,	0.97	,	0.21	; 0.12	,	0.27	,	0.44	; 0.27	,	0.47	,	0.45	; 0.86	,	0.36	,	0.72	; 0.93	,	0.81	,	0.86	; 0.06	,	0.77	,	0.13	; 0.66	,	0.58	,	0.70	; 0.11	,	0.86	,	0.86	; 0.96	,	0.37	,	0.91	; 0.81	,	0.86	,	0.61	; 0.36	,	0.25	,	0.18	; 0.46	,	0.88	,	0.76	; 0.04	,	0.14	,	0.28	; 0.82	,	0.11	,	0.21	; 0.67	,	1.00	,	0.24	; 0.39	,	0.99	,	0.54	; 0.47	,	0.75	,	0.70	; 0.21	,	0.68	,	0.85	; 0.48	,	0.93	,	0.18	; 0.31	,	0.38	,	0.17	; 0.01	,	0.66	,	0.43	; 0.90	,	0.18	,	0.71	; 0.64	,	0.56	,	0.56	; 0.23	,	0.75	,	0.12	; 0.15	,	0.19	,	0.68	; 0.12	,	0.13	,	0.64	; 0.45	,	0.49	,	0.53	; 0.22	,	0.55	,	0.98	; 0.67	,	0.06	,	0.29	; 0.76	,	0.96	,	0.65	; 0.23	,	0.37	,	0.23	; 0.28	,	0.69	,	0.90	; 0.11	,	0.44	,	0.14	; 0.31	,	0.58	,	0.57	; 0.70	,	0.20	,	0.85	; 0.00	,	0.21	,	0.67	; 0.88	,	0.04	,	0.97	; 0.62	,	0.83	,	0.49	; 0.20	,	0.72	,	0.17	; 0.52	,	0.32	,	0.58	; 0.70	,	0.18	,	0.11	; 0.26	,	0.02	,	0.20	; 0.03	,	0.28	,	0.20	; 0.95	,	0.83	,	0.11	; 0.40	,	0.76	,	0.62];
coloredLabels = label2rgb (labeledImage, cm); % pseudo random color labels
% coloredLabels is an RGB image.  We could have applied a colormap instead (but only with R2014b and later)
subplot(1, 3, 2);
imshow(coloredLabels);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
caption = sprintf('Pseudo colored labels, from label2rgb().');
title(caption, 'FontSize', captionFontSize);

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
subplot(1, 3, 3);
imshow(originalImage);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize); 
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(originalImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

% Loop over all blobs printing their measurements to the command window.
array_inseln = zeros(numberOfBlobs-1,2);
for k = 1 : numberOfBlobs
	blobArea = blobMeasurements(k).Area;
    if k > 1 
        array_inseln(k-1,1) = k;
        array_inseln(k-1,2) = blobArea;
    end 
end

%% 2. Hinterschnitte - Teil 1 

for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end 
    end
end 

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end 
    end
end 


    for i=1:height
        for j=1:width
            if labeledImage_materialIslands(i,j) == 96661
                firstStepImage(i,j) = 1; 
            end
            if labeledImage_pores(i,j) == 78887
                firstStepImage(i,j) = 0; 
            end
        end
    end
    
 
 %% 2. Hinterschnitte - Teil 2
   
  count = 0;  
  k = 0; 
  w =0;
  h = 0; 
  iZeile = 0;
  zWerte = zeros(10000,2);
  
    for i = 1:10000
       iZeile = i + count; 
       zWerte(iZeile,2) = i;
       for j= 1:height
          if thirdStepImage(j,i) == 1
             zWerte(iZeile,1) = j;
                % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
                % vorliegen könnte (also die Höhendifferenz größer als 1
                % ist)
                if i > 1 
                     % Höhenwert des aktuellen Pixel
                     a = zWerte(iZeile,1);
                     % Höhenwert des vorherigen Pixel
                     b = zWerte(iZeile-1,1); 
                     % wenn die Höhendifferenz > 1 ist 
                     
                     % rechte Seite des Tals, nach oben gehend)
                     if (b - a) > 1 
                         k = 0;
                        %zusätzlich den vorherigen Pixel schreiben (gleiche
                        % x-Koordinate wie vorheriger Pixel, gleiche
                        % y-Koordinate wie aktueller Pixel
                        % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                        % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                        % zukünftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                        
                        % aktueller Pixel wird zu i+1, damit der
                        % zwischengeschobene Pixel i sein kann
                        zWerte(iZeile+1,1) = j; 
                        zWerte(iZeile+1,2) = i + k; 
%                         zWerte(iZeile,2) = zWerte(iZeile-1,2) + k; 
%                         zWerte(iZeile,1) = j; 
                        
                        % die dazwischenliegenden Pixel müssen ebenfalls
                        % eingezeichnet werden (zwischen den Höhen a und b)                       
                        c=1;                       
                        for z=abs(b-a):-1:1
    %                         for z=1:abs(b-a)
                                zWerte(iZeile+1+c,2) = i + k;
                                if (b-a) < 0 
                                    zWerte(iZeile+1+c,1) = j - z; 
                                else
                                    zWerte(iZeile+1+c,1) = j + z; 
                                end
                                count = count + 1;
                           c = c + 1;
                        end
                        
                        % nochmal den ersten Pixel einfuegen
                        zWerte(iZeile+1+c,1) = j; 
                        zWerte(iZeile+1+c,2) = i + 1 + k;                         
                        % i-Zaehler um 1 erhoehen, da ein zusätzliches
                        % Pixel in die Liste aufgenommen wurde. Ansonsten
                        % würde man beim nächsten Durchlauf den letzten
                        % Pixel überschreiben. 
                        count = count + 1; 
                     end     
                     
                     % linke Seite des Tals, nach unten gehend 
                        if (b - a) < (-1) 
                             k = 0;
                         %zusätzlich den vorherigen Pixel schreiben (gleiche
                        % x-Koordinate wie vorheriger Pixel, gleiche
                        % y-Koordinate wie aktueller Pixel
                        % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                        % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                        % zukünftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                        
                        % aktueller Pixel wird zu i+1, damit der
                        % zwischengeschobene Pixel i sein kann
                        zWerte(iZeile+1,1) = j; 
                        zWerte(iZeile+1,2) = i + 1 + k; 
                        zWerte(iZeile,2) = zWerte(iZeile-1,2) + 1 + k; 
                        zWerte(iZeile,1) = j; 
                        
                        % die dazwischenliegenden Pixel müssen ebenfalls
                        % eingezeichnet werden (zwischen den Höhen a und b)                       
                        c=1;                       
                        for z=abs(b-a):-1:1
    %                         for z=1:abs(b-a)
                                zWerte(iZeile+1+c,2) = i + k;
                                if (b-a) < 0 
                                    zWerte(iZeile+1+c,1) = j - z; 
                                else
                                    zWerte(iZeile+1+c,1) = j + z; 
                                end
                                count = count + 1;
                           c = c + 1;
                        end
                        
                        % nochmal den ersten Pixel einfuegen
                        zWerte(iZeile+1+c,1) = j; 
                        zWerte(iZeile+1+c,2) = i + 1 + k; 
                        % i-Zaehler um 1 erhoehen, da ein zusätzliches
                        % Pixel in die Liste aufgenommen wurde. Ansonsten
                        % würde man beim nächsten Durchlauf den letzten
                        % Pixel überschreiben. 
                        count = count + 2; 
                     end   
                     
                end
             break;
          end
       end
       % Wenn Bildbreite erreicht, For-Schleife beenden
       if iZeile - count >= width - 1
           break
       end
    end

    % nur den Bildbereich weiterverwenden, der in der vorangestellten
    % Schleife beschrieben wurde. 
    zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

%% 4. Einbuchtungen

faktor = str2double(get(handles.AnzahlUnterteilungenText,'String')); 
% aufteilung = ceil(width/faktor);
aufteilung = width/faktor;

boundary = realeKontur(ForthStepImage);
FifthStepImage = ForthStepImage; 
letzteZeile = 0;
for j=1:faktor
    % letzten Punkt in boundary() ermitteln, der zur aktuellen Section
    % gehört
    letzteZeileVorher = letzteZeile + 1; 
    letzteZeileaktuell = aufteilung*10 + letzteZeileVorher;
    endeSection = round(j*aufteilung);
    for i=letzteZeileVorher:letzteZeileaktuell
        if boundary(i,2) >= endeSection
            letzteZeile = i; 
            break; 
        end 
    end 
    % Finden des jeweiligen Maximums, eintragen dessen Koordinaten in Array
    a = letzteZeileVorher;
    b = letzteZeile;
    MaxSection = min(boundary(a:b,1)); 
    MinSection = max(boundary(a:b,1)); 
    punktLinie = MaxSection  - 1;
    %horizontale Linie zeichnen
    for d=round(((j-1)*aufteilung + 1)):round((j*aufteilung))
        FifthStepImage(punktLinie,d) = 1; 
    end 
    %senkrechte Linie nach unten ziehen
    abstand = MinSection-punktLinie;
    if j>1
        for i=0:(abstand)
            FifthStepImage(punktLinie + i,round(j*aufteilung)) = 1; 
            FifthStepImage(punktLinie + i,round((j-1)*aufteilung)) = 1; 
        end 
    end  
end 

figure;
imshow(FifthStepImage);

%% 5. Fläche hinter Hinterschnitten

war eigentlich nur ein Zusammenbauen von anderen Funktionen - nichts neues hinzugekommen. 


function Pore = poresColor(in1)

format long g;
format compact;
captionFontSize = 14;


if in1 == 1 
    criteria = 'pores';
else
    criteria = 'matInseln';
end 

global imgErod; 

% Read in a standard MATLAB demo image of coins (US nickles and dimes, which are 5 cent and 10 cent coins)

originalImage = handles.imgErod;

% baseFileName = 'coins.png';
% folder = fileparts(which(baseFileName)); % Determine where demo folder is (works with all versions).
% fullFileName = fullfile(folder, baseFileName);
% originalImage = imread(fullFileName);

% change of some values in binary image in case of pores: 
if isequal(criteria ,'pores')
    [height,width] = size(originalImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if originalImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0; 
            end
            if originalImage(a_1, a_2) == 0 
                array_merk_pores(a_1, a_2) = 1; 
            end
        end
    end
    originalImage = array_merk_pores;
end

% Identify pores/material islands by seeing which pixels are connected to each other.
% Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
% Do connected components labeling with either bwlabel() or bwconncomp().
labeledImage = bwlabel(originalImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
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

sort_array_inseln = sortrows(array_inseln,2,'descend');

% image that shows colored pores/material islands
%__________________________________________
figure;
imshow(coloredLabels);        
linevalue = 1500;
hold on
p1 = [linevalue,1];
p2 = [linevalue,width];
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','b','LineWidth',5)
%__________________________________________

message = sprintf('Do you want to save the pseudo-colored image?');
reply = questdlg(message, 'Save image?', 'Yes', 'No', 'No');
% Note: reply will = '' for Upper right X, 'Yes' for Yes, and 'No' for No.
if strcmpi(reply, 'Yes')
	% Ask user for a filename.
	FilterSpec = {'*.PNG', 'PNG Images (*.png)'; '*.tif', 'TIFF images (*.tif)'; '*.*', 'All Files (*.*)'};
	DialogTitle = 'Save image file name';
	% Get the default filename.  Make sure it's in the folder where this m-file lives.
	% (If they run this file but the cd is another folder then pwd will show that folder, not this one.
	thisFile = mfilename('fullpath');
	[thisFolder, baseFileName, ext] = fileparts(thisFile);
    if isequal(criteria ,'pores')
        DefaultName = sprintf('%s_PorenMikroskopie.tif',datestr8601);
    else 
        DefaultName = sprintf('%s_MaterialinselnMikroskopie.tif',datestr8601);
    end 
	[fileName, specifiedFolder] = uiputfile(FilterSpec, DialogTitle, DefaultName);
	if fileName ~= 0
		% Parse what they actually specified.
		[folder, baseFileName, ext] = fileparts(fileName);
		% Create the full filename, making sure it has a tif filename.
		fullImageFileName = fullfile(specifiedFolder, [baseFileName '.tif']);
		% Save the labeled image as a tif image.
		imwrite(uint8(coloredLabels), fullImageFileName);
	end
end

% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
wertSubplots = ceil(sqrtBlobs);

message = sprintf('Would you like to crop out each pore/material island to individual images?');
reply = questdlg(message, 'Extract Individual Images?', 'Yes', 'No', 'Yes');
% Note: reply will = '' for Upper right X, 'Yes' for Yes, and 'No' for No.
if strcmpi(reply, 'Yes')
	figure;	% Create a new figure window.
	% Maximize the figure window.
	set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
	for k = 1:numberOfBlobs-1           % Loop through all blobs.
        currentBlob = sort_array_inseln(k,1);
		% Find the bounding box of each blob.
		thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
		% Extract out this coin into it's own image.
		subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
		% Display the image with informative caption.
		subplot(wertSubplots, wertSubplots, k);
		imshow(subImage);
        % alle subplots einzeln als Images abspeichern
		caption = sprintf('#%d, %d px', k, blobMeasurements(currentBlob).Area);
        sort_array_inseln(k,1) = k;
		title(caption, 'FontSize', textFontSize);    
	end
end

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
    if isequal(criteria ,'pores')
        DefaultName = sprintf('%s_PorenUebersicht.tif',datestr8601);
    else 
        DefaultName = sprintf('%s_MaterialinselnUebersicht.tif',datestr8601);
    end
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
    

Pore = 1;

    
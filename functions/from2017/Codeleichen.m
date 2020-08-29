%% 1

% % image that shows colored pores/material islands / blaue Linie
% %__________________________________________
% figure;
% imshow(coloredLabels);        
% linevalue = 1500;
% hold on
% p1 = [linevalue,1];
% p2 = [linevalue,width];
% plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','b','LineWidth',5)
% %__________________________________________

%% 1
% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
wertSubplots = ceil(sqrtBlobs);
textFontSize = 14;	% Used to control size of "blob number" labels put atop the image.

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

%% 1

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
        export_fig(gcf, fullImageFileName, '-r300', '-transparent')
    end
end


%% 1
% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
prozent = 0.5; 
WertInBreite = ceil(sqrtBlobs + (prozent+0.1)*sqrtBlobs);
WertInHoehe = ceil(sqrtBlobs - (prozent-0.1)*sqrtBlobs);
% wertSubplots = ceil(sqrtBlobs);
textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.

	figure;	% Create a new figure window.
	set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
	for k = 1:numberOfBlobs-1           % Loop through all blobs.
        currentBlob = sort_array_inseln(k,1);
		% Find the bounding box of each blob.
		thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
		% Extract out this coin into it's own image.
		subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
		% Display the image with informative caption.
		subplot(WertInHoehe, WertInBreite, k);
		imshow(subImage);
        % alle subplots einzeln als Images abspeichern
        [~,blobWidth] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 2}(:,:));
        [~,blobHeight] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 1}(:,:));
        formatSpec = '#%d, Fläche %d px\nBreite %d px\nHöhe %d px';
        A1 = blobMeasurements(currentBlob).Area; 
        caption = sprintf(formatSpec,k, A1,blobWidth, blobHeight);
        sort_array_inseln(k,1) = k;
		title(caption, 'FontSize', textFontSize);    
    end

 %% 1
   
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

%% 1

%% 1


%% 1


%% 1

%% 1

%% 1

%% 1

%% 1

%% 1


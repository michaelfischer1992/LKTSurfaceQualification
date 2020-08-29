clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
clearvars;
format longg;
format compact;
fontSize = 20;
% Read in a standard MATLAB color demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'peppers.png';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(rgbImage);
% Display the original color image.
subplot(2, 2, 1);
imshow(rgbImage);
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Find where the average is more than 250.
grayImage = rgb2gray(rgbImage);
% Display the image.
subplot(2, 2, 2);
imshow(grayImage);
title('Gray Image', 'FontSize', fontSize);

% Binarize (threshold) the image to find 
% where the average is brighter than some threshold value.
thresholdValue = 100; % Change to whatever value you want.
binaryImage = grayImage > thresholdValue;

% Display the image.
subplot(2, 2, 3);
imshow(binaryImage);
caption = sprintf('Binary Image = gray image > %d', thresholdValue);
title(caption, 'FontSize', fontSize);

% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
% Make binary pixels red.
redChannel(binaryImage) = 255;
greenChannel(binaryImage) = 0;
blueChannel(binaryImage) = 0;
% Get RGB image again.
newRGB = cat(3, redChannel, greenChannel, blueChannel);
% Display the image.
subplot(2, 2, 4);
imshow(newRGB);
linevalue = 250;
hold on
p1 = [linevalue,1];
p2 = [linevalue,512];
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','b','LineWidth',5)
title('New RGB Image', 'FontSize', fontSize);

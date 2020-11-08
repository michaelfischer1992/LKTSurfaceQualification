function app = selectImageAndDoFirstImageAdjustments(app)
%% selectImageAndDoFirstImageAdjustments

%% Script Description
% user selects image - works for both modes: 
%       'multiple images' and 'single image'
%
% Michael Fischer, 08.11.2020

%% Parameters
%

try
    if strcmp(app.ProgrammodeDropDown.Value, 'multiple images')
        %% first: Check, if all images in the given folder have the same size
        % --> do this, even before the user clicks on load image.
        % Load image afterwards starts automatically - the user
        % only has to "scale" and "rectangle"
        importPath = app.SeriesFolderPath.Value; 
        S = dir(fullfile(importPath, '*.jpg')); % pattern to match filenames.
        if numel(S) > 1
            %% everything alright
            disp([num2str(numel(S)), ' images found.'])
        else
            disp('no images here')
            keyboard
        end
        for k = 1:numel(S)
            info = imfinfo(fullfile(importPath,S(k).name));
            [ ~ , Imagesdata(k).name , ~ ] = fileparts(info.Filename);
            Imagesdata(k).height = info.Height;
            Imagesdata(k).width = info.Width;
            Imagesdata(k).filename = info.Filename;
        end
        S_tmp = Imagesdata;
        allImagesHeight = vertcat(Imagesdata(:).height);
        allImagesWidth = vertcat(Imagesdata(:).width);
        if length(unique([allImagesHeight, allImagesWidth])) == 2
            disp('all images the same')
        else
            [idxOmitted1] = throwOutImagesWithDifferentAspectRatio(app, allImagesWidth, S_tmp);
            [idxOmitted2] = throwOutImagesWithDifferentAspectRatio(app, allImagesHeight, S_tmp);
            idxOmitted = and(~idxOmitted1, ~idxOmitted2);
            S_tmp = S_tmp(idxOmitted);
        end
        disp([num2str(numel(S_tmp)), ' images remaining.'])
        %% read first image with scale bar
        message = ('Select your start image. IMPORTANT: The image has to show a scale!');
        msgbox(message, 'Important Notice','warn');
        app = userSelectsImageInExplorer(app);
        app.Data.ImagesData = S_tmp;
    else
        app = userSelectsImageInExplorer(app);
    end
    %% load image
    imgPath = [app.Data.BildPfad app.Data.BildNamePlusExtention];
    app.Data.imgOriginal = imread(imgPath);
    %% scale image down
    if strcmp(app.FastModeDropdown.Value, 'fast')
        scaleDownFactor = app.ConfigParams.maxSizeOfImage / (size(app.Data.imgOriginal, 2) * size(app.Data.imgOriginal, 1));
    elseif strcmp(app.FastModeDropdown.Value, 'normal')
        scaleDownFactor = 1;
    end
    app.Data.imgOriginal = imresize(app.Data.imgOriginal, scaleDownFactor);
    %% plot original image
    plotImageWindowsized(app.Data.imgOriginal)
    %% plot figure into GUI
    %     showFigureInGUI(app)
    %% let user draw two points to get the scale bar
    [app.Data.MassstabXVals, app.Data.MassstabYVals] = getScaleValues(app);
catch
    disp('no image selected.')
end
end



%% userSelectsImageInExplorer
function app = userSelectsImageInExplorer(app)
[FileName, PathName]  = uigetfile(  ...
    {'*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.psd',...
    'picture Files (*.jpg,*.jpeg,*.png,*.tif,*.tiff,*.psd)';
    '*.jpg;*.jpeg',  'jpg files (*.jpg,*.jpeg)'; ...
    '*.png',  'png files (*.png)'; ...
    '*.*',  'All Files (*.*)'}, 'Bitte wählen Sie ein Mikroskopiebild aus', app.ImportpathEditField.Value);
filename = [PathName, FileName];
[pathstr, name, ext] = fileparts(filename);
if isequal(FileName,0)
    disp('User selected Cancel')
else
    disp(['User selected ', filename])
end
app.Data.BildPfad = [pathstr '\'];
app.Data.BildName = name;
app.Data.BildNamePlusExtention = [name, ext];
end

%% throwOutImagesWithDifferenAspectRation
function [idxOmitted] = throwOutImagesWithDifferentAspectRatio(app, HorW, S_tmp)
disp('the following images have a different aspect ratio and are therefore omitted: ')
[~,~,ix1] = unique(HorW(:, 1));
if nnz(ix1 == 1) > 0.6*numel(S_tmp)
    idx1 = ix1 == 1;
    idxOmitted = ~idx1;
    if nnz(idxOmitted) ~= 0
        disp(num2str(S_tmp(idxOmitted).name))
    end
else
    %% debug
    keyboard
end
end

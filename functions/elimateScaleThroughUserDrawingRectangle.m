function app = elimateScaleThroughUserDrawingRectangle(app)
%% elimateScaleThroughUserDrawingRectangle

%% Script Description
% user draws a rectangle around the scale and scale number, to let the
% program know the exact position. --> Very process reliable 
% Michael Fischer, 08.11.2020

%% Parameters
%

figure
[choice, imgBw_tmp, app] = userChooseScaleRectangle(app);
while choice == 2
    %% try again
    [choice, imgBw_tmp, app] = userChooseScaleRectangle(app);
end
text(200, 1800, ['Looks good!', newline, 'Thanks :)'], ...
    "FontSize", 20, "Color", '#1ba843', "FontWeight","bold")
pause(1)
close all
app.Data.imgBWnoScale = imgBw_tmp;
if app.Data.doPlot
    figure
    imshow(app.Data.imgBWnoScale)
end
%% 
%% EOF 
%%
end

%% userChooseScaleRectangle
function [choice, imgBw_tmp, app] = userChooseScaleRectangle(app)
imshow(app.Data.imgBW)
options = {'Yes','No - Try Again'};
text(200, 1800, ['Please draw a rectangle', newline, 'around the scale bar', newline, 'incl. the scale value'], ...
    "FontSize", 20, "Color", '#b02e4a', "FontWeight","bold")
imgBw_tmp = app.Data.imgBW;
try
    rect = getrect;
    rectrd = round(rect);
    app.Data.xValsRectScale = rectrd(1):(rectrd(1) + rectrd(3));
    app.Data.yValsRectScale =  rectrd(2):(rectrd(2) + rectrd(4));
    imgBw_tmp(app.Data.yValsRectScale, app.Data.xValsRectScale) = 1;
    imshow(imgBw_tmp)
catch
    message = sprintf('Please draw the rectangle inside the figure.');
    msgbox(message, 'Scale Removal failed', 'error');
end
delete(findall(gcf,'type','text'))
choice = menu('Was the scale removed successfully?', options);
%% 
%% EOF 
%%
end

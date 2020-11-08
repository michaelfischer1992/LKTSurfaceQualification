

function [x, y] = getScaleValues(app)
%% getScaleValues

%% Script Description
% user has to select the margins of scale --> very process reliable
% Michael Fischer, 08.11.2020

%% Parameters
%

[choice, x, y] = letUserDrawEdgesOfScale(app);
while choice == 2
    %% try again
    [choice, x, y] = letUserDrawEdgesOfScale(app);
end
delete(findall(gcf,'type','text'))
text(200, 1800, ['Looks good!', newline, 'Thanks :)'], ...
    "FontSize", 20, "Color", '#1ba843', "FontWeight","bold")
pause(1)
close all
end
%% 
%% EOF 
%%

%% letUserDrawEdgesOfScale
function [choice, x, y] = letUserDrawEdgesOfScale(app)
delete(findall(gcf,'type','text'))
delete(findall(gcf,'type','line'))
text(200, 1800, ['Please make two points on each side of scale bar. ', newline, 'Make second point by double-click'], ...
    "FontSize", 20, "Color", '#b02e4a', "FontWeight","bold")
[x,y] = getpts;
% loop to check if it's two points that were selected
while length(x) ~= 2
    warning('You have to select two points!')
    [x,y] = getpts;
end
hold on
% draw marker crosses in image
scaleVerification = drawPoint(x,y);
set(scaleVerification, ...
    'marker'          , '+'         , ...
    'MarkerSize'      , 50           , ...
    'Color' , '#bf4204'      , ...
    'MarkerEdgeColor' , '#bf4204'      , ...
    'DisplayName' , 'Legend Entry'      , ...
    'MarkerFaceColor' , '#bf4204'  );
options = {'Yes','No - Try Again'};
choice = menu('Are the points laying nicely on both ends of the scale bar?', options);
end
%% 
%% EOF 
%%


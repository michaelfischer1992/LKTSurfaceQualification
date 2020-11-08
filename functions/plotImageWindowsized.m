function plotImageWindowsized(image)
%% plotImageWindowsized

%% Script Description
% just a quick function to plot an image Window-sized (additonally add
% export function
% Michael Fischer, 08.11.2020

%% Parameters
%

hfig = figure('units','normalized','outerposition',[0 0 1 1]); 
set(hfig, 'WindowState', 'maximized', 'InvertHardCopy', 'off');
imshow(image)
ax = gca;
ax.Clipping = 'off';    % turn clipping off

% set(gcf, 'Position', get(0, 'Screensize'));
set(gcf, 'WindowState', 'maximized', 'InvertHardCopy', 'off');
end
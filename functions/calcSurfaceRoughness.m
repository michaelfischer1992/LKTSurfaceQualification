function [roughnessImage] = calcSurfaceRoughness(handles, undercutsEliminated)
[width] = size(undercutsEliminated, 2);
faktor = handles.SurfaceRoughnessSections;
aufteilung = width/faktor;
boundary = realeKontur(~undercutsEliminated);
roughnessImage = ~undercutsEliminated;
faktorArray = round(linspace(1,width,aufteilung));
[~, ab, ~] = intersect(boundary(:, 2), faktorArray);
for i = 1 : length(ab) - 1
    MinSection = max(boundary(ab(i):ab(i+1),1));
    MaxSection = min(boundary(ab(i):ab(i+1),1));
    punktLinie = MaxSection - 2; % 1-pixel Abstand zum Max.
    roughnessImage(punktLinie, faktorArray(i):faktorArray(i+1)) = 1;
    roughnessImage(punktLinie:(MinSection + 1), faktorArray(i+1)) = 1;
    roughnessImage(punktLinie:(MinSection + 1), faktorArray(i)) = 1;
end
if handles.doPlot
    figure
    imshow(roughnessImage)
    hold on
    lineCam2Helio = drawPoint(boundary(:,2), boundary(:,1));
    set(lineCam2Helio, ...
        'Color'         ,   '#bf4204', ...
        'LineWidth'     ,    2       , ...
        'LineStyle'     ,   '-'      ,...
        'marker'          , 'o'         , ...
        'MarkerSize'      , .5           , ...
        'Color' , '#bf4204'      , ...
        'MarkerEdgeColor' , '#bf4204'      , ...
        'DisplayName' , 'Legend Entry'      , ...
        'MarkerFaceColor' , '#bf4204'  );
end
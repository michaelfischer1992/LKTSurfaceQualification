function app = alignImageHorizontally(app)
%% alignImageHorizontally

%% Script Description
% 
% Michael Fischer, 08.11.2020

%% Parameters
%

% 
boundary = realeKontur(app.Data.imgEroded);
width = app.Data.imageWidth;
height = app.Data.imageHeight;
Start(1,2) = 1;
Start(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Start(1,2));
Ende(1,2) = width;
Ende(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Ende(1,2));
diffLR = Ende(1,1)-Start(1,1); % Unterschied der y-Komponenten
winkel = atand(diffLR/(width/2));
imgBWDreh = imrotate(app.Data.imgEroded,winkel,'nearest','crop');
imgOrigDreh = imrotate(app.Data.imgOriginal, winkel,'nearest','crop');
%% cut off black lines at corners. ceil: so don't cut off too less
linkeGrenze=abs(ceil(height/2 * diffLR/(width/2)));
if linkeGrenze <= 0
    linkeGrenze = 1;
end
rechteGrenze=width-floor(height/2 * diffLR/(width/2));
if rechteGrenze >= width
    rechteGrenze = width-1;
end
untereGrenze = ceil(height * tan(deg2rad(winkel)));
imgBWSchnitt = imgBWDreh(1:(height - abs(untereGrenze)), linkeGrenze:rechteGrenze);
imgOrigSchnitt = imgOrigDreh(:,linkeGrenze:rechteGrenze);
app.Data.imgErod = imgBWSchnitt;
app.Data.imgOrig = imgOrigSchnitt;

%% usually there wouldn't be a pore now in the lower left corner.
[height, ~, ~] = size(app.Data.imgErod);
for i = height : -1 : 1
    if app.Data.imgErod(i,1) == 0
        continue
    else
        lastLine = i + 1;
        break
    end
end
for i = 1 : size(app.Data.imgErod,2)
    if app.Data.imgErod(height,i) == 0
        continue
    else
        lastRow = i;
        break
    end
end
app.Data.imgErod(lastLine:height, 1:lastRow) = 1;

%% if the first 40 pixels are all black, then it's surely no pore
if nnz(app.Data.imgErod(height,1:app.Data.pixelsWidthCheckIfPore)) == 0
    %% crop the image up to 'lastLine'
    imgBWSchnittSecond = imgBWSchnitt(1 : lastLine, :);
    app.Data.imgErod = imgBWSchnittSecond;
    imgOrigSchnittSecond = imgOrigSchnitt(1 : lastLine, :);
    app.Data.imgOrig = imgOrigSchnittSecond;
end
end
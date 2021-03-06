function app = plotContoursInImage(app)
%% plotContoursInImage

%% Script Description
%
% Michael Fischer, 08.11.2020

%% Parameters
%

Massstab = app.Data.MassstabWert;
img = app.Data.imgErod;
boundary = realeKontur(img);
[heightBoundary,~] = size(boundary);
[height,width,~] = size(img);

% calculate length of real contour
laengeOberfl=0;
for i =2:heightBoundary
    laengeOberfl = laengeOberfl + sqrt((boundary(i,1)-boundary(i-1,1))^2 + (boundary(i,2)-boundary(i-1,2))^2);
end
app.Data.realeKonturY = boundary(:,1);
app.Data.realeKonturX = boundary(:,2);
disp(['real contour length: ', num2str(round(laengeOberfl*Massstab)), ' µm / ', ...
    num2str(laengeOberfl), ' px.']);
disp(['picture width: ', num2str(round(width*Massstab)), ' µm / ', ...
    num2str(width), ' px.']);
disp(['ratio: ', num2str(round(laengeOberfl/width, 1))]);

%% calculate top view surface
count = 0;
iZeile = 0;
zWerte = zeros(width*5,2);
for i = 1:(width*5)
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if img(j,i) == 1
            zWerte(iZeile,1) = j;
            if i > 1
                a = zWerte(iZeile,1);
                b = zWerte(iZeile-1,1);
                if abs(b - a) > 1
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2);
                    zWerte(iZeile,1) = j;
                    count = count + 1;
                end
            end
            break;
        end
    end
    if iZeile - count >= width - 1
        break
    end
end

zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];
app.Data.aufKontur = zWerte;
Mittel = mean2(app.Data.realeKonturY); % Bild bereits ausgerichtet, deshalb Mittelwertberechnung nun trivial

if app.Data.doPlot
    figure
    imshow(app.Data.imgErod);
    hold on;
    plot(app.Data.realeKonturX, app.Data.realeKonturY, 'g', 'Linewidth', 2);
    plot(app.Data.aufKontur(:,2), app.Data.aufKontur(:,1),'r','Linewidth',2);
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
    
    app.Data.hfig = imshow(app.Data.imgOrig);
    hold on;
    plot(app.Data.realeKonturX, app.Data.realeKonturY, 'g', 'Linewidth', 2);
    plot(app.Data.aufKontur(:,2), app.Data.aufKontur(:,1),'r','Linewidth',2);
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
    ax = gca;
    ax.Clipping = 'off';
end

% imshow(app.Data.imgOrig, 'Parent', app.Data.UIAxes_2);
% hold(app.Data.UIAxes_2,'on')
% plot(app.Data.realeKonturX, app.Data.realeKonturY, 'g', 'Linewidth', 2, 'Parent', app.Data.UIAxes_2); % g: gruen; Linewidth: 2 Pixel (breite Linie)
% plot(app.Data.aufKontur(:,2), app.Data.aufKontur(:,1),'r','Linewidth',2, 'Parent', app.Data.UIAxes_2);
% plot([1 width],[Mittel Mittel],'b','Linewidth', 2, 'Parent', app.Data.UIAxes_2);
% hold(app.Data.UIAxes_2,'off')
% set(app.Data.CalculateButton, 'BackgroundColor', 'green');
end

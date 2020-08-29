function varargout = SLS_Oberflaechenrauheit_final(varargin)
% Michael Fischer, letzte Editierung 14/08/2017
gui_Singleton = 1;
addpath('C:\Users\micha\Desktop\Oberflaechenrauheit-LKT\V09_final\gui_pics'); 
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SLS_Oberflaechenrauheit_final_OpeningFcn, ...
                   'gui_OutputFcn',  @SLS_Oberflaechenrauheit_final_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function SLS_Oberflaechenrauheit_final_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
%% setting parameters 
%% related to image
handles.BildPfad = 0;
handles.BildName = 0;
handles.BildNamePlusExtention = 0;
handles.imgBW = 0;
handles.imgEroded = 0;
handles.imgErod = 0; % ausgerichtetes Erodiertes Bild
handles.imgOriginal = 0;
handles.imgOrig = 0; % ausgerichtetes Originalbild
%% surface 
handles.realeKonturX = 0;
handles.realeKonturY = 0;
handles.aufKontur = 0;
handles.FlaecheHinterschneidung = 0;
handles.Pz_Wert = 0;
%% scale
handles.MassstabLinksPosX = 0;
handles.MassstabLinksPosY = 0;
handles.MassstabRechtsPosX = 0;
handles.MassstabRechtsPosY = 0;
handles.MassstabWert = 1;
handles.MassstabEinheit = 'px';
%% 
handles.hfig = 0;
handles.scaleResolution = 0;
handles.ExcelKennwerte = 0;
handles.ExcelDaten = 0;
handles.AnzahlErzeugteDateien = 1;
handles.ErzeugteDateien = string(zeros(100,2));
%% Colors
handles.gruen=[0.78 0.88 0.58];
handles.hellgruen=[0.73	0.88	0.48];
handles.dunkelrot=[0.64	0.08	0.18];
handles.hellrot=[0.93	0.41	0.50];
handles.grau=[0.50	0.50	0.50];
handles.schwarz=[0	0	0];
handles.rosa=[1.00	0.80	0.80];
handles.ZaehlerBerechneteKennwerte = 0;
guidata(hObject, handles);
pause('off');
function varargout = SLS_Oberflaechenrauheit_final_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function BreiteBildText_Callback(hObject, eventdata, handles)
function BreiteBildText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function LaengeOberflaecheText_Callback(hObject, eventdata, handles)
function LaengeOberflaecheText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function FlaecheHinterschneidungText_Callback(hObject, eventdata, handles)
function FlaecheHinterschneidungText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function PzWertText_Callback(hObject, eventdata, handles)
function PzWertText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function BreiteBildEinheitText_Callback(hObject, eventdata, handles)
function BreiteBildEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function LaengeOberflaecheEinheitText_Callback(hObject, eventdata, handles)
function LaengeOberflaecheEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function FlaecheHinterschneidungEinheitText_Callback(hObject, eventdata, handles)
function FlaecheHinterschneidungEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function PzWertEinheitText_Callback(hObject, eventdata, handles)
function PzWertEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MinFlaechePorenText_Callback(hObject, eventdata, handles)
function MinFlaechePorenText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function EntfernungPorenText_Callback(hObject, eventdata, handles)
function EntfernungPorenText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function FlaechePorenEinheitText_Callback(hObject, eventdata, handles)
function FlaechePorenEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function EntfernungPorenEinheitText_Callback(hObject, eventdata, handles)
function EntfernungPorenEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MassstabText_Callback(hObject, eventdata, handles)
function MassstabText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function EinheitMassstabPopUp_Callback(hObject, eventdata, handles)
function EinheitMassstabPopUp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function FormGlaettungPopUp_Callback(hObject, eventdata, handles)
function FormGlaettungPopUp_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function GroesseGlaettungText_Callback(hObject, eventdata, handles)
function GroesseGlaettungText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function GlaettungButton_Callback(hObject, eventdata, handles)
img = handles.imgBW;
contents = cellstr(get(handles.FormGlaettungPopUp,'String')); % Dropdownliste in Vektor "contents" auslesen
handles.GlaettungForm = contents{get(handles.FormGlaettungPopUp,'Value')}; % akutell gewuehltes Element der Dropdownliste auswuehlen
se = strel(handles.GlaettungForm,str2double(get(handles.GroesseGlaettungText,'String'))); % Gluettungsparameter [Form, Grueuee]
handles.imgEroded = imerode(img,se);

%Vorgreifen, damit man die Bildausrichtung nicht mehr unbedingt
%durchfuehren muss
handles.imgErod = handles.imgEroded;
handles.imgOrig = handles.imgOriginal;

sr = handles.scaleResolution;
handles.hfig = imtool(handles.imgEroded,'InitialMagnification',sr);
set(handles.hfig, 'Position', get(0,'Screensize'), 'Name','3. Erodiertes Bild');
set(handles.GroesseGlaettungText,'BackgroundColor','green');
guidata(hObject,handles);
function HintergrundText_Callback(hObject, eventdata, handles)
function HintergrundText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MaterialText_Callback(hObject, eventdata, handles)
function MaterialText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function SchwellwertText_Callback(hObject, eventdata, handles)
function SchwellwertText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function BildnameText_Callback(hObject, eventdata, handles)
handles.imgOrig = imread(get(hObject, 'String'));
guidata(hObject,handles);
function BildnameText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function Bild_button1_Callback(hObject, eventdata, handles)

gruen=handles.gruen;
dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;
hellgruen=handles.hellgruen;
grau=handles.grau;
rosa=handles.rosa;
schwarz=handles.schwarz;

set(handles.uipanel38,'backgroundcolor','black')
set(handles.uipanel38,'highlightcolor','black')
set(handles.uipanel38,'shadowcolor','black')
set(handles.uipanel36,'backgroundcolor','black')
set(handles.uipanel36,'highlightcolor','black')
set(handles.uipanel36,'shadowcolor','black')
set(handles.uipanel37,'backgroundcolor','black')
set(handles.uipanel37,'highlightcolor','black')
set(handles.uipanel37,'shadowcolor','black')
set(handles.uipanel39,'backgroundcolor','black')
set(handles.uipanel39,'highlightcolor','black')
set(handles.uipanel39,'shadowcolor','black')
set(handles.uipanel40,'backgroundcolor','black')
set(handles.uipanel40,'highlightcolor','black')
set(handles.uipanel40,'shadowcolor','black')
set(handles.uipanel41,'backgroundcolor','black')
set(handles.uipanel41,'highlightcolor','black')
set(handles.uipanel41,'shadowcolor','black')
set(handles.text57,'backgroundcolor','black')
set(handles.text58,'backgroundcolor','black')
set(handles.text59,'backgroundcolor','black')
set(handles.text60,'backgroundcolor','black')
set(handles.text61,'backgroundcolor','black')
set(handles.text62,'backgroundcolor','black')
set(handles.text64,'backgroundcolor','black')
set(handles.AnzahlUnterteilungenText,'backgroundcolor','black')


set(handles.Kennwert2, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert2, 'BackgroundColor','black')
set(handles.Kennwert2, 'ForegroundColor','black')
set(handles.Kennwert3, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert3, 'BackgroundColor','black')
set(handles.Kennwert3, 'ForegroundColor','black')
set(handles.Kennwert1, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert1, 'BackgroundColor','black')
set(handles.Kennwert1, 'ForegroundColor','black')
set(handles.Kennwert5, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert5, 'BackgroundColor','black')
set(handles.Kennwert5, 'ForegroundColor','black')
set(handles.Kennwert6, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert6, 'BackgroundColor','black')
set(handles.Kennwert6, 'ForegroundColor','black')
set(handles.Kennwert4, 'string', 'Noch nicht verfuegbar!')
set(handles.Kennwert4, 'BackgroundColor','black')
set(handles.Kennwert4, 'ForegroundColor','black')
set(handles.pushbutton77, 'BackgroundColor','black')
set(handles.pushbutton77, 'ForegroundColor','black')

axes(handles.axes24)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')
axes(handles.axes25)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')
axes(handles.axes26)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')
axes(handles.axes27)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')
axes(handles.axes28)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')
axes(handles.axes29)
imshow('.\gui_pics\funktion_nicht_zur_verfuegung_v2.png')

set(handles.uipanel1,'backgroundcolor',hellgruen)
set(handles.uipanel1,'highlightcolor',grau)
set(handles.uipanel1,'shadowcolor',hellgruen)
set(handles.uipanel2,'backgroundcolor',hellgruen)
set(handles.uipanel2,'highlightcolor',grau)
set(handles.uipanel2,'shadowcolor',hellgruen)
set(handles.uipanel3,'backgroundcolor',hellgruen)
set(handles.uipanel3,'highlightcolor',grau)
set(handles.uipanel3,'shadowcolor',hellgruen)
set(handles.uipanel4,'backgroundcolor',hellgruen)
set(handles.uipanel4,'highlightcolor',grau)
set(handles.uipanel4,'shadowcolor',hellgruen)
set(handles.uipanel5,'backgroundcolor',hellgruen)
set(handles.uipanel5,'highlightcolor',grau)
set(handles.uipanel5,'shadowcolor',hellgruen)
set(handles.uipanel6,'backgroundcolor',hellgruen)
set(handles.uipanel6,'highlightcolor',grau)
set(handles.uipanel6,'shadowcolor',hellgruen)
set(handles.uipanel7,'backgroundcolor',hellgruen)
set(handles.uipanel7,'highlightcolor',grau)
set(handles.uipanel7,'shadowcolor',hellgruen)
set(handles.uipanel8,'backgroundcolor',hellgruen)
set(handles.uipanel8,'highlightcolor',grau)
set(handles.uipanel8,'shadowcolor',hellgruen)
set(handles.uipanel9,'shadowcolor',schwarz)
set(handles.uipanel9,'highlightcolor',schwarz)
set(handles.uipanel9,'backgroundcolor',schwarz)
set(handles.uipanel9,'ForegroundColor',schwarz)
set(handles.BildversionGroup,'backgroundcolor',hellgruen)
set(handles.BildversionGroup,'highlightcolor',grau)
set(handles.BildversionGroup,'shadowcolor',hellgruen)

set(handles.realKonturCheck,'backgroundcolor',hellgruen)
set(handles.aufKonturCheck,'backgroundcolor',hellgruen)
set(handles.MittellinieCheck,'backgroundcolor',hellgruen)
set(handles.origBildRadio,'backgroundcolor',hellgruen)
set(handles.SWBildRadio,'backgroundcolor',hellgruen)
set(handles.PorenHinterCheck,'backgroundcolor',hellgruen)
set(handles.PorenExportCheck,'backgroundcolor',hellgruen)

set(handles.text15,'backgroundcolor',hellgruen)
set(handles.text14,'backgroundcolor',hellgruen)
set(handles.text2,'backgroundcolor',hellgruen)
set(handles.text3,'backgroundcolor',hellgruen)
set(handles.text4,'backgroundcolor',hellgruen)
set(handles.text5,'backgroundcolor',hellgruen)
set(handles.text7,'backgroundcolor',hellgruen)
set(handles.text8,'backgroundcolor',hellgruen)
set(handles.text9,'backgroundcolor',hellgruen)
set(handles.text10,'backgroundcolor',hellgruen)
set(handles.text11,'backgroundcolor',hellgruen)
set(handles.text12,'backgroundcolor',hellgruen)
set(handles.text6,'backgroundcolor',hellgruen)
set(handles.PzWertEinheitText,'backgroundcolor',hellgruen)
set(handles.FlaecheHinterschneidungEinheitText,'backgroundcolor',hellgruen)
set(handles.LaengeOberflaecheEinheitText,'backgroundcolor',hellgruen)
set(handles.BreiteBildEinheitText,'backgroundcolor',hellgruen)
set(handles.EntfernungPorenEinheitText,'backgroundcolor',hellgruen)
set(handles.FlaechePorenEinheitText,'backgroundcolor',hellgruen)
set(handles.edit26,'backgroundcolor',hellgruen)
set(handles.text16,'backgroundcolor',hellgruen)


[FileName,PathName]  = uigetfile( ...
    {'*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.psd',...
    'picture Files (*.jpg,*.jpeg,*.png,*.tif,*.tiff,*.psd)';
    '*.jpg;*.jpeg',  'jpg files (*.jpg,*.jpeg)'; ...
    '*.png',  'png files (*.png)'; ...
    '*.*',  'All Files (*.*)'}, 'Bitte wuehlen Sie ein Mikroskopiebild aus');
filename = [PathName,FileName];
[pathstr,name,ext] = fileparts(filename);
if isequal(FileName,0)
    disp('User selected Cancel')
else
    disp(['User selected ', filename])
end
handles.BildPfad = [pathstr '\'];
handles.BildName = name;
handles.BildNamePlusExtention = [name,ext];
set(handles.BildnameText,'String',[name,ext]); %Dateiname wird in das entsprechende Feld der GUI geschrieben

guidata(hObject,handles);
function figure1_CloseRequestFcn(hObject, eventdata, handles)
if isequal(get(hObject,'waitstatus'), 'waiting')
    uiresume(hObject);
    delete(hObject);
else
    delete(hObject);
end
function origBildButton_Callback(hObject, eventdata, handles)
Bildpfad = [handles.BildPfad handles.BildNamePlusExtention]; %Strings werden aneinandergehuengt
handles.imgOriginal = imread(Bildpfad);

[height, width,~] = size(handles.imgOriginal);


%Anzeigen des Bildes
Pix_SS = get(0,'screensize');
ScreenHeight = Pix_SS(1,4);
ScreenWidth = Pix_SS(1,3);
FaktorHeight = height / ScreenHeight;
FaktorWidth = width / ScreenWidth;
if FaktorHeight > FaktorWidth
    PossibleFigureHeight = ScreenHeight - 156; %ausgemessen - so ist es an meinem PC
    handles.scaleResolution = floor(PossibleFigureHeight / height*100) -1;
else
    handles.scaleResolution = (ScreenWidth / width*100)-0.1;
end

sr = handles.scaleResolution;

handles.hfig = imtool(handles.imgOriginal,'InitialMagnification',sr);
set(handles.hfig, 'Position', get(0,'Screensize'), 'Name','1. Mikroskopiebild');
guidata(hObject,handles);
function FarbwerteButton_Callback(hObject, eventdata, handles)
[height, width,~] = size(handles.imgOriginal);
HintergrundWert =  mean2(handles.imgOriginal(5:15,(round(width/2)-5):(round(width/2)+5)));
MaterialWert = mean2(handles.imgOriginal((height-15):(height-5),(round(width/2)-5):(round(width/2)+5)));
SchwellWert = (HintergrundWert + MaterialWert)/2;

%Ausgabe der Werte in der GUI
set(handles.HintergrundText, 'String', HintergrundWert);
set(handles.MaterialText, 'String', MaterialWert);
set(handles.SchwellwertText, 'String', SchwellWert);
guidata(hObject,handles);
function swBildButton_Callback(hObject, eventdata, handles)
img = handles.imgOriginal;
schwellwert = str2double(get(handles.SchwellwertText, 'String'));

% ein RGB-BIld wird in ein gray-scale-Image ungewandelt
if size(img,3)==3
    img2 = rgb2gray(img);
else
    img2 = img;
end

imgBW = img2 > schwellwert;
handles.imgBW = imgBW;

sr = handles.scaleResolution;
handles.hfig = imtool(handles.imgBW,'InitialMagnification',sr);
set(handles.hfig, 'Position', get(0,'Screensize'), 'Name','2. Schwarz-Weiue-Bild');
guidata(hObject,handles);
function realKonturCheck_Callback(hObject, eventdata, handles)
function aufKonturCheck_Callback(hObject, eventdata, handles)
function KonturBildButton_CreateFcn(hObject, eventdata, handles)
function KonturBildButton_Callback(hObject, eventdata, handles)
h = waitbar(0,'Bild wird berechnet ...');
steps = 3;

Massstab = handles.MassstabWert;
img = handles.imgErod;

boundary = realeKontur(img);
[heightBoundary,~] = size(boundary);
[height,width,~] = size(img);

%Laenge der realen Kontur ausrechnen
laengeOberfl=0;
for i =2:heightBoundary
    %Pythagoras, Abstand der beiden Punkte
    laengeOberfl = laengeOberfl + sqrt((boundary(i,1)-boundary(i-1,1))^2 + (boundary(i,2)-boundary(i-1,2))^2);
end

%Aktualisierung der handles
handles.realeKonturY = boundary(:,1);
handles.realeKonturX = boundary(:,2);
set(handles.BreiteBildText,'String',num2str(width*Massstab));
set(handles.LaengeOberflaecheText,'String',num2str(laengeOberfl*Massstab));
set(handles.BreiteLaengeText,'String',num2str(laengeOberfl/width));

step = 1;
waitbar(step/steps);

% %     %Bestimmung der Oberflaeche durch "Aufsicht"
%     zWerte = height * ones(width,2);
%     for i = 1:(width)
%        zWerte(i,2) = i;
%        for j= 1:height
%           if img(j,i) == 1
%              zWerte(i,1) = j;
%              break;
%           end
%        end
%     end


count = 0;
k = 0;
iZeile = 0;
%Bestimmung der Oberflaeche durch "Aufsicht"
zWerte = zeros(width*5,2);
for i = 1:(width*5)
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if img(j,i) == 1
            zWerte(iZeile,1) = j;
            % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
            % vorliegen kuennte (also die Hoehendifferenz grueueer als 1
            % ist)
            if i > 1
                % Hoehenwert des aktuellen Pixel
                a = zWerte(iZeile,1);
                % Hoehenwert des vorherigen Pixel
                b = zWerte(iZeile-1,1);
                % wenn die Hoehendifferenz > 1 ist
                if abs(b - a) > 1
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2);
                    zWerte(iZeile,1) = j;
                    
                    
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 1;
                end
            end
            break;
        end
    end
    % Wenn Bildbreite erreicht, For-Schleife beenden
    if iZeile - count >= width - 1
        break
    end
end

% nur den Bildbereich weiterverwenden, der in der vorangestellten
% Schleife beschrieben wurde.
zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

%Aktualisierung der handles
handles.aufKontur = zWerte;

step = 2;
waitbar(step/steps);

blnRealeKontur = get(handles.realKonturCheck, 'value'); %Checkboxen
blnAufKontur = get(handles.aufKonturCheck, 'value');
blnMittel = get(handles.MittellinieCheck,'value');

Mittel = mean2(handles.realeKonturY); % Bild bereits ausgerichtet, deshalb Mittelwertberechnung nun trivial

if get(handles.SWBildRadio, 'Value') == 1 % welches Bild wurde ausgewuehltue
    img = handles.imgErod;
else
    img = handles.imgOrig;
end

%Bild anzeigen
sr = handles.scaleResolution;
if get(handles.SWBildRadio, 'Value') == 1
    hfig = imtool(img,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','5. Kontur');
else
    hfig = imtool(img,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','5. Kontur');
end

hold on; % Ansonsten wuerde das Bild schon fertig pruesentiert werden!
if blnRealeKontur == 1
    realeKonturY = handles.realeKonturY;
    realeKonturX = handles.realeKonturX;
    plot(realeKonturX,realeKonturY,'g','Linewidth', 2); % g: gruen; Linewidth: 2 Pixel (breite Linie)
end
if blnAufKontur == 1
    aufKontur = handles.aufKontur;
    plot(aufKontur(:,2),aufKontur(:,1),'r','Linewidth',2);
end
if blnMittel == 1
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
end
hold off; % erst jetzt werden die Linien tatsuechlich ueber das Bild gelegt

dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;
rosa=handles.rosa;
grau=handles.grau;

axes(handles.axes26)
imshow('.\gui_pics\Mikroskopie_materialinseln.png')


set(handles.Kennwert1, 'string', 'Berechnen')
set(handles.Kennwert1, 'BackgroundColor',dunkelrot)
set(handles.Kennwert1, 'ForegroundColor','white')


set(handles.text59,'backgroundcolor','white')

set(handles.uipanel38,'backgroundcolor',hellrot)
set(handles.uipanel38,'highlightcolor',hellrot)
set(handles.uipanel38,'shadowcolor',hellrot)


step = 3;
waitbar(step/steps);
close(h)
guidata(hObject,handles);
function AusrichtungButton_Callback(hObject, eventdata, handles)
h = waitbar(0,'Bild wird berechnet ...');
img = handles.imgEroded; % beide Bilder laden, da Benutzer zwischen diesen beiden auswuehlen kann (Radiobuttons)
imgO = handles.imgOriginal;

%Auslesen der realen Kontur
boundary = realeKontur(img); %Array "Kontur" wird von der Funktion zurueckgegeben
[height,width,~] = size(img);

%Bestimmung des Anfang- und Endpunktes der Trendlinie (Polynom 1.Grades)
Start(1,2) = 1; %x-Koordinate = 1
Start(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Start(1,2));
Ende(1,2) = width;
Ende(1,1) = polyval(polyfit(boundary(:,2),boundary(:,1),1),Ende(1,2));

%Unterschied Trendlinie links/rechts
diffLR = Ende(1,1)-Start(1,1); % Unterschied der y-Komponenten
winkel = atand(diffLR/(width/2));

imgBWDreh = imrotate(img,winkel,'nearest','crop'); %nearest: s. Website; crop: Ecken werden abgeschnitten, die ueber das Ursprungsformat hinausschaunen wuerden. Bildmauee bleiben also erhalten.
imgOrigDreh = imrotate(imgO,winkel,'nearest','crop');

%Berechnung des schwarzen Randes, der durch die Drehung entsteht und
%abgeschnitten werden muss
%     if diffLR <0 % Rechtsdrehung des Bildes
linkeGrenze=abs(ceil(height/2 * diffLR/(width/2))); %ceil: Immmer aufrunden, dass auf keinen Fall zu wenig abgeschnitten wird.
if linkeGrenze <= 0
    linkeGrenze = 1;
end

%         imgBWSchnitt = imgBWDreh(:,linkeGrenze:width);
%         imgOrigSchnitt = imgOrigDreh(:,linkeGrenze:width);
%     else
rechteGrenze=width-floor(height/2 * diffLR/(width/2)); % floor: bei Linksdrehung (Wegschneiden an rechtem Rand)
if rechteGrenze >= width
    rechteGrenze = width-1;
end

imgBWSchnitt = imgBWDreh(:,linkeGrenze:rechteGrenze);
imgOrigSchnitt = imgOrigDreh(:,linkeGrenze:rechteGrenze);
%     end

%Anzeigen des Umgewandelten Bildes
handles.imgErod = imgBWSchnitt;
handles.imgOrig = imgOrigSchnitt;

%Auswahl, ob das Schwarz/Weiue-Bild oder das gedrehte Original angezeigt
%werden soll
sr = handles.scaleResolution;
if get(handles.SWBildRadio,'value') == 1
    handles.hfig = imtool(handles.imgErod,'InitialMagnification',sr);
    set(handles.hfig, 'Position', get(0,'Screensize'), 'Name','4. Horizontale Ausrichtung');
    %         imshow(imgBWSchnitt,[]); % beim sw-Bild wieder Umwandlung in 0...255
else
    handles.hfig = imtool(handles.imgOrig,'InitialMagnification',sr);
    set(handles.hfig, 'Position', get(0,'Screensize'), 'Name','4. Horizontale Ausrichtung');
end

close(h)
guidata(hObject,handles);
function PorenBildButton_Callback(hObject, eventdata, handles)
h = waitbar(0,'Bild wird berechnet ...');
steps = 5;

%MassstabWert ist mit 1 initialisiert
Massstab = handles.MassstabWert;
MassstabEinheit = handles.MassstabEinheit;

maxEntfernung = str2double(get(handles.EntfernungPorenText,'String'));

img = handles.imgErod;
if maxEntfernung == 0
    imgO = handles.imgOriginal;
else
    imgO = handles.imgOrig;
end
[height,width,~] = size(img);

% %Hier fehlt ein Error-Handling!                                ***********

%Auslesen der Poren - Matlab-Befehl
[B,L,N] = bwboundaries(img);
stats = regionprops(L,'Area');
statsAry = [stats.Area]; % Array mit Fluechen der einzelnen Poren

if maxEntfernung > 0
    Mittel = mean2(handles.realeKonturY);
end
blnRealeKontur = get(handles.realKonturCheck, 'value');
blnAufKontur = get(handles.aufKonturCheck, 'value');
blnMittel = get(handles.MittellinieCheck,'value');

step = 1;
waitbar(step/steps);

%Anzeigen des Bildes
sr = handles.scaleResolution;
if get(handles.SWBildRadio, 'Value') == 1
    hfig = imtool(handles.imgErod,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','6. Poren');
else
    hfig = imtool(handles.imgOrig,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','6. Poren');
end

hold on;
if blnRealeKontur == 1
    realeKonturY = handles.realeKonturY;
    realeKonturX = handles.realeKonturX;
    plot(realeKonturX,realeKonturY,'g','Linewidth', 2);
end
if blnAufKontur == 1
    aufKontur = handles.aufKontur;
    plot(aufKontur(:,2),aufKontur(:,1),'r','Linewidth',2);
end
if blnMittel == 1
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
end

step = 2;
waitbar(step/steps);

%Ausgabe der Poren in Excel
if get(handles.PorenExportCheck,'value') == 1
    %Erstellung eines neuen Dateinamens aus dem Bildnamen
    filename = ['.\Ausgabe\', handles.BildName, '_DatenExport.xlsx'];
    handles.Excelname = filename;
    
    %Anlegen der Exceltabelle und Einfuegen der Ueberschriften
    textEntfernung = ['Mittlere Entfernung Mittelpunkt zu Mitte Kontur [', MassstabEinheit, ']'];
    xlswrite(filename,{textEntfernung},2,'B1');
    textFlaeche = ['Grueuee der Pore [', MassstabEinheit, '^2]'];
    xlswrite(filename,{textFlaeche},2,'C1');
    
    %Anzahl der Poren, die Vorgaben entsprechen
    zaehler = 1;
end

step = 3;
waitbar(step/steps);

%Speicher fuer die Gesamtflueche der Poren
porenFlaeche = 0;

for k=1:length(B)
    boundaryHoles = B{k};
    if(k > N)
        %Entfernung == 0 fuer Bilder ohne Oberflaeche
        if maxEntfernung == 0 || max(boundaryHoles(:,1)) < (Mittel + (maxEntfernung/Massstab))
            %Abfragen der Groesse der Pore
            if statsAry(k) >= (str2double(get(handles.MinFlaechePorenText,'String'))/Massstab^2)
                %Speichern der Porenflaeche (ohne Massstab!)
                porenFlaeche = porenFlaeche + statsAry(k);
                %rote Umrandung der Pore
                plot(boundaryHoles(:,2), boundaryHoles(:,1), 'r','LineWidth',2);
                
                %Ausgabe der Poren in Excel
                if get(handles.PorenExportCheck,'value') == 1
                    %dynamische Bestimmung der Position in der Exceltabelle
                    xlRangeZaehl = ['A',num2str(zaehler + 1)]; % zaehler anfangs = 1 --> gibt die Zeile der Exceltabelle an
                    xlswrite(filename,zaehler,2,xlRangeZaehl);
                    
                    %dynamische Bestimmung der Position in der Exceltabelle
                    xlRangeMittel = ['B',num2str(zaehler + 1)];
                    %Mittelwert der z-Werte der Pore minus den Mittelwert
                    %der realen Konturlinie
                    if maxEntfernung > 0
                        xlswrite(filename,(mean2(boundaryHoles(:,1)) - Mittel)*Massstab,2,xlRangeMittel);
                    end
                    
                    %dynamische Bestimmung der Position in der Exceltabelle
                    xlRangeFlaeche = ['C',num2str(zaehler + 1)];
                    %Flaeche der Pore
                    xlswrite(filename,statsAry(k)*Massstab^2,2,xlRangeFlaeche);
                    
                    zaehler = zaehler + 1;
                end
            end
        end
    end
end

step = 4;
waitbar(step/steps);

handles.PorenFlaeche = porenFlaeche;

%Speichern des S/W-Bildes inkl. Erosion, Poren, ausgewuehlten
%Konturen und evtl. Mittellinie
if get(handles.PorenExportCheck,'value') == 1
    
    if get(handles.SWBildRadio, 'Value') == 1
        filenameBild = ['.\Ausgabe\', handles.BildName, '_SW'];
    else
        filenameBild = ['.\Ausgabe\', handles.BildName, '_orig'];
    end
    
end
hold off;

step = 5;
waitbar(step/steps);

close(h)
%Texteingabefelder gruen fuerben
set(handles.MinFlaechePorenText,'BackgroundColor','green');
set(handles.EntfernungPorenText,'BackgroundColor','green');
guidata(hObject,handles);
function AusgabeButton_Callback(hObject, eventdata, handles)
img = handles.imgErod;
% %Hier fehlt ein Error-Handling!                                ***********

[height,width] = size(img);
Massstab = handles.MassstabWert;

%Berechnung der Flueche der Hinterschneidungen
realeKonturY = handles.realeKonturY;
realeKonturX = handles.realeKonturX;
aufKontur = handles.aufKontur;
% %Hier fehlt ein Error-Handling!                                ***********

%Achtung! Im Bild geht die z-Achse von oben nach unten, daher
%umgekehrte Reihenfolge!
realeKonturUmgekehrt = [height - realeKonturY(:),realeKonturX(:)];
aufKonturUmgekehrt = [height - aufKontur(:,1),aufKontur(:,2)];

%Flueche der realen Kontur
flaecheRealK = trapz(realeKonturUmgekehrt(1:2:length(realeKonturX),2),realeKonturUmgekehrt(1:2:length(realeKonturY),1));

%Flueche der Aufsichtkontur
flaecheAufK = 0;
for i=1:width
    flaecheAufK = flaecheAufK + aufKonturUmgekehrt(i,1);
end

flaecheHinter =  flaecheAufK - flaecheRealK;

%Poren zu Hinterschneidungen rechnen (z.B. fuer Metalle)
if get(handles.PorenHinterCheck,'value')
    flaecheHinter = flaecheHinter + handles.PorenFlaeche;
end

handles.FlaecheHinterschneidung = flaecheHinter;
set(handles.FlaecheHinterschneidungText,'String',num2str(flaecheHinter*Massstab^2));


%     %Berechnung des Pz-Wertes (genormte Oberflaechenrauheitangabe)
%
%     %Aufteilung der Bildbreite in 5 Einzelstrecken
%     einzelStrecke = floor(width/5);
%     Zv=zeros(5,1);
%     Zp=zeros(5,1);
%
%     %Berg und Tal in den Einzelstrecken
%     for i=1:5
%         Zv(i)=max(aufKontur(1+(einzelStrecke*(i-1)):(einzelStrecke*i),1));
%         Zp(i)=min(aufKontur(1+(einzelStrecke*(i-1)):(einzelStrecke*i),1));
%     end
%
%     Pzeinzel=zeros(5,1);
%     Pv=zeros(5,1);
%     Pp=zeros(5,1);
%
%     %Pz der Einzelstrecken
%     for i=1:5
%         Pv(i)=abs(Zv(i)- mean2(realeKonturY));
%         Pp(i)=abs(Zp(i)- mean2(realeKonturY));
%         Pzeinzel(i)= Pv(i)+Pp(i);
%     end
%
%     %Pz gesamt
%     Pz=mean2(Pzeinzel);
%     handles.Pz_Wert = Pz;
%     set(handles.PzWertText,'String',num2str(Pz*Massstab));

%Berechnung von Pt
%Berg und Tal
Zv =max(aufKontur(1:width,1));
Zp =min(aufKontur(1:width,1));

Pt=Zv-Zp;
handles.Pt_Wert = Pt;
set(handles.PzWertText,'String',num2str(Pt*Massstab));

%     %Button gruen fuerben, wenn Code fertig
%     set(handles.AusgabeButton,'BackgroundColor','green');
guidata(hObject,handles);
function BreiteLaengeText_Callback(hObject, eventdata, handles)
function BreiteLaengeText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function BreiteLaengeEinheitText_Callback(hObject, eventdata, handles)
function BreiteLaengeEinheitText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function HintergrundToggleButton_Callback(hObject, eventdata, handles)
set(handles.HintergrundToggleButton,'BackgroundColor','yellow');
dcm_obj = datacursormode(handles.hfig); % datacursormode: liest verschiedene Informationen durch Klicken auf das Bild aus
if get(hObject,'Value')==1 % Wenn Toggle-Button 'an' ist, der Benutzer also gerade Bildpunkte setzt.
    set(dcm_obj,'Enable','on');
    uiwait; %Auf Benutzereingabe warten
else %Toggle-Button 'aus' - Benutzer hat nun wieder auf den Button geklickt. Auswahl abgeschlossen.
    uiresume;
    set(dcm_obj,'Enable','off');
    
    %Information vom Datapoint auslesen
    info_struct = getCursorInfo(dcm_obj);
    pos = info_struct.Position;
    posX = pos(1,1);
    posY = pos(1,2);
    %X und Y Wert in GUI ausgeben
    set(handles.HintergrundPosXText,'String',num2str(posX));
    set(handles.HintergrundPosYText,'String',num2str(posY));
    set(handles.HintergrundPosYText,'String',posY);
    set(handles.HintergrundPosYText,'String',posX);
    dcm_obj=0; %Variable zuruecksetzen, um einen erneuten Aufruf dieses Programmteils zu vermeiden
    
    %Neue Mittelwerte berechnen
    HintergrundWert =  mean2(handles.imgOriginal((posY-5):(posY+5),(posX-5):(posX+5)));
    MaterialWert = str2double(get(handles.MaterialText,'String'));
    SchwellWert = (HintergrundWert + MaterialWert)/2;
    set(handles.HintergrundText, 'String', HintergrundWert);
    set(handles.SchwellwertText, 'String', SchwellWert);
end

set(handles.HintergrundToggleButton,'BackgroundColor','green');
guidata(hObject,handles);
function HintergrundPosXText_Callback(hObject, eventdata, handles)
function HintergrundPosXText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function HintergrundPosYText_Callback(hObject, eventdata, handles)
function HintergrundPosYText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MaterialToggleButton_Callback(hObject, eventdata, handles)
set(handles.MaterialToggleButton,'BackgroundColor','yellow');
dcm_obj = datacursormode(handles.hfig);
if get(hObject,'Value')==1
    set(dcm_obj,'Enable','on');
    uiwait;
else
    uiresume;
    set(dcm_obj,'Enable','off');
    
    %Information vom Datapoint auslesen
    info_struct = getCursorInfo(dcm_obj);
    %Position auslesen
    pos = info_struct.Position;
    %Position in X und Y aufteilen
    posX = pos(1,1);
    posY = pos(1,2);
    %X und Y Wert in GUI ausgeben
    set(handles.MaterialPosXText,'String',num2str(posX));
    set(handles.MaterialPosYText,'String',num2str(posY));
    %Variable zuruecksetzen, um einen erneuten Aufruf dieses Programmteils
    %zu vermeiden
    dcm_obj=0;
    
    %Neue Mittelwerte berechnen
    HintergrundWert = str2double(get(handles.HintergrundText,'String'));
    MaterialWert = mean2(handles.imgOriginal((posY-5):(posY+5),(posX-5):(posX+5)));
    SchwellWert = (HintergrundWert + MaterialWert)/2;
    
    %Ausgabe der Werte in der GUI
    set(handles.MaterialText, 'String', MaterialWert);
    set(handles.SchwellwertText, 'String', SchwellWert);
end

set(handles.MaterialToggleButton,'BackgroundColor','green');
guidata(hObject,handles);
function MaterialPosXText_Callback(hObject, eventdata, handles)
function MaterialPosXText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MaterialPosYText_Callback(hObject, eventdata, handles)
function MaterialPosYText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MassstabLinksToggleButton_Callback(hObject, eventdata, handles)
set(handles.MassstabLinksToggleButton,'BackgroundColor','yellow');
dcm_obj = datacursormode(handles.hfig);
if get(hObject,'Value')==1
    set(dcm_obj,'Enable','on');
    uiwait;
else
    uiresume;
    set(dcm_obj,'Enable','off');
    info_struct = getCursorInfo(dcm_obj);
    
    %Position auslesen
    pos = info_struct.Position;
    posX = pos(1,1);
    posY = pos(1,2);
    handles.MassstabLinksPosX = posX;
    handles.MassstabLinksPosY = posY;
    guidata(hObject,handles);
end

set(handles.MassstabLinksToggleButton,'BackgroundColor','green');
function MassstabRechtsToggleButton_Callback(hObject, eventdata, handles)
set(handles.MassstabRechtsToggleButton,'BackgroundColor','yellow');
dcm_obj = datacursormode(handles.hfig);
if get(hObject,'Value')==1
    set(handles.MassstabRechtsToggleButton,'BackgroundColor','yellow');
    set(dcm_obj,'Enable','on');
    uiwait;
else
    uiresume;
    set(dcm_obj,'Enable','off');
    info_struct = getCursorInfo(dcm_obj);
    pos = info_struct.Position;
    posX = pos(1,1);
    posY = pos(1,2);
    handles.MassstabRechtsPosX = posX;
    handles.MassstabRechtsPosY = posY;
    LaengeX = posX - handles.MassstabLinksPosX;
    LaengeY = posY - handles.MassstabLinksPosY;
    Laenge = sqrt(LaengeX^2 + LaengeY^2);
    set(handles.MassstabLaengeText,'String',num2str(Laenge));
end

set(handles.MassstabRechtsToggleButton,'BackgroundColor','green');
guidata(hObject,handles);
function MassstabLaengeText_Callback(hObject, eventdata, handles)
function MassstabLaengeText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit26_Callback(hObject, eventdata, handles)
function edit26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function MassstabButton_Callback(hObject, eventdata, handles)

%Auslesen der Einheit des Mauestabes und setzen dieser Einheit fuer die Ausgabe
contents = cellstr(get(handles.EinheitMassstabPopUp,'String'));
einheit = contents{get(handles.EinheitMassstabPopUp,'Value')}; % einheit = ausgewuehlter String (z.B. "mm")
handles.MassstabEinheit = einheit;

einheitQuad = strcat(einheit,'^2');
set(handles.FlaechePorenEinheitText,'String',einheitQuad);
set(handles.EntfernungPorenEinheitText,'String',einheit);
set(handles.BreiteBildEinheitText,'String',einheit);
set(handles.LaengeOberflaecheEinheitText,'String',einheit);
set(handles.FlaecheHinterschneidungEinheitText,'String',einheitQuad);
set(handles.PzWertEinheitText,'String',einheit);

handles.MassstabWert = str2double(get(handles.MassstabText,'String'))/str2double(get(handles.MassstabLaengeText,'String'));

set(handles.MassstabText,'BackgroundColor','green');

% Massstab im Bild entfernen und Bild anzeigen
img = handles.imgBW;
[height,width] = size(img);
k=0;
if width ~= 2720 || height ~= 2048
    %         formatSpec = 'Bitte zur Kenntnis nehmen:\n\nLeider kann bei ihrem Bild die automatische Mauestabsentfernung nicht angewendet werden.\n\nIhre Bild ist mit seiner %d Pixel grueueen Bildbreite ungleich der Standardbreite 2720.\n\nIhre Bild ist mit seiner %d Pixel grueueen Bildbreite ungleich der StandardHoehe 2048.';
    %         message = sprintf(formatSpec,width,height);
    %         reply = questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');
    k = 1;
end
if k == 0
    for i =1905:2008
        for j=2167:2668
            img(i,j)=1;
        end
    end
end
if k == 1
    for i =1645:1750
        for j=100:600
            img(i,j)=1;
        end
    end
end
handles.imgBW = img;
guidata(hObject,handles);
function PorenExportCheck_Callback(hObject, eventdata, handles)
function ErgebnisseExportButton_Callback(hObject, eventdata, handles)
h = waitbar(0,'Bild wird berechnet ...');
steps = 5;

if get(handles.PorenExportCheck,'value') == 1
    filename = handles.Excelname;
else
    filename = ['.\Ausgabe\', handles.BildName, '_DatenExport.xlsx'];
end

%Name des Bildes
zeile = 1;
xlRange = ['A',num2str(zeile)];
xlswrite(filename,{handles.BildName},1,xlRange);
zeile = zeile + 2;

step = 1;
waitbar(step/steps);

%Farbwerte
xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Farbwerte'},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Hintergrund:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.HintergrundText, 'string'))},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Material:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.MaterialText,'String'))},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Schwellwert:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.SchwellwertText,'String'))},1,xlRange);
zeile = zeile + 2;

step = 2;
waitbar(step/steps);

%Kantenglaettung
xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Gluettung'},1, xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Form:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{handles.GlaettungForm},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Grueuee des Elements:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.GroesseGlaettungText,'String'))},1,xlRange);
zeile = zeile + 2;

step = 3;
waitbar(step/steps);

%Massstab
xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Mauestab des Bildes'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{handles.MassstabWert},1,xlRange);
xlRange = ['C',num2str(zeile)];
einheit = [handles.MassstabEinheit, '/px'];
xlswrite(filename,{einheit},1,xlRange);
zeile = zeile + 2;

step = 4;
waitbar(step/steps);

%Ergebnisse
xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Ergebnisse'},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Breite des Bildes:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.BreiteBildText,'String'))},1,xlRange);
xlRange = ['C',num2str(zeile)];
xlswrite(filename,{get(handles.BreiteBildEinheitText,'String')},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Konturluenge:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.LaengeOberflaecheText,'String'))},1,xlRange);
xlRange = ['C',num2str(zeile)];
xlswrite(filename,{get(handles.LaengeOberflaecheEinheitText,'String')},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Verhueltnis Bildbreite zu Konturluenge:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.BreiteLaengeText,'String'))},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Flueche der Hinterschneidungen:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.FlaecheHinterschneidungText,'String'))},1,xlRange);
xlRange = ['C',num2str(zeile)];
xlswrite(filename,{get(handles.FlaecheHinterschneidungEinheitText,'String')},1,xlRange);
zeile = zeile + 1;

xlRange = ['A',num2str(zeile)];
xlswrite(filename,{'Pt-Wert:'},1,xlRange);
xlRange = ['B',num2str(zeile)];
xlswrite(filename,{str2double(get(handles.PzWertText,'String'))},1,xlRange);
xlRange = ['C',num2str(zeile)];
xlswrite(filename,{get(handles.PzWertEinheitText,'String')},1,xlRange);

step = 5;
waitbar(step/steps);
close(h)
function MittellinieCheck_Callback(hObject, eventdata, handles)
function SWBildRadio_Callback(hObject, eventdata, handles)
function PorenHinterCheck_Callback(hObject, eventdata, handles)
function HintergrundToggleButton_CreateFcn(hObject, eventdata, handles)
function MaterialToggleButton_CreateFcn(hObject, eventdata, handles)    
function HilfeOrigBildButton_Callback(hObject, eventdata, handles)
openfig('OrigBild_Hilfe','new')
function HilfeKonturButton_Callback(hObject, eventdata, handles)
openfig('Kontur_Hilfe','new')
function HilfeAusrichtungButton_Callback(hObject, eventdata, handles)
openfig('Drehung_Hilfe','new')
function HilfeErgebnisseButton_Callback(hObject, eventdata, handles)
openfig('Ergebnisse_Hilfe','new')
function HilfePorenButton_Callback(hObject, eventdata, handles)
openfig('Poren_Hilfe','new')
function HilfeMassstabButton_Callback(hObject, eventdata, handles)
openfig('Massstab_Hilfe','new')
function HilfeGlaettungButton_Callback(hObject, eventdata, handles)
openfig('Glaettung_Hilfe','new')
function HilfeMittelpunkteButton_Callback(hObject, eventdata, handles)
openfig('Mittelpunkt_Hilfe','new')
function HilfeFarbwerteButton_Callback(hObject, eventdata, handles)
openfig('Farbwerte_Hilfe','new')
function Kennwerte_GUI_oeffnen_PushButton_Callback(hObject, eventdata, handles)
Kennwerte;
function MatInselnButton_Callback(hObject, eventdata, handles)
h = waitbar(0,'Bild wird berechnet ...');
steps = 5;


%MassstabWert ist mit 1 initialisiert
Massstab = handles.MassstabWert;
MassstabEinheit = handles.MassstabEinheit;

maxEntfernung = str2double(get(handles.EntfernungPorenText,'String'));

img = handles.imgErod;
imgInverted = imcomplement(img);
img = imgInverted;
[~,width,~] = size(img);
% %Hier fehlt ein Error-Handling!                                ***********

%Auslesen der Poren - Matlab-Befehl
[B,L,N] = bwboundaries(img);
stats = regionprops(L,'Area');
statsAry = [stats.Area]; % Array mit Fluechen der einzelnen Poren

if maxEntfernung > 0
    Mittel = mean2(handles.realeKonturY);
end
blnRealeKontur = get(handles.realKonturCheck, 'value');
blnAufKontur = get(handles.aufKonturCheck, 'value');
blnMittel = get(handles.MittellinieCheck,'value');

step = 1;
waitbar(step/steps);

%Anzeigen des Bildes

sr = handles.scaleResolution;
if get(handles.SWBildRadio, 'Value') == 1
    hfig = imtool(handles.imgErod,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','7. Materialinseln');
else
    hfig = imtool(handles.imgOrig,'InitialMagnification',sr);
    set(hfig, 'Position', get(0,'Screensize'), 'Name','7. Materialinseln');
end

hold on;
if blnRealeKontur == 1
    realeKonturY = handles.realeKonturY;
    realeKonturX = handles.realeKonturX;
    plot(realeKonturX,realeKonturY,'g','Linewidth', 2);
end
if blnAufKontur == 1
    aufKontur = handles.aufKontur;
    plot(aufKontur(:,2),aufKontur(:,1),'r','Linewidth',2);
end
if blnMittel == 1
    plot([1 width],[Mittel Mittel],'b','Linewidth',2);
end

step = 2;
waitbar(step/steps);

%Ausgabe der Poren in Excel
if get(handles.PorenExportCheck,'value') == 1
    %Erstellung eines neuen Dateinamens aus dem Bildnamen
    filename = ['.\Ausgabe\', handles.BildName, '_DatenExport.xlsx'];
    handles.Excelname = filename;
    
    %Anlegen der Exceltabelle und Einfuegen der Ueberschriften
    textEntfernung = ['Mittlere Entfernung Mittelpunkt zu Mitte Kontur [', MassstabEinheit, ']'];
    xlswrite(filename,{textEntfernung},2,'B1');
    textFlaeche = ['Grueuee der Pore [', MassstabEinheit, '^2]'];
    xlswrite(filename,{textFlaeche},2,'C1');
    
    %Anzahl der Poren, die Vorgaben entsprechen
    zaehler = 1;
end

step = 3;
waitbar(step/steps);

%Speicher fuer die Gesamtflueche der Poren
porenFlaeche = 0;

for k=1:length(B)
    boundaryHoles = B{k};
    if(k > N)
        %Entfernung == 0 fuer Bilder ohne Oberflaeche
        if maxEntfernung == 0 || max(boundaryHoles(:,1)) < (Mittel + (maxEntfernung/Massstab))
            %Abfragen der Groesse der Pore
            if statsAry(k) >= (str2double(get(handles.MinFlaechePorenText,'String'))/Massstab^2)
                %Speichern der Porenflaeche (ohne Massstab!)
                porenFlaeche = porenFlaeche + statsAry(k);
                %rote Umrandung der Pore
                plot(boundaryHoles(:,2), boundaryHoles(:,1), 'c','LineWidth',2);
            end
        end
    end
end


step = 4;
waitbar(step/steps);

handles.MaterialinselnFlaeche = porenFlaeche;
print2eps('eps1')
export_fig('png1')
hold off;

step = 5;
waitbar(step/steps);

close(h)
%Texteingabefelder gruen fuerben
set(handles.MinFlaechePorenText,'BackgroundColor','green');
set(handles.EntfernungPorenText,'BackgroundColor','green');
guidata(hObject,handles);

function FertigExport_Callback(hObject, eventdata, handles)
hb = waitbar(0,'Fortschrittsanzeige','Name','Berichte werden erstellt...');
steps = 5;
step = 1;
waitbar(step/steps);

%Bild von GUI machen

thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_GUI.png.tif',datestr8601);
fullImageFileName = fullfile(thisFolder, [DefaultName]);
export_fig(fullImageFileName,SLS_Oberflaechenrauheit_final, '-r300','-transparent')



% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

step = 2;
waitbar(step/steps);

%% Kennwerte Teil 2.1 - Bilder einfuegen

fileName = handles.ExcelKennwerte;
filename = fileName;
fileName = handles.ExcelDaten;
filename2 = fileName;

% Step 1: The first step is to create a COM server which runs the Excel Application.
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error.
% You can put the above statement within a try-catch block:
try
    Excel = actxserver('Excel.Application');
catch
    Excel = [];
end

% Step 2: In this step, we will open an Excel file ueResultFile.xlsue in the current directory.
ResultFile = [pwd '\' filename];
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;

% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=520-10; % 182.89 mm/0.352
myPicHeight=208 -10; % nur ueber das Seitenverhueltnis der GUI berechnet: 5388x2154
left1 = Sheet1.Range('I3').Left + 5;
top1 = Sheet1.Range('I3').Top +5;
Shapes.AddPicture(fullImageFileName ,0,1,left1,top1,myPicWidth,myPicHeight);

% Ausgabe der erstellten Dateien als Msgbox und schreiben in
% Kennwerte-Datei
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;

A = cellstr(ErzeugteDateien(1:(aktuelleZeile-1),1));
sheet = 1;
xlRange1 = 'CW6';
xlswrite(filename2,A,sheet,xlRange1)

A = cellstr(ErzeugteDateien(1:(aktuelleZeile-1),2));
sheet = 1;
xlRange1 = 'DA6';
xlswrite(filename2,A,sheet,xlRange1)



% print this sheet to PDF
set(Excel, 'DisplayAlerts', 0); % # Stop dialog!
xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way

Workbook.ExportAsFixedFormat('xlTypePDF',fullfile(pwd,filename));
ResultFile = [pwd '\' filename2];
Workbook2 = invoke(Excel.Workbooks,'Open', ResultFile);
Workbook2.ExportAsFixedFormat('xlTypePDF',fullfile(pwd,filename2));

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullfile(pwd,filename),filename);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullfile(pwd,filename2),filename2);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

% Informationsdialoge
% message = sprintf('Zu ihrer Bildanalyse wurden zwei Excel-Reports erstellt, die jeweils als eine PDF-Datei exportiert wurden:\n\na) Kennwerteuebersicht\nb) Datenuebersicht\n\nZudem wurden einige Bilder separat erstellt und abgespeichert (3 Bilder zu jedem Kennwert, die Abschluss-GUI).\n\nIm nachfolgenden Fenster bzw. im Daten-Report sind alle Dateien inkl. ihrer Dateigrueueen aufgelistet.');
% questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');
% message = '';
% message2 = '';
% for i=(aktuelleZeile-1):-1:1
%     message = sprintf('Dateiname: "%s",\nDateigroesse: "%s"\n\n', ErzeugteDateien(i,1:2));
%     message2 = [message, message2];
% end
% questdlg(message2, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');
% message = sprintf('Die Kennwerteermittlung ist nun abgeschlossen.\n\nAlle Fenster sowie die GUI selbst werden nun automatisch geschlossen.');
% questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');

% Save the workbook and Close Excel

step = 5;
waitbar(step/steps);
close(hb)

Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook2.SaveAs(fullfile(pwd,filename2), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');

%Pop-up: folgende Dateien wurden exportiert und befinden sich in diesem
%Ordner: " "

%Alle Fenster, auch die GUI schlieueen
kill2
function Kennwert1_Callback(hObject, eventdata, handles)

results = calculateSurfaceParameters(handles, 'matIslands', 14, 'Materialinseln', 0);
visualUpdateOfGUIAfterFirstParameter(handles)
defineKennwertAsCompleted(handles, results, '1') 

function Kennwert4_Callback(hObject, eventdata, handles)
%% Teil 1 - Eliminierung 1
format long g;
format compact;
captionFontSize = 14;

hb = waitbar(0,'Fortschrittsanzeige','Name','Kennwert 4 "Einbuchtungen" wird berechnet...');
steps = 6;
step = 1;
waitbar(step/steps);

criteria = 'pores';

% Read in a standard MATLAB demo image of coins (US nickles and dimes, which are 5 cent and 10 cent coins)

originalImage = handles.imgEroded;
[height, width,~] = size(originalImage);
firstStepImage = originalImage;

labeledImage_materialIslands = bwlabel(firstStepImage, 8);     % Label each blob so we can make measurements of it
labeledImage_materialIslands = RichtigLabeln(labeledImage_materialIslands);

% change of some values in binary image in case of pores:
if isequal(criteria ,'pores')
    [height,width] = size(firstStepImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if firstStepImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0;
            end
            if firstStepImage(a_1, a_2) == 0
                array_merk_pores(a_1, a_2) = 1;
            end
        end
    end
    firstStepImage = array_merk_pores;
end

labeledImage_pores = bwlabel(firstStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            firstStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            firstStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(firstStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if firstStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if firstStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
firstStepImage = array_merk_pores;

% figure;
% imshow(firstStepImage);

%% Teil 2 - Eliminierung 2
step = 2;
waitbar(step/steps);

secondStepImage = firstStepImage;


labeledImage_materialIslands = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it
labeledImage_materialIslands = RichtigLabeln(labeledImage_materialIslands);

% change of some values in binary image in case of pores:
if isequal(criteria ,'pores')
    [height,width] = size(secondStepImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if secondStepImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0;
            end
            if secondStepImage(a_1, a_2) == 0
                array_merk_pores(a_1, a_2) = 1;
            end
        end
    end
    secondStepImage = array_merk_pores;
end

labeledImage_pores = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            secondStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            secondStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(secondStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if secondStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if secondStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
secondStepImage = array_merk_pores;

% figure;
% imshow(secondStepImage);

%% Teil 3 - vertikale Linien
step = 3;
waitbar(step/steps);

thirdStepImage = secondStepImage;

count = 0;
k = 0;
w =0;
h = 0;
iZeile = 0;
zWerte = zeros(10000,2);

for i = 1:width
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if thirdStepImage(j,i) == 1
            zWerte(iZeile,1) = j;
            % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
            % vorliegen kuennte (also die Hoehendifferenz grueueer als 1
            % ist)
            if i > 1
                % Hoehenwert des aktuellen Pixel
                a = zWerte(iZeile,1);
                % Hoehenwert des vorherigen Pixel
                b = zWerte(iZeile-1,1);
                % wenn die Hoehendifferenz > 1 ist
                
                % rechte Seite des Tals, nach oben gehend)
                if (b - a) > 1
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + k;
                    %                         zWerte(iZeile,2) = zWerte(iZeile-1,2) + k;
                    %                         zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 1;
                end
                
                % linke Seite des Tals, nach unten gehend
                if (b - a) < (-1)
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + 1 + k;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2) + 1 + k;
                    zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
            end
            break;
        end
    end
    % Wenn Bildbreite erreicht, For-Schleife beenden
    if iZeile - count >= width - 1
        break
    end
end

% nur den Bildbereich weiterverwenden, der in der vorangestellten
% Schleife beschrieben wurde.
zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

blankThirdStepImage = zeros(height, width);
% Einfuerbung der "Draufsicht fuer Hinterschnitterkennung" im Mikroskopiebild
for i=1:iZeile
    thirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
    blankThirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
end


%       figure;
%  imshow(thirdStepImage);

%% Teil 4 - "Poren" ausfuellen
step = 4;
waitbar(step/steps);

[height,width] = size(thirdStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if thirdStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if thirdStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
thirdStepImage = array_merk_pores;

labeledImage_pores = bwlabel(thirdStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) == 78887
            thirdStepImage(i,j) = 0;
        end
    end
end

[height,width] = size(thirdStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if thirdStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if thirdStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
ForthStepImage = array_merk_pores;

%% Teil 5 - Einbuchtungen erkennen (Poren generieren)
step = 5;
waitbar(step/steps);

faktor = str2double(get(handles.AnzahlUnterteilungenText,'String'));
aufteilung = width/faktor;

boundary = realeKontur(ForthStepImage);
FifthStepImage = ForthStepImage;
letzteZeile = 0;
for j=1:faktor
    % letzten Punkt in boundary() ermitteln, der zur aktuellen Section
    % gehuert
    letzteZeileVorher = letzteZeile + 1;
    letzteZeileaktuell = aufteilung*10 + letzteZeileVorher;
    endeSection = round(j*aufteilung);
    for i=letzteZeileVorher:letzteZeileaktuell
        if boundary(i,2) >= endeSection
            letzteZeile = i;
            break;
        end
    end
    % Finden des jeweiligen Maximums, eintragen dessen Koordinaten in Array
    a = letzteZeileVorher;
    b = letzteZeile;
    MaxSection = min(boundary(a:b,1));
    MinSection = max(boundary(a:b,1));
    %     punktLinie = MaxSection  - 1; % so sitzt die horizontale Linie auf
    %     Max
    punktLinie = MaxSection - 2; % 1-pixel Abstand zum Max.
    %horizontale Linie zeichnen
    for d=round(((j-1)*aufteilung + 1)):round((j*aufteilung))
        FifthStepImage(punktLinie,d) = 1;
    end
    %senkrechte Linie nach unten ziehen
    abstand = MinSection-punktLinie;
    if j>1
        for i=0:(abstand)
            FifthStepImage(punktLinie + i,round(j*aufteilung)) = 1;
            FifthStepImage(punktLinie + i,round((j-1)*aufteilung)) = 1;
        end
    end
    if j==1
        for i=0:(abstand)
            FifthStepImage(punktLinie + i,round(j*aufteilung)) = 1;
        end
    end
    % den h?chsten und tiefsten Punkt ermitteln
    MaxGlobal = min(boundary(:,1));
    MinGlobal = max(boundary(:,1));
end

% figure;
% imshow(FifthStepImage);


%% Teil 6 - "Poren" finden


[height,width] = size(FifthStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if FifthStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if FifthStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
FifthStepImage = array_merk_pores;

labeledImage = bwlabel(FifthStepImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
figure;
subplot(1, 3, 1);
imshow(labeledImage, []);  % Show the gray scale image.
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
title('Labeled Image, from bwlabel()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.


% Let's assign each blob a different color to visually show the user the distinct blobs.

colors = [0,0,0; rand(length(labeledImage), 3)];
coloredLabels = label2rgb (labeledImage, colors);
% coloredLabels is an RGB image.  We could have applied a colormap instead (but only with R2014b and later)
subplot(1, 3, 2);
imshow(coloredLabels);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
caption = sprintf('Pseudo colored labels, from label2rgb().');
title(caption, 'FontSize', captionFontSize);

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, FifthStepImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
subplot(1, 3, 3);
imshow(FifthStepImage);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(FifthStepImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
    thisBoundary = boundaries{k};
    plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;
close(gcf)

% Loop over all blobs printing their measurements to the command window.
array_inseln = zeros(numberOfBlobs-1,4);
for k = 1 : numberOfBlobs
    blobArea = blobMeasurements(k).Area;
    [~,blobWidth] = size(blobMeasurements(k).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(k).SubarrayIdx{1, 1}(:,:));
    if k > 1
        array_inseln(k-1,1) = k;
        array_inseln(k-1,2) = blobArea;
        array_inseln(k-1,3) = blobWidth;
        array_inseln(k-1,4) = blobHeight;
    end
end

bild1 = figure;
imshow(handles.imgOriginal);
hold on;
set(image(coloredLabels),'AlphaData',0.5);
set(gca,'position',[0 0 1 1],'units','normalized')
hold off;

thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_EinfallstellenOverlay.tif',datestr8601);
fullImageFileName1 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName1, '-r300', '-transparent')
close(bild1)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName1,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

sort_array_inseln = sortrows(array_inseln,2,'descend');


DefaultName = sprintf('%s_EinfallstellenMikroskopie.tif',datestr8601);
fullImageFileName2 = fullfile(thisFolder, [DefaultName]);
imwrite(uint8(coloredLabels), fullImageFileName2);


% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName2,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
prozent = 0.5;
WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.

bild2 = figure;	% Create a new figure window.
set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
for k = 1:numberOfBlobs-1           % Loop through all blobs.
    currentBlob = sort_array_inseln(k,1);
    thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
    subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
    subplot(WertInHoehe, WertInBreite, k);
    imshow(subImage);
    [~,blobWidth] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 1}(:,:));
    formatSpec = '#%d, Flaeche %d px\nBreite %d px\nHoehe %d px';
    A1 = blobMeasurements(currentBlob).Area;
    caption = sprintf(formatSpec,k, A1,blobWidth, blobHeight);
    sort_array_inseln(k,1) = k;
    title(caption, 'FontSize', textFontSize);
end

DefaultName = sprintf('%s_EinfallstellenUebersicht.tif',datestr8601);
fullImageFileName3 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName3, '-r300', '-transparent')
close(bild2)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName3,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

%% Kennwerte Teil 2 - Kennwerte-Dokument fuellen

OffeneWorkbooks

% Gesamtflueche
[height,~] = size(sort_array_inseln);
poren_gesamtflaeche = 0;
for i=1:height
    poren_gesamtflaeche = poren_gesamtflaeche + sort_array_inseln(i,2);
end

%Verhueltnis der Gesamtflueche zur Bildflueche berechnen
[height2,width2] = size(originalImage);
VerhaeltnisFlaeche = poren_gesamtflaeche/(height2*width2);
AusgabeVerhaeltnis = cellstr(sprintf('%s', strjoin({num2str(100*VerhaeltnisFlaeche), char(37)},'')));

fileName = handles.ExcelKennwerte;


% Gesamtflueche und Verhueltnis ins Excel-Blatt schreiben
% hExcel = actxserver('Excel.Application');
% currentFolder = pwd;
filename = fileName;
A = cellstr(sprintf('%s%s', strjoin({num2str(poren_gesamtflaeche),' px'},'')));
B = AusgabeVerhaeltnis;
sheet = 1;
xlRange1 = 'AP18';
xlRange2 = 'AT18';
xlswrite(filename,A,sheet,xlRange1)
xlswrite(filename,B,sheet,xlRange2)
xlswrite(filename,MaxGlobal,sheet,'K21')
xlswrite(filename,MinGlobal,sheet,'K22')


% Kennwerte (Area, Width, Height) berechnen
if height < 40
    height2 = height;
else
    height2 = 40;
end
ganzeZeile=string(zeros(height2,1));
for i=1:height2
    A1 = strjoin({'A: ', num2str(sort_array_inseln(i,2)), 'px'},'');
    A2 = strjoin({'W: ', num2str(sort_array_inseln(i,3)), 'px'},'');
    A3 = strjoin({'H: ', num2str(sort_array_inseln(i,4)), 'px'},'');
    ganzeZeile(i,1) = strjoin({A1,' / ',A2,' / ',A3},'');
end
% die ersten 40 unter die Tabelle schreiben
breakvalue = 0;
for j=1:4
    if (height2 - 10*j + 10) > 10
        ende = j*10;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*10+1;
    A = ganzeZeile(anfang:ende);
    xlRange = [xlcolumnletter(41+2*j-2),num2str(19)];
    xlswrite(filename,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'I1';
xlswrite(fileName,A,sheet,xlRange1)

%% Kennwerte Teil 2.1 - Bilder einfuegen

% Step 1: The first step is to create a COM server which runs the Excel Application.
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error.
% You can put the above statement within a try-catch block:
try
    Excel = actxserver('Excel.Application');
catch
    Excel = [];
end

% Step 2: In this step, we will open an Excel file ueResultFile.xlsue in the current directory.
ResultFile = [pwd '\' filename];
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;

% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=258-10; % 91/0.352
myPicHeight=194 -10; % = 68.52/0.352
myPicWidth3=516 -20; % 182/0.352
myPicHeight3=241 -20; % = 85/0.352

left1 = Sheet1.Range('AO3').Left + 2.5;
top1 = Sheet1.Range('AO3').Top + 5;
left2 = Sheet1.Range('AS3').Left + 2.5;
top2 = Sheet1.Range('AS3').Top + 5;
left3 = Sheet1.Range('AO4').Left + 5;
top3 = Sheet1.Range('AO4').Top + 5;
Shapes.AddPicture(fullImageFileName1 ,0,1,left1,top1,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName2 ,0,1,left2,top2,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName3 ,0,1,left3,top3,myPicWidth3,myPicHeight3);

% Save the workbook and Close Excel
set(Excel, 'DisplayAlerts', 0); % # Stop dialog!
xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way
Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');


%% Kennwerte Teil 4 - Daten-Workbook befuellen

fileName = handles.ExcelDaten;


% Es stehen 171 Pluetze zur Verfuegung
if height > 171
    height2 = 171;
else
    height2 = height;
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'O1';
xlswrite(fileName,A,sheet,xlRange1)


% es stehen 3 Felder mit je 57 Zeilen zur Verfuegung
breakvalue = 0;
for j=1:3
    if (height2 - 57*j + 57) > 57
        ende = j*57;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*57+1;
    A = sort_array_inseln(anfang:ende,2:4);
    xlRange = [xlcolumnletter(58+5*j-5),num2str(6)];
    xlswrite(fileName,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end


%% Visuelles Update in der GUI



axes(handles.axes29)
imshow(coloredLabels)

gruen=handles.gruen;
dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;

set(handles.text62,'string','Fertiges Bild')

set(handles.uipanel41,'backgroundcolor',gruen)
set(handles.uipanel41,'highlightcolor',gruen)
set(handles.uipanel41,'shadowcolor',gruen)

set(handles.Kennwert4, 'string', 'Fertig!')
set(handles.Kennwert4, 'BackgroundColor',gruen)
set(handles.Kennwert4, 'ForegroundColor','black')
set(handles.pushbutton77, 'BackgroundColor',gruen)
set(handles.pushbutton77, 'ForegroundColor','black')
set(handles.pushbutton77, 'string', 'Fertig!')
set(handles.AnzahlUnterteilungenText,'BackgroundColor','green');
set(handles.text64,'backgroundcolor',gruen)


% wenn alle 5 Kennwerte berechnet sind, soll auch die das Hintergrundpanel
% gruen werden
hellgruen=handles.hellgruen;
handles.ZaehlerBerechneteKennwerte = handles.ZaehlerBerechneteKennwerte + 1;
if handles.ZaehlerBerechneteKennwerte == 5
    set(handles.uipanel9,'backgroundcolor',hellgruen)
    set(handles.uipanel9,'highlightcolor',hellgruen)
    set(handles.uipanel9,'shadowcolor',hellgruen)
    set(handles.uipanel9,'foregroundcolor',hellgruen)
end
%     zt = handles.ZaehlerBerechneteKennwerte;
%     zt = num2str(zt);
%     message = sprintf(zt);
%     questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');


step = 6;
waitbar(step/steps);
delete(hb);
guidata(hObject, handles);



automatisch = get(handles.CheckAutomatischeBerechnung, 'value'); %Checkboxen
if automatisch == 0
    Kennwert5_Callback(hObject, eventdata, handles)
end
function Kennwert3_Callback(hObject, eventdata, handles)
%% Teil 1 - Porensuche
hb = waitbar(0,'Fortschrittsanzeige','Name','Kennwert 3 "Poren" wird berechnet...');
steps = 2;
step = 1;
waitbar(step/steps);



format long g;
format compact;
captionFontSize = 14;

criteria = 'pores';

% Read in a standard MATLAB demo image of coins (US nickles and dimes, which are 5 cent and 10 cent coins)

originalImage = handles.imgEroded;

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
figure;
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
colors = [0,0,0; rand(length(labeledImage), 3)];
coloredLabels = label2rgb (labeledImage, colors);
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
close(gcf);

% Loop over all blobs printing their measurements to the command window.
array_inseln = zeros(numberOfBlobs-1,4);
for k = 1 : numberOfBlobs
    blobArea = blobMeasurements(k).Area;
    [~,blobWidth] = size(blobMeasurements(k).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(k).SubarrayIdx{1, 1}(:,:));
    if k > 1
        array_inseln(k-1,1) = k;
        array_inseln(k-1,2) = blobArea;
        array_inseln(k-1,3) = blobWidth;
        array_inseln(k-1,4) = blobHeight;
    end
end

%% Teil 2 - Export

bild1 = figure;
imshow(handles.imgOriginal);
hold on;
set(image(coloredLabels),'AlphaData',0.5);
set(gca,'position',[0 0 1 1],'units','normalized')
hold off;

thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_PorenOverlay.tif',datestr8601);
fullImageFileName1 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName1, '-r300', '-transparent')
close(bild1)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName1,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

sort_array_inseln = sortrows(array_inseln,2,'descend');

DefaultName = sprintf('%s_PorenMikroskopie.tif',datestr8601);
fullImageFileName2 = fullfile(thisFolder, [DefaultName]);
imwrite(uint8(coloredLabels), fullImageFileName2);

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName2,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);


% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
prozent = 0.5;
WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.

bild2 = figure;	% Create a new figure window.
set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
for k = 1:numberOfBlobs-1           % Loop through all blobs.
    currentBlob = sort_array_inseln(k,1);
    thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
    subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
    subplot(WertInHoehe, WertInBreite, k);
    imshow(subImage);
    [~,blobWidth] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 1}(:,:));
    formatSpec = '#%d, Flaeche %d px\nBreite %d px\nHoehe %d px';
    A1 = blobMeasurements(currentBlob).Area;
    caption = sprintf(formatSpec,k, A1,blobWidth, blobHeight);
    sort_array_inseln(k,1) = k;
    title(caption, 'FontSize', textFontSize);
end

DefaultName = sprintf('%s_PorenUebersicht.tif',datestr8601);
fullImageFileName3 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName3, '-r300', '-transparent')
close(bild2)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName3,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

%% Kennwerte Teil 2 - Kennwerte-Dokument fuellen

OffeneWorkbooks

% Gesamtflueche
[height,~] = size(sort_array_inseln);
poren_gesamtflaeche = 0;
for i=1:height
    poren_gesamtflaeche = poren_gesamtflaeche + sort_array_inseln(i,2);
end

%Verhueltnis der Gesamtflueche zur Bildflueche berechnen
[height2,width2] = size(originalImage);
VerhaeltnisFlaeche = poren_gesamtflaeche/(height2*width2);
AusgabeVerhaeltnis = cellstr(sprintf('%s', strjoin({num2str(100*VerhaeltnisFlaeche), char(37)},'')));

fileName = handles.ExcelKennwerte;


% Gesamtflueche und Verhueltnis ins Excel-Blatt schreiben
% hExcel = actxserver('Excel.Application');
% currentFolder = pwd;
filename = fileName;
A = cellstr(sprintf('%s%s', strjoin({num2str(poren_gesamtflaeche),' px'},'')));
B = AusgabeVerhaeltnis;
sheet = 1;
xlRange1 = 'AH18';
xlRange2 = 'AL18';
xlswrite(filename,A,sheet,xlRange1)
xlswrite(filename,B,sheet,xlRange2)


% Kennwerte (Area, Width, Height) berechnen
if height < 40
    height2 = height;
else
    height2 = 40;
end
ganzeZeile=string(zeros(height2,1));
for i=1:height2
    A1 = strjoin({'A: ', num2str(sort_array_inseln(i,2)), 'px'},'');
    A2 = strjoin({'W: ', num2str(sort_array_inseln(i,3)), 'px'},'');
    A3 = strjoin({'H: ', num2str(sort_array_inseln(i,4)), 'px'},'');
    ganzeZeile(i,1) = strjoin({A1,' / ',A2,' / ',A3},'');
end
% die ersten 40 unter die Tabelle schreiben
breakvalue = 0;
for j=1:4
    if (height2 - 10*j + 10) > 10
        ende = j*10;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*10+1;
    A = ganzeZeile(anfang:ende);
    xlRange = [xlcolumnletter(33+2*j-2),num2str(19)];
    xlswrite(filename,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'I1';
xlswrite(fileName,A,sheet,xlRange1)

%% Kennwerte Teil 2.1 - Bilder einfuegen

% Step 1: The first step is to create a COM server which runs the Excel Application.
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error.
% You can put the above statement within a try-catch block:
try
    Excel = actxserver('Excel.Application');
catch
    Excel = [];
end

% Step 2: In this step, we will open an Excel file ueResultFile.xlsue in the current directory.
ResultFile = [pwd '\' filename];
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;

% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=258-10; % 91/0.352
myPicHeight=194 -10; % = 68.52/0.352
myPicWidth3=516 -20; % 182/0.352
myPicHeight3=241 -20; % = 85/0.352

left1 = Sheet1.Range('AG3').Left + 2.5;
top1 = Sheet1.Range('AG3').Top +5;
left2 = Sheet1.Range('AK3').Left + 2.5;
top2 = Sheet1.Range('AK3').Top + 5;
left3 = Sheet1.Range('AG4').Left + 5;
top3 = Sheet1.Range('AG4').Top + 5;
Shapes.AddPicture(fullImageFileName1 ,0,1,left1,top1,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName2 ,0,1,left2,top2,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName3 ,0,1,left3,top3,myPicWidth3,myPicHeight3);

% Save the workbook and Close Excel
set(Excel, 'DisplayAlerts', 0); % # Stop dialog!
xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way
Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');


%% Kennwerte Teil 4 - Daten-Workbook befuellen

fileName = handles.ExcelDaten;


% Es stehen 171 Pluetze zur Verfuegung
if height > 171
    height2 = 171;
else
    height2 = height;
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'O1';
xlswrite(fileName,A,sheet,xlRange1)


% es stehen 3 Felder mit je 57 Zeilen zur Verfuegung
breakvalue = 0;
for j=1:3
    if (height2 - 57*j + 57) > 57
        ende = j*57;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*57+1;
    A = sort_array_inseln(anfang:ende,2:4);
    xlRange = [xlcolumnletter(44+5*j-5),num2str(6)];
    xlswrite(fileName,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

%% Visuelles Update in der GUI


axes(handles.axes25)
imshow(coloredLabels)

gruen=handles.gruen;
dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;
hellgruen=handles.hellgruen;
grau=handles.grau;
rosa=handles.rosa;
schwarz=handles.schwarz;

set(handles.text58,'string','Fertiges Bild')

set(handles.uipanel37,'backgroundcolor',gruen)
set(handles.uipanel37,'highlightcolor',gruen)
set(handles.uipanel37,'shadowcolor',gruen)

set(handles.Kennwert3, 'string', 'Fertig!')
set(handles.Kennwert3, 'BackgroundColor',gruen)
set(handles.Kennwert3, 'ForegroundColor','black')

% wenn alle 5 Kennwerte berechnet sind, soll auch die das Hintergrundpanel
% gruen werden
hellgruen=handles.hellgruen;
handles.ZaehlerBerechneteKennwerte = handles.ZaehlerBerechneteKennwerte + 1;
if handles.ZaehlerBerechneteKennwerte == 5
    set(handles.uipanel9,'backgroundcolor',hellgruen)
    set(handles.uipanel9,'highlightcolor',hellgruen)
    set(handles.uipanel9,'shadowcolor',hellgruen)
    set(handles.uipanel9,'foregroundcolor',hellgruen)
end
%     zt = handles.ZaehlerBerechneteKennwerte;
%     zt = num2str(zt);
%     message = sprintf(zt);
%     questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');
guidata(hObject, handles);

step = 2;
waitbar(step/steps);
close(hb)


automatisch = get(handles.CheckAutomatischeBerechnung, 'value'); %Checkboxen
if automatisch == 0
    Kennwert4_Callback(hObject, eventdata, handles)
end
function Kennwert2_Callback(hObject, eventdata, handles)


results = calculateSurfaceParameters(handles.imgOriginal, handles.imgEroded, ...
    'pores', 14, 'Materialinseln', 1);
defineKennwertAsCompleted(handles, results) 



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            firstStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            firstStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(firstStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if firstStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if firstStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
firstStepImage = array_merk_pores;



%% Teil 2 - Eliminierung 2


secondStepImage = firstStepImage;


labeledImage_materialIslands = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it
labeledImage_materialIslands = RichtigLabeln(labeledImage_materialIslands);

% change of some values in binary image in case of pores:
if isequal(criteria ,'pores')
    [height,width] = size(secondStepImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if secondStepImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0;
            end
            if secondStepImage(a_1, a_2) == 0
                array_merk_pores(a_1, a_2) = 1;
            end
        end
    end
    secondStepImage = array_merk_pores;
end

labeledImage_pores = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            secondStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            secondStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(secondStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if secondStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if secondStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
secondStepImage = array_merk_pores;

% figure;
% imshow(secondStepImage);

%% Teil 3 - Vertikale Linien

step = 4;
waitbar(step/steps);

thirdStepImage = secondStepImage;


count = 0;
k = 0;
w =0;
h = 0;
iZeile = 0;
zWerte = zeros(100000,2);

for i = 1:width
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if thirdStepImage(j,i) == 1
            zWerte(iZeile,1) = j;
            % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
            % vorliegen kuennte (also die Hoehendifferenz grueueer als 1
            % ist)
            if i > 1
                % Hoehenwert des aktuellen Pixel
                a = zWerte(iZeile,1);
                % Hoehenwert des vorherigen Pixel
                b = zWerte(iZeile-1,1);
                % wenn die Hoehendifferenz > 1 ist
                
                % rechte Seite des Tals, nach oben gehend)
                if (b - a) > 1
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + k;
                    %                         zWerte(iZeile,2) = zWerte(iZeile-1,2) + k;
                    %                         zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 1;
                end
                
                % linke Seite des Tals, nach unten gehend
                if (b - a) < (-1)
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + 1 + k;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2) + 1 + k;
                    zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
            end
            break;
        end
    end
    % Wenn Bildbreite erreicht, For-Schleife beenden
    if iZeile - count >= width - 1
        break
    end
end

% nur den Bildbereich weiterverwenden, der in der vorangestellten
% Schleife beschrieben wurde.
zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

blankThirdStepImage = zeros(height, width);
% Einfuerbung der "Draufsicht fuer Hinterschnitterkennung" im Mikroskopiebild
for i=1:iZeile
    thirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
    blankThirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
end


%    figure;
% imshow(blankThirdStepImage);
%    figure;
% imshow(thirdStepImage);

%% Teil 4 - "Poren" finden

step = 5;
waitbar(step/steps);

% Poren finden

[height,width] = size(thirdStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if thirdStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if thirdStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
thirdStepImage = array_merk_pores;

labeledImage = bwlabel(thirdStepImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
figure;
subplot(1, 3, 1);
imshow(labeledImage, []);  % Show the gray scale image.
% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
title('Labeled Image, from bwlabel()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.


% Let's assign each blob a different color to visually show the user the distinct blobs.
colors = [0,0,0; rand(length(labeledImage), 3)];
coloredLabels = label2rgb (labeledImage, colors);
% coloredLabels is an RGB image.  We could have applied a colormap instead (but only with R2014b and later)
subplot(1, 3, 2);
imshow(coloredLabels);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
caption = sprintf('Pseudo colored labels, from label2rgb().');
title(caption, 'FontSize', captionFontSize);

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, thirdStepImage, 'all');
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
close(gcf);

% Loop over all blobs printing their measurements to the command window.
array_inseln = zeros(numberOfBlobs-1,4);
for k = 1 : numberOfBlobs
    blobArea = blobMeasurements(k).Area;
    [~,blobWidth] = size(blobMeasurements(k).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(k).SubarrayIdx{1, 1}(:,:));
    if k > 1
        array_inseln(k-1,1) = k;
        array_inseln(k-1,2) = blobArea;
        array_inseln(k-1,3) = blobWidth;
        array_inseln(k-1,4) = blobHeight;
    end
end

bild1 = figure;
imshow(handles.imgOriginal);
hold on;
set(image(coloredLabels),'AlphaData',0.5);
set(gca,'position',[0 0 1 1],'units','normalized')
hold off;

thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_HinterschnitteOverlay.tif',datestr8601);
fullImageFileName1 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName1, '-r300', '-transparent')
close(bild1)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName1,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);


sort_array_inseln = sortrows(array_inseln,2,'descend');


DefaultName = sprintf('%s_HinterschnitteMikroskopie.tif',datestr8601);
fullImageFileName2 = fullfile(thisFolder, [DefaultName]);
imwrite(uint8(coloredLabels), fullImageFileName2);


% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName2,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
prozent = 0.5;
WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.

bild2 = figure;	% Create a new figure window.
set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
for k = 1:numberOfBlobs-1           % Loop through all blobs.
    currentBlob = sort_array_inseln(k,1);
    thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
    subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
    subplot(WertInHoehe, WertInBreite, k);
    imshow(subImage);
    [~,blobWidth] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 1}(:,:));
    formatSpec = '#%d, Flaeche %d px\nBreite %d px\nHoehe %d px';
    A1 = blobMeasurements(currentBlob).Area;
    caption = sprintf(formatSpec,k, A1,blobWidth, blobHeight);
    sort_array_inseln(k,1) = k;
    title(caption, 'FontSize', textFontSize);
end

DefaultName = sprintf('%s_HinterschnitteUebersicht.tif',datestr8601);
fullImageFileName3 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName3, '-r300', '-transparent')
close(bild2)

% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName3,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

%% Kennwerte Teil 2 - Kennwerte-Dokument fuellen

OffeneWorkbooks

% Gesamtflueche
[height,~] = size(sort_array_inseln);
poren_gesamtflaeche = 0;
for i=1:height
    poren_gesamtflaeche = poren_gesamtflaeche + sort_array_inseln(i,2);
end

%Verhueltnis der Gesamtflueche zur Bildflueche berechnen
[height2,width2] = size(originalImage);
VerhaeltnisFlaeche = poren_gesamtflaeche/(height2*width2);
AusgabeVerhaeltnis = cellstr(sprintf('%s', strjoin({num2str(100*VerhaeltnisFlaeche), char(37)},'')));

fileName = handles.ExcelKennwerte;


% Gesamtflueche und Verhueltnis ins Excel-Blatt schreiben
% hExcel = actxserver('Excel.Application');
% currentFolder = pwd;
filename = fileName;
A = cellstr(sprintf('%s%s', strjoin({num2str(poren_gesamtflaeche),' px'},'')));
B = AusgabeVerhaeltnis;
sheet = 1;
xlRange1 = 'Z18';
xlRange2 = 'AD18';
xlswrite(filename,A,sheet,xlRange1)
xlswrite(filename,B,sheet,xlRange2)


% Kennwerte (Area, Width, Height) berechnen
if height < 40
    height2 = height;
else
    height2 = 40;
end
ganzeZeile=string(zeros(height2,1));
for i=1:height2
    A1 = strjoin({'A: ', num2str(sort_array_inseln(i,2)), 'px'},'');
    A2 = strjoin({'W: ', num2str(sort_array_inseln(i,3)), 'px'},'');
    A3 = strjoin({'H: ', num2str(sort_array_inseln(i,4)), 'px'},'');
    ganzeZeile(i,1) = strjoin({A1,' / ',A2,' / ',A3},'');
end
% die ersten 40 unter die Tabelle schreiben
breakvalue = 0;
for j=1:4
    if (height2 - 10*j + 10) > 10
        ende = j*10;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*10+1;
    A = ganzeZeile(anfang:ende);
    xlRange = [xlcolumnletter(25+2*j-2),num2str(19)];
    xlswrite(filename,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'I1';
xlswrite(fileName,A,sheet,xlRange1)

%% Kennwerte Teil 2.1 - Bilder einfuegen

% Step 1: The first step is to create a COM server which runs the Excel Application.
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error.
% You can put the above statement within a try-catch block:
try
    Excel = actxserver('Excel.Application');
catch
    Excel = [];
end

% Step 2: In this step, we will open an Excel file ueResultFile.xlsue in the current directory.
ResultFile = [pwd '\' filename];
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;

% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=258-10; % 91/0.352
myPicHeight=194 -10; % = 68.52/0.352
myPicWidth3=516 -20; % 182/0.352
myPicHeight3=241 -20; % = 85/0.352

left1 = Sheet1.Range('Y3').Left + 2.5;
top1 = Sheet1.Range('Y3').Top +5;
left2 = Sheet1.Range('AC3').Left + 2.5;
top2 = Sheet1.Range('AC3').Top + 5;
left3 = Sheet1.Range('Y4').Left + 5;
top3 = Sheet1.Range('Y4').Top + 5;
Shapes.AddPicture(fullImageFileName1 ,0,1,left1,top1,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName2 ,0,1,left2,top2,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName3 ,0,1,left3,top3,myPicWidth3,myPicHeight3);

% Save the workbook and Close Excel
set(Excel, 'DisplayAlerts', 0); % # Stop dialog!
xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way
Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');


%% Kennwerte Teil 4 - Daten-Workbook befuellen

fileName = handles.ExcelDaten;


% Es stehen 171 Pluetze zur Verfuegung
if height > 171
    height2 = 171;
else
    height2 = height;
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'O1';
xlswrite(fileName,A,sheet,xlRange1)


% es stehen 3 Felder mit je 57 Zeilen zur Verfuegung
breakvalue = 0;
for j=1:3
    if (height2 - 57*j + 57) > 57
        ende = j*57;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*57+1;
    A = sort_array_inseln(anfang:ende,2:4);
    xlRange = [xlcolumnletter(30+5*j-5),num2str(6)];
    xlswrite(fileName,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end


%% Visuelles Update in der GUI

step = 6;
waitbar(step/steps);
delete(hb);


axes(handles.axes24)
imshow(coloredLabels)

gruen=handles.gruen;
dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;

set(handles.text57,'string','Fertiges Bild')

set(handles.uipanel36,'backgroundcolor',gruen)
set(handles.uipanel36,'highlightcolor',gruen)
set(handles.uipanel36,'shadowcolor',gruen)

set(handles.Kennwert2, 'string', 'Fertig!')
set(handles.Kennwert2, 'BackgroundColor',gruen)
set(handles.Kennwert2, 'ForegroundColor','black')

% wenn alle 5 Kennwerte berechnet sind, soll auch die das Hintergrundpanel
% gruen werden
hellgruen=handles.hellgruen;
handles.ZaehlerBerechneteKennwerte = handles.ZaehlerBerechneteKennwerte + 1;
if handles.ZaehlerBerechneteKennwerte == 5
    set(handles.uipanel9,'backgroundcolor',hellgruen)
    set(handles.uipanel9,'highlightcolor',hellgruen)
    set(handles.uipanel9,'shadowcolor',hellgruen)
    set(handles.uipanel9,'foregroundcolor',hellgruen)
end
%     zt = handles.ZaehlerBerechneteKennwerte;
%     zt = num2str(zt);
%     message = sprintf(zt);
%     questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');
guidata(hObject, handles);

automatisch = get(handles.CheckAutomatischeBerechnung, 'value'); %Checkboxen
if automatisch == 0
    Kennwert3_Callback(hObject, eventdata, handles)
end
function AnzahlUnterteilungenText_Callback(hObject, eventdata, handles)
function AnzahlUnterteilungenText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton77_Callback(hObject, eventdata, handles)
set(handles.AnzahlUnterteilungenText,'BackgroundColor','green');
function Kennwert5_Callback(hObject, eventdata, handles)
%% 1. Materialinseln und Poren entfernen (Materialinseln aber fuer spueter "merken"
hb = waitbar(0,'Fortschrittsanzeige','Name','Kennwert 5 "Flaeche hinter Materialinseln" wird berechnet...');
steps = 10;
step = 1;
waitbar(step/steps);

format long g;
format compact;
captionFontSize = 14;

criteria = 'pores';

% Read in a standard MATLAB demo image of coins (US nickles and dimes, which are 5 cent and 10 cent coins)

originalImage = handles.imgEroded;
[height, width,~] = size(originalImage);
firstStepImage = originalImage;

labeledImage_materialIslands = bwlabel(firstStepImage, 8);     % Label each blob so we can make measurements of it
labeledImage_materialIslands = RichtigLabeln(labeledImage_materialIslands);
labeledImage_materialIslands2 = labeledImage_materialIslands;

% change of some values in binary image in case of pores:
if isequal(criteria ,'pores')
    [height,width] = size(firstStepImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if firstStepImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0;
            end
            if firstStepImage(a_1, a_2) == 0
                array_merk_pores(a_1, a_2) = 1;
            end
        end
    end
    firstStepImage = array_merk_pores;
end

labeledImage_pores = bwlabel(firstStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            firstStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            firstStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(firstStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if firstStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if firstStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
firstStepImage = array_merk_pores;

% figure;
% imshow(firstStepImage);


secondStepImage = firstStepImage;


labeledImage_materialIslands = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it
labeledImage_materialIslands = RichtigLabeln(labeledImage_materialIslands);
labeledImage_materialIslands3 = labeledImage_materialIslands;

% change of some values in binary image in case of pores:
if isequal(criteria ,'pores')
    [height,width] = size(secondStepImage);
    array_merk_pores =  zeros(height, width);
    for a_1 = 1:height
        for a_2 = 1:width
            if secondStepImage(a_1, a_2) == 1
                array_merk_pores(a_1, a_2) = 0;
            end
            if secondStepImage(a_1, a_2) == 0
                array_merk_pores(a_1, a_2) = 1;
            end
        end
    end
    secondStepImage = array_merk_pores;
end

labeledImage_pores = bwlabel(secondStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end

for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) > 1
            labeledImage_materialIslands(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands(i,j) == 96661
            secondStepImage(i,j) = 1;
        end
        if labeledImage_pores(i,j) == 78887
            secondStepImage(i,j) = 0;
        end
    end
end


[height,width] = size(secondStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if secondStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if secondStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
secondStepImage = array_merk_pores;

% figure;
% imshow(secondStepImage);


%% Teil 2 - Hinterschnitte durch vertikale Linien sichtbar machen
step = 2;
waitbar(step/steps);

thirdStepImage = secondStepImage;

count = 0;
k = 0;
w =0;
h = 0;
iZeile = 0;
zWerte = zeros(10000,2);

for i = 1:width
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if thirdStepImage(j,i) == 1
            zWerte(iZeile,1) = j;
            % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
            % vorliegen kuennte (also die Hoehendifferenz grueueer als 1
            % ist)
            if i > 1
                % Hoehenwert des aktuellen Pixel
                a = zWerte(iZeile,1);
                % Hoehenwert des vorherigen Pixel
                b = zWerte(iZeile-1,1);
                % wenn die Hoehendifferenz > 1 ist
                
                % rechte Seite des Tals, nach oben gehend)
                if (b - a) > 1
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + k;
                    %                         zWerte(iZeile,2) = zWerte(iZeile-1,2) + k;
                    %                         zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
                % linke Seite des Tals, nach unten gehend
                if (b - a) < (-1)
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + 1 + k;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2) + 1 + k;
                    zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
            end
            break;
        end
    end
    % Wenn Bildbreite erreicht, For-Schleife beenden
    if iZeile - count >= width - 1
        break
    end
end

% nur den Bildbereich weiterverwenden, der in der vorangestellten
% Schleife beschrieben wurde.
zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

blankThirdStepImage = zeros(height, width);
% Einfuerbung der "Draufsicht fuer Hinterschnitterkennung" im Mikroskopiebild
for i=1:iZeile
    thirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
    blankThirdStepImage(zWerte(i,1),zWerte(i,2)) = 1;
end


%    figure;
% imshow(blankThirdStepImage);

%% 3. Hinterschnitte ("Poren") finden und ausfuellen
step = 3;
waitbar(step/steps);

% Poren finden

[height,width] = size(thirdStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if thirdStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if thirdStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
thirdStepImage = array_merk_pores;


labeledImage_pores = bwlabel(thirdStepImage, 8);     % Label each blob so we can make measurements of it



for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) > 1
            labeledImage_pores(i,j) = 78887;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_pores(i,j) == 78887
            thirdStepImage(i,j) = 0;
        end
    end
end

[height,width] = size(thirdStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if thirdStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if thirdStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
ForthStepImage = array_merk_pores;


%% 4. Materialinseln wieder einblenden
step = 4;
waitbar(step/steps);

FifthStepImage = ForthStepImage;

for i=1:height
    for j=1:width
        if labeledImage_materialIslands2(i,j) > 1
            labeledImage_materialIslands2(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands2(i,j) == 96661
            FifthStepImage(i,j) = 1;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands3(i,j) > 1
            labeledImage_materialIslands3(i,j) = 96661;
        end
    end
end


for i=1:height
    for j=1:width
        if labeledImage_materialIslands3(i,j) == 96661
            FifthStepImage(i,j) = 1;
        end
    end
end


%% 5. Draufsicht machen, um die hinterschnittenen Fluechen durch Materialinseln sichtbar zu machen
step = 5;
waitbar(step/steps);

SixthStepImage = FifthStepImage;

count = 0;
k = 0;
w =0;
h = 0;
iZeile = 0;
zWerte = zeros(10000,2);

for i = 1:width
    iZeile = i + count;
    zWerte(iZeile,2) = i;
    for j= 1:height
        if SixthStepImage(j,i) == 1
            zWerte(iZeile,1) = j;
            % ab dem 2. Pixel vergleichen, ob ein Hinterschnitt
            % vorliegen kuennte (also die Hoehendifferenz grueueer als 1
            % ist)
            if i > 1
                % Hoehenwert des aktuellen Pixel
                a = zWerte(iZeile,1);
                % Hoehenwert des vorherigen Pixel
                b = zWerte(iZeile-1,1);
                % wenn die Hoehendifferenz > 1 ist
                
                % rechte Seite des Tals, nach oben gehend)
                if (b - a) > 1
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + k;
                    %                         zWerte(iZeile,2) = zWerte(iZeile-1,2) + k;
                    %                         zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i - 1 + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i - 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
                % linke Seite des Tals, nach unten gehend
                if (b - a) < (-1)
                    k = 0;
                    %zusuetzlich den vorherigen Pixel schreiben (gleiche
                    % x-Koordinate wie vorheriger Pixel, gleiche
                    % y-Koordinate wie aktueller Pixel
                    % vorheriger Pixel: Hoehe: zWerte(i-1,1), Breite: zWerte(i-1,2)
                    % aktueller Pixel: Hoehe: zWerte(i,1), Breite: zWerte(i,2)
                    % zukuenftiger Pixel: Hoehe: zWerte(i+1,1), Breite: zWerte(i+1,2)
                    
                    % aktueller Pixel wird zu i+1, damit der
                    % zwischengeschobene Pixel i sein kann
                    zWerte(iZeile+1,1) = j;
                    zWerte(iZeile+1,2) = i + 1 + k;
                    zWerte(iZeile,2) = zWerte(iZeile-1,2) + 1 + k;
                    zWerte(iZeile,1) = j;
                    
                    % die dazwischenliegenden Pixel muessen ebenfalls
                    % eingezeichnet werden (zwischen den Hoehen a und b)
                    c=1;
                    for z=abs(b-a):-1:1
                        %                         for z=1:abs(b-a)
                        zWerte(iZeile+1+c,2) = i + k;
                        if (b-a) < 0
                            zWerte(iZeile+1+c,1) = j - z;
                        else
                            zWerte(iZeile+1+c,1) = j + z;
                        end
                        count = count + 1;
                        c = c + 1;
                    end
                    
                    % nochmal den ersten Pixel einfuegen
                    zWerte(iZeile+1+c,1) = j;
                    zWerte(iZeile+1+c,2) = i + 1 + k;
                    % i-Zaehler um 1 erHoehen, da ein zusuetzliches
                    % Pixel in die Liste aufgenommen wurde. Ansonsten
                    % wuerde man beim nuechsten Durchlauf den letzten
                    % Pixel ueberschreiben.
                    count = count + 2;
                end
                
            end
            break;
        end
    end
    % Wenn Bildbreite erreicht, For-Schleife beenden
    if iZeile - count >= width - 1
        break
    end
end

% nur den Bildbereich weiterverwenden, der in der vorangestellten
% Schleife beschrieben wurde.
zWerte = [zWerte((1:iZeile),1),zWerte((1:iZeile),2)];

blankSixthStepImage = zeros(height, width);
% Einfuerbung der "Draufsicht fuer Hinterschnitterkennung" im Mikroskopiebild
for i=1:iZeile
    SixthStepImage(zWerte(i,1),zWerte(i,2)) = 1;
    blankSixthStepImage(zWerte(i,1),zWerte(i,2)) = 1;
end

% figure;
% imshow(SixthStepImage);

%% 6. Poren finden
step = 6;
waitbar(step/steps);

% Poren finden

[height,width] = size(SixthStepImage);
array_merk_pores =  zeros(height, width);
for a_1 = 1:height
    for a_2 = 1:width
        if SixthStepImage(a_1, a_2) == 1
            array_merk_pores(a_1, a_2) = 0;
        end
        if SixthStepImage(a_1, a_2) == 0
            array_merk_pores(a_1, a_2) = 1;
        end
    end
end
SixthStepImage = array_merk_pores;

labeledImage = bwlabel(SixthStepImage, 8);     % Label each blob so we can make measurements of it
% labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
figure;
subplot(1, 3, 1);
colors = [0,0,0; rand(length(labeledImage), 3)];
imshow(labeledImage, colors);


% Maximize the figure window.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Force it to display RIGHT NOW (otherwise it might not display until it's all done, unless you've stopped at a breakpoint.)
drawnow;
title('Labeled Image, from bwlabel()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.

step = 7;
waitbar(step/steps);

% Let's assign each blob a different color to visually show the user the distinct blobs.
colors = [0,0,0; rand(length(labeledImage), 3)];
coloredLabels = label2rgb (labeledImage, colors);
% coloredLabels is an RGB image.  We could have applied a colormap instead (but only with R2014b and later)
subplot(1, 3, 2);
imshow(coloredLabels);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
caption = sprintf('Pseudo colored labels, from label2rgb().');
title(caption, 'FontSize', captionFontSize);

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobMeasurements = regionprops(labeledImage, SixthStepImage, 'all');
numberOfBlobs = size(blobMeasurements, 1);

step = 8;
waitbar(step/steps);

% bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
% Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries.
subplot(1, 3, 3);
imshow(SixthStepImage);
title('Outlines, from bwboundaries()', 'FontSize', captionFontSize);
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
hold on;
boundaries = bwboundaries(SixthStepImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
    thisBoundary = boundaries{k};
    plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;
close(gcf);

% Loop over all blobs printing their measurements to the command window.
array_inseln = zeros(numberOfBlobs-1,4);
for k = 1 : numberOfBlobs
    blobArea = blobMeasurements(k).Area;
    [~,blobWidth] = size(blobMeasurements(k).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(k).SubarrayIdx{1, 1}(:,:));
    if k > 1
        array_inseln(k-1,1) = k;
        array_inseln(k-1,2) = blobArea;
        array_inseln(k-1,3) = blobWidth;
        array_inseln(k-1,4) = blobHeight;
    end
end

bild1 = figure;
imshow(handles.imgOriginal);
hold on;
set(image(coloredLabels),'AlphaData',0.5);
set(gca,'position',[0 0 1 1],'units','normalized')
hold off;

thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_HinterschnitteMatInselnOverlay.tif',datestr8601);
fullImageFileName1 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName1, '-r300', '-transparent')
close(bild1)


% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName1,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

sort_array_inseln = sortrows(array_inseln,2,'descend');

DefaultName = sprintf('%s_HinterschnitteMatInselnMikroskopie.tif',datestr8601);
fullImageFileName2 = fullfile(thisFolder, [DefaultName]);
imwrite(uint8(coloredLabels), fullImageFileName2);


% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName2,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

% Aufteilung subplot
sqrtBlobs = sqrt(numberOfBlobs);
prozent = 0.5;
WertInBreite = ceil(sqrtBlobs + (prozent+0.11)*sqrtBlobs);
WertInHoehe = ceil(sqrtBlobs - (prozent-0.11)*sqrtBlobs);
textFontSize = 8;	% Used to control size of "blob number" labels put atop the image.

bild2 = figure;	% Create a new figure window.
set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
for k = 1:numberOfBlobs-1           % Loop through all blobs.
    currentBlob = sort_array_inseln(k,1);
    thisBlobsBoundingBox = blobMeasurements(currentBlob).BoundingBox;  % Get list of pixels in current blob.
    subImage = imcrop(coloredLabels, thisBlobsBoundingBox);
    subplot(WertInHoehe, WertInBreite, k);
    imshow(subImage);
    [~,blobWidth] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 2}(:,:));
    [~,blobHeight] = size(blobMeasurements(currentBlob).SubarrayIdx{1, 1}(:,:));
    formatSpec = '#%d, Flaeche %d px\nBreite %d px\nHoehe %d px';
    A1 = blobMeasurements(currentBlob).Area;
    caption = sprintf(formatSpec,k, A1,blobWidth, blobHeight);
    sort_array_inseln(k,1) = k;
    title(caption, 'FontSize', textFontSize);
end

step = 9;
waitbar(step/steps);

DefaultName = sprintf('%s_HinterschnitteMatInselnUebersicht.tif',datestr8601);
fullImageFileName3 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName3, '-r300', '-transparent')
close(bild2)


% Erstelltes Dokument (Bild/Excel-Datei) in eine Liste aufnehemen
aktuelleZeile = handles.AnzahlErzeugteDateien;
ErzeugteDateien = handles.ErzeugteDateien;
bilderstellung(aktuelleZeile,ErzeugteDateien,fullImageFileName3,DefaultName);
handles.AnzahlErzeugteDateien = aktuelleZeile+1;
handles.ErzeugteDateien = ans;
guidata(hObject,handles);

%% Kennwerte Teil 2 - Kennwerte-Dokument fuellen

OffeneWorkbooks

% Gesamtflueche
[height,~] = size(sort_array_inseln);
poren_gesamtflaeche = 0;
for i=1:height
    poren_gesamtflaeche = poren_gesamtflaeche + sort_array_inseln(i,2);
end

%Verhueltnis der Gesamtflueche zur Bildflueche berechnen
[height2,width2] = size(originalImage);
VerhaeltnisFlaeche = poren_gesamtflaeche/(height2*width2);
AusgabeVerhaeltnis = cellstr(sprintf('%s', strjoin({num2str(100*VerhaeltnisFlaeche), char(37)},'')));

fileName = handles.ExcelKennwerte;


% Gesamtflueche und Verhueltnis ins Excel-Blatt schreiben
% hExcel = actxserver('Excel.Application');
% currentFolder = pwd;
filename = fileName;
A = cellstr(sprintf('%s%s', strjoin({num2str(poren_gesamtflaeche),' px'},'')));
B = AusgabeVerhaeltnis;
sheet = 1;
xlRange1 = 'AX18';
xlRange2 = 'BB18';
xlswrite(filename,A,sheet,xlRange1)
xlswrite(filename,B,sheet,xlRange2)


% Kennwerte (Area, Width, Height) berechnen
if height < 40
    height2 = height;
else
    height2 = 40;
end
ganzeZeile=string(zeros(height2,1));
for i=1:height2
    A1 = strjoin({'A: ', num2str(sort_array_inseln(i,2)), 'px'},'');
    A2 = strjoin({'W: ', num2str(sort_array_inseln(i,3)), 'px'},'');
    A3 = strjoin({'H: ', num2str(sort_array_inseln(i,4)), 'px'},'');
    ganzeZeile(i,1) = strjoin({A1,' / ',A2,' / ',A3},'');
end
% die ersten 40 unter die Tabelle schreiben
breakvalue = 0;
for j=1:4
    if (height2 - 10*j + 10) > 10
        ende = j*10;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*10+1;
    A = ganzeZeile(anfang:ende);
    xlRange = [xlcolumnletter(49+2*j-2),num2str(19)];
    xlswrite(filename,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'I1';
xlswrite(fileName,A,sheet,xlRange1)

%% Kennwerte Teil 2.1 - Bilder einfuegen

% Step 1: The first step is to create a COM server which runs the Excel Application.
% This assumes that the Excel Application is installed in your system. If Excel is not installed, this statement will give an error.
% You can put the above statement within a try-catch block:
try
    Excel = actxserver('Excel.Application');
catch
    Excel = [];
end

% Step 2: In this step, we will open an Excel file ueResultFile.xlsue in the current directory.
ResultFile = [pwd '\' filename];
Workbook = invoke(Excel.Workbooks,'Open', ResultFile);

%Step 3: By default, the visibility of the Excel file is set to FALSE. You can make the Excel file visible using the command:
set(Excel,'Visible',1);

% Get a handle to Sheets and select Sheet 1
Sheets = Excel.ActiveWorkBook.Sheets;
Sheet1 = get(Sheets, 'Item', 1);
Sheet1.Activate;

% Get a handle to Shapes for Sheet 1
Shapes = Sheet1.Shapes;

% Add image
myPicWidth=258-10; % 91/0.352
myPicHeight=194 -10; % = 68.52/0.352
myPicWidth3=516 -20; % 182/0.352
myPicHeight3=241 -20; % = 85/0.352

left1 = Sheet1.Range('AW3').Left + 2.5;
top1 = Sheet1.Range('AW3').Top +5;
left2 = Sheet1.Range('BA3').Left + 2.5;
top2 = Sheet1.Range('BA3').Top + 5;
left3 = Sheet1.Range('AW4').Left + 5;
top3 = Sheet1.Range('AW4').Top + 5;
Shapes.AddPicture(fullImageFileName1 ,0,1,left1,top1,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName2 ,0,1,left2,top2,myPicWidth,myPicHeight);
Shapes.AddPicture(fullImageFileName3 ,0,1,left3,top3,myPicWidth3,myPicHeight3);

% Save the workbook and Close Excel
set(Excel, 'DisplayAlerts', 0); % # Stop dialog!
xlWorkbookDefault = 51; % # it's the Excel constant, not sure how to pass it other way
Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');


%% Kennwerte Teil 4 - Daten-Workbook befuellen

fileName = handles.ExcelDaten;


% Es stehen 171 Pluetze zur Verfuegung
if height > 171
    height2 = 171;
else
    height2 = height;
end

% Dateinamen schreiben
A = cellstr(strjoin(handles.BildName,''));
xlRange1 = 'O1';
xlswrite(fileName,A,sheet,xlRange1)


% es stehen 3 Felder mit je 57 Zeilen zur Verfuegung
breakvalue = 0;
for j=1:3
    if (height2 - 57*j + 57) > 57
        ende = j*57;
    else
        ende = height2;
        breakvalue = 1;
    end
    anfang = (j-1)*57+1;
    A = sort_array_inseln(anfang:ende,2:4);
    xlRange = [xlcolumnletter(72+5*j-5),num2str(6)];
    xlswrite(fileName,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end

%% Visuelles Update in der GUI



axes(handles.axes27)
imshow(coloredLabels)

gruen=handles.gruen;
dunkelrot=handles.dunkelrot;
hellrot=handles.hellrot;

set(handles.text60,'string','Fertiges Bild')

set(handles.uipanel39,'backgroundcolor',gruen)
set(handles.uipanel39,'highlightcolor',gruen)
set(handles.uipanel39,'shadowcolor',gruen)

set(handles.Kennwert5, 'string', 'Fertig!')
set(handles.Kennwert5, 'BackgroundColor',gruen)
set(handles.Kennwert5, 'ForegroundColor','black')

% wenn alle 5 Kennwerte berechnet sind, soll auch die das Hintergrundpanel
% gruen werdenhellgruen=handles.hellgruen;
hellgruen=handles.hellgruen;
handles.ZaehlerBerechneteKennwerte = handles.ZaehlerBerechneteKennwerte + 1;
if handles.ZaehlerBerechneteKennwerte == 5
    set(handles.uipanel9,'backgroundcolor',hellgruen)
    set(handles.uipanel9,'highlightcolor',hellgruen)
    set(handles.uipanel9,'shadowcolor',hellgruen)
    set(handles.uipanel9,'foregroundcolor',hellgruen)
end
%     zt = handles.ZaehlerBerechneteKennwerte;
%     zt = num2str(zt);
%     message = sprintf(zt);
%     questdlg(message, 'Zur Kenntnis genommen?', 'Yes', 'No', 'No');

step = 10;
waitbar(step/steps);
delete(hb);

guidata(hObject, handles);

automatisch = get(handles.CheckAutomatischeBerechnung, 'value'); %Checkboxen
if automatisch == 0
    FertigExport_Callback(hObject, eventdata, handles)
end
function Kennwert6_Callback(hObject, eventdata, handles)
function pushbutton79_Callback(hObject, eventdata, handles)
function HilfeKennwert1_Callback(hObject, eventdata, handles)
openfig('Kennwert1_Hilfe','new')
function HilfeKennwert2_Callback(hObject, eventdata, handles)
openfig('Kennwert2_Hilfe','new')
function HilfeKennwert3_Callback(hObject, eventdata, handles)
openfig('Kennwert3_Hilfe','new')
function HilfeKennwert4_Callback(hObject, eventdata, handles)
openfig('Kennwert4_Hilfe','new')
function HilfeKennwert5_Callback(hObject, eventdata, handles)
openfig('Kennwert5_Hilfe','new')
function HilfeKennwert6_Callback(hObject, eventdata, handles)
openfig('Kennwert6_Hilfe','new')
function pushbutton86_Callback(hObject, eventdata, handles)
kill2;
function Kennwert1_CreateFcn(hObject, eventdata, handles)
function CheckAutomatischeBerechnung_Callback(hObject, eventdata, handles)
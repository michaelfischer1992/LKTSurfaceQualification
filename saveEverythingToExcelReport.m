function saveEverythingToExcelReport(handles)

figure
C = imfuse(handles.imgOriginal, results.coloredLabels, 'montage');
D = imfuse(C, results.coloredLabels, 'blend');
imshow(D)
thisFile = mfilename('fullpath');
[thisFolder,~] = fileparts(thisFile);
DefaultName = sprintf('%s_MaterialinselnOverlay.tif',datestr8601);
fullImageFileName1 = fullfile(thisFolder, [DefaultName]);
export_fig(gcf, fullImageFileName1, '-r300', '-transparent')


%%

%% Kennwerte Teil 1 - Kennwerte-Dokument erstellen

OffeneWorkbooks


% Template kopieren
Excel=actxserver('Excel.Application');
Excel.Visible = -1;

currentFolder = pwd;
SH=Excel.ActiveSheet; %active sheet of template Workbook

% The following makes a copy of the sheet, but to a new Workbook.
invoke(SH,'Copy')
nWB=Excel.ActiveWorkbook; %new Workbook
xFilename = strcat('20170615_kennwerte_template.xlsm');

% neues Workbook abspeichern
FilterSpec = {'*.xlsx', 'Excel Files (*.xlsx)'; '*.xls', 'Excel Files (*.xls)'; '*.*', 'All Files (*.*)'};
DialogTitle = 'Save excel sheet file name';
DefaultName = sprintf('%s_Kennwerte',strjoin(handles.BildName,''));


if exist(xFilename)
    savedPath=pwd;
    currentPath = fileparts(xFilename);
    cd(savedPath);
    [fileName, specifiedFolder] = uiputfile(FilterSpec, DialogTitle, DefaultName);
    cd(savedPath);
    xFilename=[specifiedFolder,fileName];
    x.DisplayAlerts = 0;
    nWB.SaveAs(xFilename);
    x.DisplayAlerts = 1;
else
    nWB.SaveAs(xFilename,1)
end


handles.ExcelKennwerte = fileName;


% beide Dokumente schlieueen
system('taskkill /F /IM EXCEL.EXE');

% % template schlieueen - funktioniert nur, wenn ICH die files manuell ueffne
% - ansonsten wird immer 0 zurueckggeben (Datei "wuere" geschlossen).
% isopen = xls_check_if_open('20170615_kennwerte_template.xlsx','close'); % Template wieder schlieueen
% % neues Blatt schlieueen, damit es beschrieben werden kann
% isopen = xls_check_if_open(DefaultName,'close'); % Template wieder schlieueen


%% Kennwerte Teil 2 - Kennwerte-Dokument fuellen

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



% Gesamtflueche und Verhueltnis ins Excel-Blatt schreiben
% hExcel = actxserver('Excel.Application');
% currentFolder = pwd;
filename = fileName;
A = cellstr(sprintf('%s%s', strjoin({num2str(poren_gesamtflaeche),' px'},'')));
B = AusgabeVerhaeltnis;
sheet = 1;
xlRange1 = 'R18';
xlRange2 = 'V18';
xlswrite(filename,A,sheet,xlRange1)
xlswrite(filename,B,sheet,xlRange2)

A = cellstr(get(handles.BreiteBildText,'String'));
B = cellstr(get(handles.LaengeOberflaecheText,'String'));
C = cellstr(get(handles.BreiteLaengeText,'String'));
xlswrite(filename,B,sheet,'K26')
xlswrite(filename,A,sheet,'K27')
% xlswrite(filename,C,sheet,'K28')

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
    xlRange = [xlcolumnletter(17+2*j-2),num2str(19)];
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

left1 = Sheet1.Range('Q3').Left + 2.5;
top1 = Sheet1.Range('Q3').Top +5;
left2 = Sheet1.Range('U3').Left + 2.5;
top2 = Sheet1.Range('U3').Top + 5;
left3 = Sheet1.Range('Q4').Left + 5;
top3 = Sheet1.Range('Q4').Top + 5;
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


%% Kennwerte Teil 3 - Daten-Workbook erstellen


% Template kopieren
Excel=actxserver('Excel.Application');
Excel.Visible = -1;

currentFolder = pwd;
WB=invoke(Excel.Workbooks,'open',[currentFolder, '\20170615_daten_template.xlsx']);
SH=Excel.ActiveSheet; %active sheet of template Workbook

% The following makes a copy of the sheet, but to a new Workbook.
invoke(SH,'Copy')
nWB=Excel.ActiveWorkbook; %new Workbook
xFilename = strcat('20170615_daten_template.xlsx');

% neues Workbook abspeichern
FilterSpec = {'*.xlsx', 'Excel Files (*.xlsx)'; '*.xls', 'Excel Files (*.xls)'; '*.*', 'All Files (*.*)'};
DialogTitle = 'Save excel sheet file name';
DefaultName = sprintf('%s_Daten',strjoin(handles.BildName,''));

if exist(xFilename)
    savedPath=pwd;
    cd(savedPath);
    [fileName, specifiedFolder] = uiputfile(FilterSpec, DialogTitle, DefaultName);
    cd(savedPath);
    xFilename=[specifiedFolder,fileName];
    x.DisplayAlerts = 0;
    nWB.SaveAs(xFilename);
    x.DisplayAlerts = 1;
else
    nWB.SaveAs(xFilename,1)
end

% beide Dokumente schlieueen
system('taskkill /F /IM EXCEL.EXE');

handles.ExcelDaten = fileName;


%% Kennwerte Teil 4 - Daten-Workbook befuellen



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
    xlRange = [xlcolumnletter(16+5*j-5),num2str(6)];
    xlswrite(fileName,A,sheet,xlRange)
    if breakvalue == 1
        break;
    end
end



%% Part II


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



Workbook.SaveAs(fullfile(pwd,filename), xlWorkbookDefault)
Workbook2.SaveAs(fullfile(pwd,filename2), xlWorkbookDefault)
Workbook.Close(false)
invoke(Excel, 'Quit');
system('taskkill /F /IM EXCEL.EXE');

kill2
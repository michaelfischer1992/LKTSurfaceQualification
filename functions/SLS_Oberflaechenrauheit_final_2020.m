function app = SLS_Oberflaechenrauheit_final_2020(app)

%% paths
% adding paths from git
LKTPATH        = 'C:\git\LKTSurfaceQualification';
try
    cd(LKTPATH)
catch
    disp('Pull git repository "https://github.com/michaelfischer1992/LKTSurfaceQualification.git" to C:\git\')
    web('https://github.com/michaelfischer1992/LKTSurfaceQualification')
    error('Get git repository first. Path mentioned previously.')
end
app.ConfigParams.workingDirectory = [];
app.ConfigParams.importDirectory = [];
app.ConfigParams.savingDirectory = [];
app.ConfigParams.currentFolder = pwd;
app.ConfigParams.guiImagesPath = [app.ConfigParams.currentFolder, '\gui_pics'];
app.ConfigParams.logfiles = [app.ConfigParams.currentFolder, '\log_files'];
app.ConfigParams.exportPath = [app.ConfigParams.currentFolder, '\export'];
app.ConfigParams.functionPath = [app.ConfigParams.currentFolder, '\functions'];
app.ConfigParams.functionPath2017 = [app.ConfigParams.currentFolder, '\functions\from2017'];
app.ConfigParams.imagePath = [app.ConfigParams.currentFolder, '\images'];
addpath(app.ConfigParams.exportPath);
addpath(app.ConfigParams.logfiles);
addpath(app.ConfigParams.guiImagesPath);
addpath(app.ConfigParams.functionPath);
addpath(app.ConfigParams.functionPath2017);
addpath(app.ConfigParams.imagePath);

%% parameters
app.ConfigParams.doPlot = 0;
app.ConfigParams.captionFontSize = 14;
app.ConfigParams.doPlot4Debug = 0;
app.ConfigParams.programMode = 'single image'; % 'single image', 'multiple images'
app.ConfigParams.erosionType = 'diamond';
app.ConfigParams.erosionValue = 2;
app.ConfigParams.pixelsWidthCheckIfPore = 40; % just to make sure that no hard coded vals in code
app.ConfigParams.SurfaceRoughnessSections = 50; % surface Roughness
app.ConfigParams.maxSizeOfImage = 4000000; % equals size of 2000 x 2000 pixel -- everything larger get's scaled down when in fastMode
app.ConfigParams.fastMode = 0; % scaling down, if image is too big
app.ConfigParams.plot4Debug = 0; 
app.ConfigParams.erosionType = []; 
app.ConfigParams.erosionValue = []; 
% colors
app.ConfigParams.gruen=[0.78 0.88 0.58];
app.ConfigParams.hellgruen=[0.73	0.88	0.48];
app.ConfigParams.dunkelrot=[0.64	0.08	0.18];
app.ConfigParams.hellrot=[0.93	0.41	0.50];
app.ConfigParams.grau=[0.50	0.50	0.50];
app.ConfigParams.schwarz=[0	0	0];
app.ConfigParams.rosa=[1.00	0.80	0.80];
% iamge
app.Data.BildPfad = [];
app.Data.BildName = 0;
app.Data.BildNamePlusExtention = 0;
app.Data.imgBW = 0;
app.Data.imgBWnoScale = 0;
app.Data.imgEroded = 0;
app.Data.imgErod = 0; % ausgerichtetes Erodiertes Bild
app.Data.imgOriginal = 0;
app.Data.imgOrig = 0; % ausgerichtetes Originalbild
app.Data.overallResults = [];
app.Data.hintergrundwert = [];
app.Data.materialwert = [];
app.Data.schwellwert = [];
app.Data.imageWidth = [];
app.Data.imageHeight = [];
app.Data.yValsRectScale = [];
app.Data.xValsRectScale = [];
app.Data.MassstabYVals = [];
app.Data.MassstabXVals = [];

% surface
app.Data.realeKonturX = 0;
app.Data.realeKonturY = 0;
app.Data.aufKontur = 0;
app.Data.FlaecheHinterschneidung = 0;
app.Data.Pz_Wert = 0;
% scale
app.Data.MassstabLinksPosX = 0;
app.Data.MassstabLinksPosY = 0;
app.Data.MassstabRechtsPosX = 0;
app.Data.MassstabRechtsPosY = 0;
app.Data.MassstabWert = 1;
app.Data.MassstabEinheit = 'px';
app.Data.LengthScaleEditField = 50; % mycrometer - Massstab
app.Data.MassstabLaenge = 50; % mycrometer - Massstab

% diary
diaryFile = fullfile(app.ConfigParams.logfiles, [datestr8601, '_log.txt']);
diary(diaryFile)
diary on


diary off
%% 
%% EOF 
%% 




% figure
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% 
% subplot(1, 3, 1)
% imshow(app.imgOriginal(:, 1:1000,  :))
% title('RGB image original')
% 
% subplot(1, 3, 2)
% imshow(app.imgEroded  (:, 1:1000))
% title('BW image original')
% 
% subplot(1, 3, 3)
% imshow(imOrig(:, 1:1000, :))
% title('Morphologically closed')
end







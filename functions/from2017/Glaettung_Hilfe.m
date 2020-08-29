function varargout = Glaettung_Hilfe(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Glaettung_Hilfe_OpeningFcn, ...
                   'gui_OutputFcn',  @Glaettung_Hilfe_OutputFcn, ...
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
function Glaettung_Hilfe_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = Glaettung_Hilfe_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
function ExitButton_Callback(hObject, eventdata, handles)
    delete(gcbf);
function text2_CreateFcn(hObject, eventdata, handles)
%Erzeugt Hyperlink
labelStr = '<html><center><a href="">Erosion<br>Wikipedia.de';
cbStr = 'web(''https://de.wikipedia.org/wiki/Erosion'');';
hButton = uicontrol('string',labelStr,'pos',[20,20,100,35],'callback',cbStr);
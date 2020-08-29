function varargout = OrigBild_Hilfe(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OrigBild_Hilfe_OpeningFcn, ...
                   'gui_OutputFcn',  @OrigBild_Hilfe_OutputFcn, ...
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
function OrigBild_Hilfe_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = OrigBild_Hilfe_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
function exitButton_Callback(hObject, eventdata, handles)
    delete(gcbf);    


function varargout = base_gui(varargin)
% BASE_GUI MATLAB code for base_gui.fig
%      BASE_GUI, by itself, creates a new BASE_GUI or raises the existing
%      singleton*.
%
%      H = BASE_GUI returns the handle to a new BASE_GUI or the handle to
%      the existing singleton*.
%
%      BASE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASE_GUI.M with the given input arguments.
%
%      BASE_GUI('Property','Value',...) creates a new BASE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before base_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to base_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help base_gui

% Last Modified by GUIDE v2.5 17-Jun-2016 15:38:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @base_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @base_gui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before base_gui is made visible.
function base_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to base_gui (see VARARGIN)

% Choose default command line output for base_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes base_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = base_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_btn.
function load_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname dname] = uigetfile('.txt','Select the Experiment File');

file= fopen(fullfile(dname,fname));
[information,value]= textscan(file,'%s %s');

if(char(information{1,2}) == 'Pearl')
    [images700,images800,imagesWhite]=script_pearl_data(dname);
    handles.image1=images700;
    handles.image2=images800;
    handles.imageWhite=imagesWhite;
    handles.current_image = 1;
    
    imagesc(handles.image1{handles.current_image},'Parent',handles.axes1);
    imagesc(handles.image2{handles.current_image},'Parent',handles.axes2);
end
guidata(hObject,handles);


% --- Executes on button press in previous_btn.
function previous_btn_Callback(hObject, eventdata, handles)
% hObject    handle to previous_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.current_image = handles.current_image - 1;

imagesc(handles.image1{handles.current_image},'Parent',handles.axes1);
imagesc(handles.image2{handles.current_image},'Parent',handles.axes2);

guidata(hObject,handles);

% --- Executes on button press in next_btn.
function next_btn_Callback(hObject, eventdata, handles)
% hObject    handle to next_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_image = handles.current_image + 1;

imagesc(handles.image1{handles.current_image},'Parent',handles.axes1);
imagesc(handles.image2{handles.current_image},'Parent',handles.axes2);

guidata(hObject,handles);


% --- Executes on button press in helpButton.
function helpButton_Callback(hObject, eventdata, handles)
% hObject    handle to helpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

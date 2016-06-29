function varargout = load_gui(varargin)
% LOAD_GUI MATLAB code for load_gui.fig
%      LOAD_GUI, by itself, creates a new LOAD_GUI or raises the existing
%      singleton*.
%
%      H = LOAD_GUI returns the handle to a new LOAD_GUI or the handle to
%      the existing singleton*.
%
%      LOAD_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_GUI.M with the given input arguments.
%
%      LOAD_GUI('Property','Value',...) creates a new LOAD_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before load_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to load_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help load_gui

% Last Modified by GUIDE v2.5 27-Jun-2016 16:28:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @load_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @load_gui_OutputFcn, ...
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


% --- Executes just before load_gui is made visible.
function load_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to load_gui (see VARARGIN)

% Choose default command line output for load_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes load_gui wait for user response (see UIRESUME)
% uiwait(handles.load_gui);


% --- Outputs from this function are returned to the command line.
function varargout = load_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in dropdown.
function dropdown_Callback(hObject, eventdata, handles)
% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdown


% --- Executes during object creation, after setting all properties.
function dropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in white_checkbox.
function white_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to white_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of white_checkbox



function channel1_Callback(hObject, eventdata, handles)
% hObject    handle to channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel1 as text
%        str2double(get(hObject,'String')) returns contents of channel1 as a double


% --- Executes during object creation, after setting all properties.
function channel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function channel2_Callback(hObject, eventdata, handles)
% hObject    handle to channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel2 as text
%        str2double(get(hObject,'String')) returns contents of channel2 as a double


% --- Executes during object creation, after setting all properties.
function channel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_gui_btn.
function load_gui_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_gui_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%read the value of the popup menu
contents = get(handles.dropdown,'String'); 
experimentType = contents{get(handles.dropdown,'Value')};

%read the values of the channels
channel1 = get(handles.channel1,'String');
channel2 = get(handles.channel2,'String');

%See if has White image in the checkbox
hasWhite= get(handles.white_checkbox,'Value');

switch experimentType
    case 'Pearl'
        [imgArray700, imgArray800, imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]=script_pearl_data(handles.experimentFolders,handles.prescanFolder,channel1,channel2,hasWhite);        
end

handles.imgArray700=imgArray700;
handles.imgArray800=imgArray800;
handles.imgArrayWhite=imgArrayWhite;
handles.prescanImg700=prescanImg700;
handles.prescanImg800=prescanImg800;
handles.prescanImgWhite=prescanImgWhite;
handles.hasWhite=hasWhite;
handles.numberOfScans=numberOfScans;

disp(handles.numberOfScans);

%save the new handles
guidata(hObject,handles);

myStruct=guidata(hObject);

%0 for root | 'MyStruct' the name for the root to get | myStruct the variable that is givent to 'myStruct'
setappdata(0,'MyStruct',myStruct); 

close;









% --- Executes on button press in browse_prescan.
function browse_prescan_Callback(hObject, eventdata, handles)
% hObject    handle to browse_prescan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%select folders with experiment data
prescanFolder=uigetfile_n_dir;

%insert folders in handles
handles.prescanFolder=prescanFolder;

%show the path of folders in the static text
set(handles.text8,'String',prescanFolder);
 
%save the new handles
guidata(hObject,handles);


% --- Executes on button press in browse_folders.
function browse_folders_Callback(hObject, eventdata, handles)
% hObject    handle to browse_folders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%select folders with experiment data
experimentFolders=uigetfile_n_dir;

%insert folders in handles
handles.experimentFolders=experimentFolders;

%show the path of folders in the static text
set(handles.text9,'String',experimentFolders);
 
%save the new handles
guidata(hObject,handles);







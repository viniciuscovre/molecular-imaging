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

% Last Modified by GUIDE v2.5 29-Jun-2016 15:17:21

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
handles = guidata(hObject);
%read the value of the popup menu

contents = get(handles.dropdown,'String');
handles.experimentType = contents{get(handles.dropdown,'Value')};

switch handles.experimentType
    case 'Pearl'
        set(handles.text1,'String','Prescan Image Folder');
        set(handles.text2,'String','Experiment Folders');
        set(handles.text3,'String','White Image');
        set(handles.text4,'String','Targeted Channel Name');
        set(handles.text4,'Visible','on');
        set(handles.text5,'String','Control Channel Name');
        set(handles.text5,'Visible','on');
        set(handles.field1,'Visible','on');
        set(handles.field2,'Visible','on');
        set(handles.field3,'Visible','off');
        set(handles.field4,'Visible','on');
        set(handles.field5,'Visible','on');
        set(handles.browse1,'Visible','on');
        set(handles.browse2,'Visible','on');
        set(handles.browse3,'Visible','off');
    case 'AVI'
        set(handles.text1,'String','Targeted AVI File');
        set(handles.text2,'String','Control AVI File');
        
        set(handles.text4,'Visible','off');
        set(handles.text5,'Visible','off');
        set(handles.field4,'Visible','off');
        set(handles.field5,'Visible','off');
end

guidata(hObject, handles)

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


% --- Executes on button press in checkboxWhiteImage.
function checkboxWhiteImage_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxWhiteImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxWhiteImage
hasWhite= get(handles.checkboxWhiteImage,'Value');
if hasWhite && strcmp(handles.dropdown,'AVI')
    set(handles.field3,'Visible','on');
    set(handles.browse3,'Visible','on');
else
    set(handles.field3,'Visible','off');
    set(handles.browse3,'Visible','off');
end


function field4_Callback(hObject, eventdata, handles)
% hObject    handle to field4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of field4 as text
%        str2double(get(hObject,'String')) returns contents of field4 as a double


% --- Executes during object creation, after setting all properties.
function field4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to field4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function field5_Callback(hObject, eventdata, handles)
% hObject    handle to field5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of field5 as text
%        str2double(get(hObject,'String')) returns contents of field5 as a double


% --- Executes during object creation, after setting all properties.
function field5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to field5 (see GCBO)
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

%read the values of the channels
channel1 = get(handles.field4,'String');
channel2 = get(handles.field5,'String');

%See if has White image in the checkbox
hasWhite= get(handles.checkboxWhiteImage,'Value');


contents = get(handles.dropdown,'String');
handles.experimentType = contents{get(handles.dropdown,'Value')}


switch handles.experimentType
    case 'Pearl'
        if hasWhite
            [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]=script_pearl_data(handles.experimentFolders,handles.prescanFolder,channel1,channel2,hasWhite);
        else
            [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]=script_pearl_data(handles.experimentFolders,handles.prescanFolder,channel1,channel2,hasWhite);
        end
            pearlHandles= struct([]);
            pearlHandles(1).type= 'Pearl';
            pearlHandles.imgArray700=imgArray700;
            pearlHandles.imgArray800=imgArray800;
            pearlHandles.imgArrayWhite=imgArrayWhite;
            pearlHandles.prescanImg700=prescanImg700;
            pearlHandles.prescanImg800=prescanImg800;
            pearlHandles.prescanImgWhite=prescanImgWhite;
            pearlHandles.hasWhite=hasWhite;
            pearlHandles.numberOfScans=numberOfScans;

            myStruct=pearlHandles;

        
    case 'AVI'
        [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]...
            =script_avi_data(handles.experimentFolders,handles.prescanFolder,handles.browseWhite,hasWhite);
    case 'Odyssey'
        [imgArray700,imgArray800,imgArrayWhite,prescanImg700,prescanImg800,prescanImgWhite,hasWhite,numberOfScans]...
            =script_odyssey_data(handles.experimentFolders,handles.prescanFolder,channel1,channel2,hasWhite);
        
        odysseyHandles= struct([]);
        odysseyHandles(1).type= 'Pearl';
        odysseyHandles.imgArray700=imgArray700;
        odysseyHandles.imgArray800=imgArray800;
        odysseyHandles.imgArrayWhite=imgArrayWhite;
        odysseyHandles.prescanImg700=prescanImg700;
        odysseyHandles.prescanImg800=prescanImg800;
        odysseyHandles.prescanImgWhite=prescanImgWhite;
        odysseyHandles.hasWhite=hasWhite;
        odysseyHandles.numberOfScans=numberOfScans;
        
        myStruct=odysseyHandles;
end




%0 for root | 'MyStruct' the name for the root to get | myStruct the variable that is givent to 'myStruct'
setappdata(0,'MyStruct',myStruct);

close;









% --- Executes on button press in browse1.
function browse1_Callback(hObject, eventdata, handles)
% hObject    handle to browse1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%select folders with experiment data
prescanFolder=uigetfile_n_dir;

%insert folders in handles
handles.prescanFolder=prescanFolder;

%show the path of folders in the static text
set(handles.field1,'String',prescanFolder);

%save the new handles
guidata(hObject,handles);


% --- Executes on button press in browse2.
function browse2_Callback(hObject, eventdata, handles)
% hObject    handle to browse2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%select folders with experiment data
experimentFolders=uigetfile_n_dir;

%insert folders in handles
handles.experimentFolders=experimentFolders;

%show the path of folders in the static text
set(handles.field2,'String',experimentFolders);

%save the new handles
guidata(hObject,handles);

% --- Executes on button press in browse3.
function browse3_Callback(hObject, eventdata, handles)
% hObject    handle to browse3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%select folders with experiment data
browseWhite=uigetfile_n_dir;

%insert folders in handles
handles.browseWhite=browseWhite;

%show the path of folders in the static text
set(handles.field3,'String',browseWhite);

%save the new handles
guidata(hObject,handles);

function field3_Callback(hObject, eventdata, handles)
% hObject    handle to field3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of field3 as text
%        str2double(get(hObject,'String')) returns contents of field3 as a double


% --- Executes during object creation, after setting all properties.
function field3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to field3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

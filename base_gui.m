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

% Last Modified by GUIDE v2.5 09-Jul-2016 15:48:11

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

% add a continuous value change listener
if ~isfield(handles,'hListener')
    handles.hListener = ...
        addlistener(handles.image_slider,'ContinuousValueChange',@respondToContSlideCallback);
end


%creation of the struct to hold all the experiment data from any kind
experimentHandles= struct([]);
experimentHandles(1).type= '';
experimentHandles.target=0;
experimentHandles.control=0;
experimentHandles.white=0;
experimentHandles.prescanTarget=0;
experimentHandles.prescanControl=0;
experimentHandles.prescanWhite=0;
experimentHandles.hasWhite=0;
experimentHandles.numberOfScans=0;

%save the experiment struct in the root of the program
setappdata(0,'experimentHandles',experimentHandles);


% UIWAIT makes base_gui wait for user response (see UIRESUME)
% uiwait(handles.base_gui);

% Update handles structure
guidata(hObject, handles);


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

%run script to load the experiment data to program

%wait for load_gui close
uiwait(load_gui);

% get the data from the experiment struct
experimentHandles=getappdata(0,'experimentHandles');


%configuration of the slider
set(handles.image_slider, 'Min', 1);
set(handles.image_slider, 'Max', experimentHandles.numberOfScans);
set(handles.image_slider, 'SliderStep', [1/(experimentHandles.numberOfScans-1) , 1/(experimentHandles.numberOfScans-1) ]);
set(handles.image_slider, 'Value', 1);

% save the current/last slider value
handles.lastSliderVal = get(handles.image_slider,'Value');
set(handles.textNum,'String',num2str(get(handles.image_slider,'Value')));

% show images in the axes of GUI
%     imagesc(experimentHandles.target(:,:,1,get(hObject,'Value')),'Parent',handles.targetAxes);
%     imagesc(experimentHandles.control(:,:,1,get(hObject,'Value')),'Parent',handles.controlAxes);
%     if experimentHandles.hasWhite
%         imagesc(experimentHandles.white(:,:,1,get(hObject,'Value')),'Parent',handles.whiteAxes);
%     end
%         imagesc(experimentHandles.prescanTarget,'Parent',handles.prescanAxes);

%call script to show images
plot_images;

%save the new handles
guidata(hObject,handles);


% --- Executes on button press in helpButton.
function helpButton_Callback(hObject, eventdata, handles)
% hObject    handle to helpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function image_slider_Callback(hObject, eventdata, handles)
% hObject    handle to image_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function image_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function respondToContSlideCallback(hObject, eventdata)

% get the data from the experiment struct
experimentHandles=getappdata(0,'experimentHandles');

% first we need the handles structure which we can get from hObject
handles = guidata(hObject);

newVal = floor(get(hObject,'Value'));

% set the slider value to this integer which will be in the set {1,2,3,...,12,13}
set(hObject,'Value',newVal);

% now only do something in response to the slider movement if the
% new value is different from the last slider value

if newVal ~= handles.lastSliderVal
    
    % save the new value
    handles.lastSliderVal = newVal;
    
    % display the current value of the slider
    set(handles.textNum,'String',num2str(get(hObject,'Value')));
    guidata(hObject,handles);
    
    %call script to show images
    plot_images;
end



% --- Executes on button press in rigidCheckbox.
function rigidCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to rigidCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rigidCheckbox


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in BGSubtraction.
function BGSubtraction_Callback(hObject, eventdata, handles)
% hObject    handle to BGSubtraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BGSubtraction


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in preprocessingApply.
function preprocessingApply_Callback(hObject, eventdata, handles)
% hObject    handle to preprocessingApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the data from the experiment struct
experimentHandles=getappdata(0,'experimentHandles');

%get the actual value of the Rigid checkbox
rigid= get(handles.rigidCheckbox,'Value');

%get the actual value of the BGSubtraction checkbox
BGSubtraction= get(handles.BGSubtractionCheckbox,'Value');

% CODE FOR RIGID MOTION CORRECTION
%case rigid is checked and experiment struct has white image
if rigid && experimentHandles.hasWhite
    for i=1:length(experimentHandles.numberOfScans)
        [experimentHandles.target(:,:,1,i),experimentHandles.control(:,:,1,i)]=coregis_2(experimentHandles.target(:,:,1,i),experimentHandles.control(:,:,1,i),experimentHandles.white(:,:,1,i));
    end
    
    %update control and target images in struct
    setappdata(0,'experimentHandles',experimentHandles);
    
    %call script to show images
    plot_images;
    
    %write applied filters in the textbox
    set(handles.filtersText,'String',get(handles.rcloseigidCheckbox,'String'));
    
    %case rigid is checked but experiment struct doesn't have white image
elseif rigid
    errordlg('This filter requires a white image','Missing files','modal');
end

% CODE FOR BG SUBTRACTION
if BGSubtraction
       for i=1:length(experimentHandles.numberOfScans)
           experimentHandles.target(:,:,1,i)=imsubtract(experimentHandles.target(:,:,1,i), experimentHandles.prescanTarget);
           experimentHandles.control(:,:,1,i)=imsubtract(experimentHandles.control(:,:,1,i), experimentHandles.prescanControl);
       end
end

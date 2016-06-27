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

% Last Modified by GUIDE v2.5 27-Jun-2016 15:11:56

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
    
   
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes base_gui wait for user response (see UIRESUME)
% uiwait(handles.base_gui);


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
    load_experiment;
    
    %inclue the output of load to handles to be available in all gui
    handles.image1=images700;
    handles.image2=images800;
    if hasWhite
        handles.imageWhite=imagesWhite;
    end
    
    set(handles.image_slider, 'Min', 1);
    set(handles.image_slider, 'Max', numberOfScans);
    set(handles.image_slider, 'SliderStep', [1/(numberOfScans-1) , 1/(numberOfScans-1) ]);
    set(handles.image_slider, 'Value', 1);
    
    % save the current/last slider value
    handles.lastSliderVal = get(handles.image_slider,'Value');
    set(handles.textNum,'String',num2str(get(handles.image_slider,'Value')));
    
    % show images in the axes of GUI
    imagesc(handles.image1(:,:,1,get(hObject,'Value')),'Parent',handles.axes1);
    imagesc(handles.image2(:,:,1,get(hObject,'Value')),'Parent',handles.axes2);
    
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
         
         imagesc(handles.image1(:,:,1,get(hObject,'Value')),'Parent',handles.axes1);
         imagesc(handles.image2(:,:,1,get(hObject,'Value')),'Parent',handles.axes2);
    end
    

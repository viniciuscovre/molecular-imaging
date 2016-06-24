function varargout = PS_frame(varargin)
%%
%PS_FRAME M-file for PS_frame.fig
%      PS_FRAME, by itself, creates a new PS_FRAME or raises the existing
%      singleton*.
%
%      H = PS_FRAME returns the handle to a new PS_FRAME or the handle to
%      the existing singleton*.
%
%      PS_FRAME('Property','Value',...) creates a new PS_FRAME using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PS_frame_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PS_FRAME('CALLBACK') and PS_FRAME('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PS_FRAME.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PS_frame

% Last Modified by GUIDE v2.5 16-Oct-2015 14:21:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PS_frame_OpeningFcn, ...
                   'gui_OutputFcn',  @PS_frame_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before PS_frame is made visible.
function PS_frame_OpeningFcn(hObject, eventdata, handles, varargin)
%%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for PS_frame
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PS_frame wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PS_frame_OutputFcn(hObject, eventdata, handles)
%%
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
%%
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of
%        slider
handles.h=round(get(hObject,'Value'));
image(handles.im_stack(:,:,handles.h), 'CDataMapping', 'scaled');colormap(jet);axis image;axis off;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
%%
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%%
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%display & select area
%% Display curves
t=handles.t;im_stack=handles.im_stack;
[art_curve, mask, mask_size] = ROI_curve_display(im_stack, t, im_stack(:,:,handles.h), 'Select Artery');
[vein_curve, mask3, mask_size3] = ROI_curve_display(im_stack, t,im_stack(:,:,handles.h), 'Select Vein');
[tis_curve, mask2, mask_size2] = ROI_curve_display(im_stack, t,im_stack(:,:,handles.h), 'Select Tissue');

% Plot curves figure 4
figure;plot(t, art_curve, 'r', t, vein_curve, 'b', t, tis_curve, 'g');
% Shift arterial curve back figure 5
shift = 20;
art_curve_s = interp1(t-shift*(t(2)-t(1)),art_curve,t, 'cubic','extrap');
figure;plot(t, art_curve_s/sum(art_curve_s), 'r', t, tis_curve/sum(tis_curve), 'b');
% Interpolate to 0.2 s resolution?  figure 6

t_s = 0.2:0.2:t(end);
art_curve_i = interp1(t, art_curve_s,t_s,'linear','extrap');
tis_curve_i = interp1(t, tis_curve,t_s,'linear','extrap');

figure;plot(t_s,tis_curve_i,'r',t,tis_curve,'b');
z = size(im_stack,3);

% Find max of tissue curve for fitting range

[tis_pk_val tis_pk_loc] = max(tis_curve_i(1:floor(t(z))/0.2));
stp_fit = round(tis_pk_loc - round(2.5/(t_s(2)-t_s(1))));
ept_fit = round(tis_pk_loc + round(5/(t_s(2)-t_s(1))));

% Tissue Curve Blood Flow Analysis figure 7.8.9
options = optimset('Display','off','MaxFunEvals',10000,'TolFun',1.0000e-12,'TolX',1.0000e-12,'MaxIter',100000); % Optimization parameters
curve_params_vsimp = fminsearchbnd(@search_boxcar, [10 2 0.5], [0 0.2 0.2], [100 3 10], options, t_s, tis_curve_i, art_curve_i, t_s(2)-t_s(1),stp_fit, ept_fit)
curve_params_simp = fminsearchbnd(@search_AATH, [curve_params_vsimp(1) curve_params_vsimp(2) curve_params_vsimp(3) 0.1 0.1], [curve_params_vsimp(1) curve_params_vsimp(2) curve_params_vsimp(3)/2 0 0], [curve_params_vsimp(1)*5/4 curve_params_vsimp(2) curve_params_vsimp(3) 10 10], options, t_s, tis_curve_i, art_curve_i, t_s(2)-t_s(1),tis_pk_loc+30, numel(t_s))
curve_params_simp2 = fminsearchbnd(@search_AATH, curve_params_simp, [curve_params_vsimp(1)+1 curve_params_vsimp(2) curve_params_vsimp(3)/2 0 0.0001], [curve_params_vsimp(1)+20 curve_params_vsimp(2) curve_params_vsimp(3) 1 10], options, t_s, tis_curve_i, art_curve_i, t_s(2)-t_s(1),stp_fit,numel(t_s))
curve_params_simp3 = fminsearchbnd(@search_AATH, curve_params_simp, [curve_params_vsimp(1)+1 curve_params_vsimp(2) curve_params_vsimp(3)/2 0 0.0001], [curve_params_vsimp(1)+20 curve_params_vsimp(2) curve_params_vsimp(3) 1 10], options, t_s, tis_curve_i, art_curve_i, t_s(2)-t_s(1),stp_fit,floor(t(z)/0.2))
% Plotting Fit

% [Q_g R_g] = genTH_E_hetero_2C(t, curve_params, art_curve, dt);
[Q_g5 R_g5] = gen_AATH(t_s, curve_params_simp3, art_curve_i, t_s(2)-t_s(1));
[Q_g3 R_g3] = gen_boxcar(t_s, curve_params_vsimp, art_curve_i, t_s(2)-t_s(1));
[Q_g4 R_g4] = gen_AATH(t_s, curve_params_simp2, art_curve_i, t_s(2)-t_s(1));

figure;plot(t_s, Q_g3, 'r', t_s, tis_curve_i, 'b*');title('Fit results of boxcar model')
figure;plot(t_s, Q_g4, 'r', t_s, tis_curve_i, 'b*');title('Fit results of simple model 2')
figure;plot(t_s, Q_g5, 'r', t_s, tis_curve_i, 'b*');title('Fit results of simple model 3')

%% Mapping Parameters

F_m = zeros(256);
ta_m = zeros(256);
mtt_m = zeros(256);
E_m = zeros(256);
ke_m = zeros(256);

%{
for n = 1:size(im_stack,1)
    display(n)
    for m = 1:size(im_stack,2)
        [F_m(n,m), ta_m(n,m), mtt_m(n,m), E_m(n,m), ke_m(n,m)] = AATH_analyzer(t,art_curve_s,squeeze(im_stack(n,m,:)));
    end
end
%Saving
save([handles.dname 'Parametric_maps.mat'],'F_m','ta_m','mtt_m','E_m','ke_m')

guidata(hObject,handles);
%}
% --- Executes on button press in pushbutton2.

function pushbutton2_Callback(hObject, eventdata, handles)
%%
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dname = uigetdir('/Users/guest/Downloads/IIT/project/', 'Choose folder containing scans to be analyzed');
folders = dir(dname);
folders = folders(arrayfun(@(x) x.name(1), folders) ~= '.');
movie_names = folders(arrayfun(@(x) x.name(end), folders) == 'i');
% Read .mov file
for n = 1:numel(movie_names)
    temp = movie_names(n).name;
    i=strfind(temp,'A');
    if temp(i) == 'A'
        display(temp)
        [imstack_pre,handles.t] = moviereader([dname '/' movie_names(n).name]);
    end
end
imstack_ave = imstack_pre;

bk_sub = imstack_ave(:,:,1);
[r2, c2, z2] = size(imstack_ave);
handles.im_stack = zeros(r2,c2,z2);
for n = 1:z2
    handles.im_stack(:,:,n)=imstack_ave(:,:,n)-bk_sub;
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object deletion, before destroying properties.
function axes1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

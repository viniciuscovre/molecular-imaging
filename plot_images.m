%set the visible on of axes and text that actually have image

%target 
set(handles.targetText,'Visible','on');
set(handles.targetAxes,'Visible','on');

%control 
set(handles.controlText,'Visible','on');
set(handles.controlAxes,'Visible','on');

%white 
if experimentHandles.hasWhite
    set(handles.whiteText,'Visible','on');
    set(handles.whiteAxes,'Visible','on');
else
    set(handles.whiteText,'Visible','off');
    set(handles.whiteAxes,'Visible','off');
end

%prescan
set(handles.prescanText,'Visible','on');
set(handles.prescanAxes,'Visible','on');



imagesc(experimentHandles.target(:,:,1,get(hObject,'Value')),'Parent',handles.targetAxes);
    imagesc(experimentHandles.control(:,:,1,get(hObject,'Value')),'Parent',handles.controlAxes);
    if experimentHandles.hasWhite
        imagesc(experimentHandles.white(:,:,1,get(hObject,'Value')),'Parent',handles.whiteAxes);
    end
        imagesc(experimentHandles.prescanTarget,'Parent',handles.prescanAxes);

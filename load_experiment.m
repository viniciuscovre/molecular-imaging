%Select the text file with the experiment information


[fname dname] = uigetfile({'*.txt;*.rtf','Text-Files (*.txt,*.rtf)';...
    '*.mat','MAT-files (*.mat)';...
    '*.czi','CSZ-Files (*.czi)'},...
    'Select the Experiment File');

file = fopen(fullfile(dname,fname));

% Split file name and file type
[fname,ftype] = strtok(fname,'.');

if strcmp(lower(ftype),'.mat') % If user opens a .mat file
    
    load(strcat(fname,'.mat'));
    
    switch lower(type)
        case 'pearl'
            [images700,images800,imagesWhite] = script_pearl_data(dname);
        case 'csz'
            % code for script_csz
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
elseif strcmp(lower(ftype),'.czi')
    
    % code for script_csz
    
else % If user opens a text file
    
    [information,value] = textscan(file,'%s %s');

    % Code for getting the type in the text file for each OS
    if isunix
        type = information{1,2}{7,1}(1:end-1);
    elseif ispc
        type = char(information{1,2});
    else
        disp('Platform not supported')
    end
    
    switch lower(type)
        case 'pearl'
            [images700,images800,imagesWhite,textData]=script_pearl_data(dname);
        case 'csz'
            % code for script_csz
        otherwise
            h = msgbox('Invalid Type', 'Error','error');
            quit
    end
    
end
[fname dname] = uigetfile('.mat','Select info.mat File');

cd(dname(1:end-1));

load('info.mat');

if type == 'Pearl'
    [images700,images800,imagesWhite] = script_pearl_data(dname);
end
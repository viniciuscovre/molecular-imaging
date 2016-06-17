%Select the text file with the experiment information


[fname dname] = uigetfile('.txt','Select the Experiment File');

file= fopen(fullfile(dname,fname));
[information,value]= textscan(file,'%s %s');

if(char(information{1,2}) == 'Pearl')
    [images700,images800,imagesWhite]=script_pearl_data(dname);
end
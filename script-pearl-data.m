% MOTION CORRECTION USING COREGIS ALGORITHM

%   Script for motion correction of molecular images of tissues. It uses
%   Bio-Formats toolbox (bfopen) for data loading* and the Coregis
%   algorithm as part of the pre-processing part for motion correction.

%   * A series of images are taken from samples called Pearl Data where
%   each folder is a unit of time (of a series in time) that has 3 images:
%   a targeted image (800nm), a control image (700nm) and a white image
%   (used for comparison motion adjust). The extra txt file in the
%   directory is used to get the exact time unit used in each case, and
%   other details.
%
%   LOAD_PEARL_SERIES(DIR)

dialog_title = 'Select Pearl Data Directory';
start_path = 'C:\';
folder_name = uigetdir(start_path,dialog_title);
cd(folder_name);
details=cell(fix(0),fix(0));
image_folder = 'E:\image processing\sample image\512 - Copy\animal\New folder (2)'; %  Enter name of folder from which you want to upload pictures with full path
filenames = dir(fullfile(image_folder, '*.jpg'));  % read all images with specified extention, its jpg in our case
 total_images = numel(filenames);    % count total number of photos present in that folder
 for imn = 1:total_images
full_name= fullfile(image_folder, filenames(imn).name);         % it will specify images names with full path and extension
im= imread(full_name);                 % Read images  
sqr= imread(full_name); 
im_s= imread(full_name);
im_r = imread(full_name); 
Nfile=strcat(filenames(imn).name(1:size(filenames(imn).name,2)-3),'tiff');
K = imresize(im,[512 512]);
folder1='E:\image processing\sample image\512\common';
imwrite(K,fullfile(folder1,Nfile));
 end
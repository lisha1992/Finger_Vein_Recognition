function test
path = '/Volumes/LISHA/Enahncement/ROIFinger_0509_V3/';
fileFolder=fullfile(path);
dirOutput=dir(fullfile(fileFolder,'*.jpg'));
fileNames={dirOutput.name};
[m, n] =size(fileNames);

for i=32:n
    roi = imread(strcat(path, char(fileNames(i))));
    roi = imresize(roi, [100 300], 'bicubic');
    roi = averagefilter(roi, [3,3]);
    ex=10;
    dehaved = scattering_rem(roi, 0.999, ex);
    bw = 1.9;
    gb = gabor_filter(dehaved,bw,4,1);
            
    level=graythresh(gb);
    BW=im2bw(gb,level);
   
   
    figure;
    subplot(4,1,1);imshow(roi, []); title('The Original ROI');
    subplot(4,1,2);imshow(dehaved, []); title('Dehaved ROI');
    subplot(4,1,3);imshow(gb, []); title('Gabor');
    subplot(4,1,4);imshow(BW, []); title('OTSU');
  
    skel = burrs_removal(BW);

end
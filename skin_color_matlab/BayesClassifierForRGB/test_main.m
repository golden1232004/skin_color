%test_main:用于测试
clear;
clc;
% testPath = 'E:\projects\skin-color\image_color_diff';
% skinImageInfo= ReadImageInfo(testPath);     %定位目录，读取目录下所有图片信息
% skinImageNum = length(skinImageInfo);       %皮肤图像数目
% span = 1;
% ROW = 3;
% COLUMN = 6;
% for i=3:skinImageNum
%     imageStructInfo = skinImageInfo(i);   %每张图片结构信息
%     imageName = imageStructInfo.name;
%     loadImage = imread(strcat(testPath,'\',imageName));
%     hsvImage = rgb2hsv(loadImage);
% %     rgb = hsv2rgb(hsvImage);
%     subplot(ROW,COLUMN,1);
%     imshow(loadImage);
%     subplot(ROW,COLUMN,2)
%     imshow(hsvImage);
% 
%     h = hsvImage(:,:,1);
%     h_restore= h*360;
%     cirTime = floor (360/span);
%     
%     for j = 1: cirTime
%         tmp = h_restore +j*span;
%         new_h = rem(tmp,360);
%         hsvImage(:,:,1) = new_h/360;
%         rgbImage = hsv2rgb(hsvImage);
%         imwrite(rgbImage,strcat(testPath,'\',num2str(j),'.jpg'));
% 
%     end
%  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load bayesDataOfRGB.mat skinPDD nSkinPDD;
SKIN_PROBABILITY =0.4;  %皮肤概率:P(skin)
THRESHOLD =0.5;
HISTOGRAM_SIZE =256;      %灰度直方图大小
BIT_PER_CHANNEL = 8;      %每个通道表示的位数
SHOW_ROW = 2;    %用于显示
SHOW_COLUMN = 3 ;
% testPath = 'E:\projects\skin-color\image_samples';
testPath = 'E:\projects\skin-color\image_color_diff';
% testPath = 'E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinImageInfo= ReadImageInfo(testPath);     %定位目录，读取目录下所有图片信息
skinImageNum = length(skinImageInfo);       %皮肤图像数目
for i=3:skinImageNum
    imageStructInfo = skinImageInfo(i);   %每张图片结构信息
    imageName = imageStructInfo.name;
    
    loadImage = imread(strcat(testPath,'\',imageName));
    
    [h,w,s] = size(loadImage);
    compressedImage = imresize(loadImage,[h/2,w/2]);
    if s==3
        tic
        bayesImage_load = BayesClassifier( loadImage,SKIN_PROBABILITY,skinPDD,nSkinPDD,THRESHOLD,BIT_PER_CHANNEL,HISTOGRAM_SIZE );
        easyImage_load = EasyImageClassifier(loadImage);
        toc;
        tic;
        bayesImage_com = BayesClassifier( compressedImage,SKIN_PROBABILITY,skinPDD,nSkinPDD,THRESHOLD,BIT_PER_CHANNEL,HISTOGRAM_SIZE );
        easyImage_com = EasyImageClassifier(compressedImage);
        toc;
%         binaryBayesImage = im2bw(bayesImage,0.01);
        subplot(SHOW_ROW,SHOW_COLUMN,1);
        imshow(loadImage);
        title('original');
        subplot(SHOW_ROW,SHOW_COLUMN,2);
        imshow(bayesImage_load);
        title('BayesClassifier');
        subplot(SHOW_ROW,SHOW_COLUMN,3);
        imshow(easyImage_load);
        title('EasyClassifier');
        %压缩图
        subplot(SHOW_ROW,SHOW_COLUMN,4);
        imshow(compressedImage);
        title('compress');
        subplot(SHOW_ROW,SHOW_COLUMN,5);
        imshow(bayesImage_com);
        subplot(SHOW_ROW,SHOW_COLUMN,6);
        imshow(easyImage_com);
   
        
    end
end
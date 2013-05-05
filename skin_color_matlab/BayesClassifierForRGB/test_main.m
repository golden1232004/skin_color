%test_main:���ڲ���
clear;
clc;
% testPath = 'E:\projects\skin-color\image_color_diff';
% skinImageInfo= ReadImageInfo(testPath);     %��λĿ¼����ȡĿ¼������ͼƬ��Ϣ
% skinImageNum = length(skinImageInfo);       %Ƥ��ͼ����Ŀ
% span = 1;
% ROW = 3;
% COLUMN = 6;
% for i=3:skinImageNum
%     imageStructInfo = skinImageInfo(i);   %ÿ��ͼƬ�ṹ��Ϣ
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
SKIN_PROBABILITY =0.4;  %Ƥ������:P(skin)
THRESHOLD =0.5;
HISTOGRAM_SIZE =256;      %�Ҷ�ֱ��ͼ��С
BIT_PER_CHANNEL = 8;      %ÿ��ͨ����ʾ��λ��
SHOW_ROW = 2;    %������ʾ
SHOW_COLUMN = 3 ;
% testPath = 'E:\projects\skin-color\image_samples';
testPath = 'E:\projects\skin-color\image_color_diff';
% testPath = 'E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinImageInfo= ReadImageInfo(testPath);     %��λĿ¼����ȡĿ¼������ͼƬ��Ϣ
skinImageNum = length(skinImageInfo);       %Ƥ��ͼ����Ŀ
for i=3:skinImageNum
    imageStructInfo = skinImageInfo(i);   %ÿ��ͼƬ�ṹ��Ϣ
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
        %ѹ��ͼ
        subplot(SHOW_ROW,SHOW_COLUMN,4);
        imshow(compressedImage);
        title('compress');
        subplot(SHOW_ROW,SHOW_COLUMN,5);
        imshow(bayesImage_com);
        subplot(SHOW_ROW,SHOW_COLUMN,6);
        imshow(easyImage_com);
   
        
    end
end
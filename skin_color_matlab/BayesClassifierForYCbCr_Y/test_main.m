%test_main:用于测试
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load probabilityDensityDitribution_YCb_YCr.mat skinPDDofYCb skinPDDofYCr nSkinPDDofYCb nSkinPDDofYCr;
P_SKIN = 0.4; %皮肤概率
THRESHOLD =0.35;
BIT_PER_CHANNEL = 8;      %每个通道表示的位数
SHOW_ROW = 1;    %用于显示
SHOW_COLUMN = 2 ;
% testPath = 'E:\projects\skin-color\image_samples';
% testPath = 'E:\projects\skin-color\image_color_diff';
% testPath = 'E:\Job\code_repository\facedetect0426\build\bin\Debug\right_detect';
testPath = 'E:\Job\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinImageInfo= ReadImageInfo(testPath);     %定位目录，读取目录下所有图片信息
skinImageNum = length(skinImageInfo);       %皮肤图像数目
for i=3:skinImageNum
    imageStructInfo = skinImageInfo(i);   %每张图片结构信息
    imageName = imageStructInfo.name;
    imageFormat = GetImageFormat(imageName);
    if strcmp(imageFormat,'jpg')==1
        loadImage = imread(strcat(testPath,'\',imageName));
        [h,w,s] = size(loadImage);
        subplot(SHOW_ROW,SHOW_COLUMN,1);
        imshow(loadImage);
        title([imageName,' ',num2str(h),'*',num2str(w)]);
        
        if s==3
            tic;
            YCbCrImage = RGB2YCbCr(loadImage);
            transformTime = toc;
            fprintf('transformTime: %f\n',transformTime);
            tic;
            bayesImage_load = BayesClassifierOfYCbCr_Y( YCbCrImage,P_SKIN,skinPDDofYCb,skinPDDofYCr,nSkinPDDofYCb,nSkinPDDofYCr,THRESHOLD );
            calcBayesTime = toc;
            fprintf('calcBayesTime; %f\n',calcBayesTime);
            subplot(SHOW_ROW,SHOW_COLUMN,2);
            imshow(bayesImage_load);
            title(['Threshold:',num2str(THRESHOLD)]);
            
        end
    end
end
%test_main:���ڲ���
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load probabilityDensityDistribution.mat skinPDDofYCbCr nSkinPDDofYCbCr;
P_SKIN = 0.4; %Ƥ������
THRESHOLD =0.35;
BIT_PER_CHANNEL = 8;      %ÿ��ͨ����ʾ��λ��
SHOW_ROW = 1;    %������ʾ
SHOW_COLUMN = 2 ;
% testPath = 'E:\projects\skin-color\image_samples';
% testPath = 'E:\projects\skin-color\image_color_diff';
testPath = 'E:\Job\code_repository\facedetect0426\build\bin\Debug\right_detect';
skinImageInfo= ReadImageInfo(testPath);     %��λĿ¼����ȡĿ¼������ͼƬ��Ϣ
skinImageNum = length(skinImageInfo);       %Ƥ��ͼ����Ŀ
for i=3:skinImageNum
    imageStructInfo = skinImageInfo(i);   %ÿ��ͼƬ�ṹ��Ϣ
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
            bayesImage_load = BayesClassifierOfYCbCr( YCbCrImage,P_SKIN,skinPDDofYCbCr,nSkinPDDofYCbCr,THRESHOLD );
            calcBayesTime = toc;
            fprintf('calcBayesTime; %f\n',calcBayesTime);
            subplot(SHOW_ROW,SHOW_COLUMN,2);
            imshow(bayesImage_load);
            title(['Threshold:',num2str(THRESHOLD)]);
            
        end
    end
end
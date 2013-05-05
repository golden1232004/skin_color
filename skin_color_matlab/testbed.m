%testbed
addpath('E:\Job\code_repository\skin-color\codes\skin_color_matlab\BayesClassifierForRGB');
addpath('E:\Job\code_repository\skin-color\codes\skin_color_matlab\BayesClassifierForYCbCr');

%����RGB�ռ�����
load bayesDataOfRGB.mat skinPDD nSkinPDD;
SKIN_PROBABILITY_RGB =0.4;  %Ƥ������:P(skin)
THRESHOLD_RGB =0.5;
HISTOGRAM_SIZE =256;      %�Ҷ�ֱ��ͼ��С
BIT_PER_CHANNEL_RGB = 8;      %ÿ��ͨ����ʾ��λ��

%����YCbCr�ռ�����
load probabilityDensityDistribution.mat skinPDDofYCbCr nSkinPDDofYCbCr;
P_SKIN_YCBCR = 0.4; %Ƥ������
THRESHOLD_YCBCR =0.35;
BIT_PER_CHANNEL_YCBCR = 8;      %ÿ��ͨ����ʾ��λ��


SHOW_ROW = 2;    %������ʾ
SHOW_COLUMN = 2 ;

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
            %RGB�ռ�
            rgbImage_gray = BayesClassifier( loadImage,SKIN_PROBABILITY_RGB,skinPDD,nSkinPDD,THRESHOLD_RGB,BIT_PER_CHANNEL_RGB,HISTOGRAM_SIZE );
            rgbTime = toc;
            fprintf('rgbTime: %f\n',rgbTime);
            subplot(SHOW_ROW,SHOW_COLUMN,2);
            imshow(rgbImage_gray);
            title(['Threshold:',num2str(THRESHOLD_RGB)]);
            tic;
            %�򵥷���
            easyImage_gray = EasyImageClassifier(loadImage);
            easyTime = toc;
            fprintf('easyTime: %f\n',easyTime);
            subplot(SHOW_ROW,SHOW_COLUMN,3);
            imshow(easyImage_gray);
%           title(['Threshold:',num2str(THRESHOLD)]);
            %YCbCr�ռ�
            tic;
            YCbCrImage = RGB2YCbCr(loadImage);
            ycbcrTransTime = toc;
            fprintf('\t ycbcrTransTime: %f\n',ycbcrTransTime);
            tic;
            ycbcrImage_gray = BayesClassifierOfYCbCr( YCbCrImage,P_SKIN_YCBCR,skinPDDofYCbCr,nSkinPDDofYCbCr,THRESHOLD_YCBCR );
            ycbcrTime = toc;
            fprintf('ycbcrTime: %f\n\n',ycbcrTime);
            subplot(SHOW_ROW,SHOW_COLUMN,4);
            imshow(ycbcrImage_gray);
            title(['Threshold:',num2str(THRESHOLD_YCBCR)]);
            
        end
    end
end
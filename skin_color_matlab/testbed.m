%testbed
addpath('E:\Job\code_repository\skin-color\codes\skin_color_matlab\BayesClassifierForRGB');
addpath('E:\Job\code_repository\skin-color\codes\skin_color_matlab\BayesClassifierForYCbCr');

%加载RGB空间数据
load bayesDataOfRGB.mat skinPDD nSkinPDD;
SKIN_PROBABILITY_RGB =0.4;  %皮肤概率:P(skin)
THRESHOLD_RGB =0.5;
HISTOGRAM_SIZE =256;      %灰度直方图大小
BIT_PER_CHANNEL_RGB = 8;      %每个通道表示的位数

%加载YCbCr空间数据
load probabilityDensityDistribution.mat skinPDDofYCbCr nSkinPDDofYCbCr;
P_SKIN_YCBCR = 0.4; %皮肤概率
THRESHOLD_YCBCR =0.35;
BIT_PER_CHANNEL_YCBCR = 8;      %每个通道表示的位数


SHOW_ROW = 2;    %用于显示
SHOW_COLUMN = 2 ;

testPath = 'E:\Job\code_repository\facedetect0426\build\bin\Debug\right_detect';
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
            %RGB空间
            rgbImage_gray = BayesClassifier( loadImage,SKIN_PROBABILITY_RGB,skinPDD,nSkinPDD,THRESHOLD_RGB,BIT_PER_CHANNEL_RGB,HISTOGRAM_SIZE );
            rgbTime = toc;
            fprintf('rgbTime: %f\n',rgbTime);
            subplot(SHOW_ROW,SHOW_COLUMN,2);
            imshow(rgbImage_gray);
            title(['Threshold:',num2str(THRESHOLD_RGB)]);
            tic;
            %简单方法
            easyImage_gray = EasyImageClassifier(loadImage);
            easyTime = toc;
            fprintf('easyTime: %f\n',easyTime);
            subplot(SHOW_ROW,SHOW_COLUMN,3);
            imshow(easyImage_gray);
%           title(['Threshold:',num2str(THRESHOLD)]);
            %YCbCr空间
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
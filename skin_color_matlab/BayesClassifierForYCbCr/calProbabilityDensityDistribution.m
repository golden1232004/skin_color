%main.m
clc;
clear;

%初始化
MIN_CBCR = 16;  %CbCr的最小取值
MAX_CBCR = 240;  %CbCr的最大取值
CBCR_RANGE = MAX_CBCR - MIN_CBCR; %
BIT_PER_CHANNEL = 8;      %每个通道表示的位数
totalSkinHistogram = zeros(MAX_CBCR,MAX_CBCR); %所有皮肤图片的直方图
totalNSkinHistogram = zeros(MAX_CBCR,MAX_CBCR); %所有非皮肤图片直方图
%读取图片
skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinImageInfo= ReadImageInfo(skinPath);     %定位目录，读取目录下所有图片信息
maskPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\masks';
maskImageInfo = ReadImageInfo(maskPath);

skinImageNum = length(skinImageInfo);       %皮肤图像数目
maskImageNum = length(maskImageInfo);      %模板图片数目
statCount =0; %统计的图片数量
tic;
if skinImageNum~=0 && maskImageNum~=0     %判断读取的目录是否有图像
    if skinImageNum == maskImageNum       %皮肤图像==模板图像
        IMAGE_NUMBER = skinImageNum;         %学习图片的总数
        for i=1:IMAGE_NUMBER
            disp(['统计图片数：',num2str(i)]);
            skinImageStructInfo = skinImageInfo(i);   %每张图片结构信息
            maskImageStructInfo = maskImageInfo(i);
            isSkinImage = skinImageStructInfo.isdir;  %判断是图片还是目录,1表示目录，0表示图片
            isMaskImage = maskImageStructInfo.isdir;
            if isSkinImage==0 && isMaskImage==0
                skinImageName = skinImageStructInfo.name;    %图片名
                maskImageName = maskImageStructInfo.name;
                skinImageNameLen = length(skinImageName);     %图片名长度
                maskImageNameLen = length(maskImageName);
                skinImageFormat = GetImageFormat(skinImageName);   %获取图片格式的长度
                maskImageFormat = GetImageFormat(maskImageName);
%                 if strcmp(skinImageFormat,'gif') || strcmp(skinImageFormat,'png')
%                     
%                 end
                skinImageFormatLen = length(skinImageFormat);     %图片格式的长度
                maskImageFormatLen = length(maskImageFormat);
                skinImageMatchRange = skinImageNameLen - skinImageFormatLen - 1;   %名字匹配的范围，“-1”是减去“.”
                maskImageMatchRange = maskImageNameLen - maskImageFormatLen - 1;
                if strcmp(skinImageName(1:skinImageMatchRange),maskImageName(1:maskImageMatchRange))  %判断皮肤图片和mask图片的名字是否相同
                    
                    skinImage = imread(strcat(skinPath,'\',skinImageName));    %读取图片
                    [h,w,s]=size(skinImage);
                    if s==3;
                        maskImage = imread(strcat(maskPath,'\',maskImageName));
                        %将RGB空间转化为YCbCr空间；RGB的取值范围为[0,255];
                        YCbCrSkinImage = RGB2YCbCr(skinImage);
                        [totalSkinHistogram,totalNSkinHistogram]=GetHistogramOfYCbCr( YCbCrSkinImage,maskImage,totalSkinHistogram,totalNSkinHistogram );    %一幅图片的直方图
                        statCount = statCount + 1;
                    end
                    
                end
            end
        end
        totalSkinPixel = sum(sum(sum(totalSkinHistogram)));     %肤色总数
        totalNSkinPixel = sum(sum(sum(totalNSkinHistogram)));   %非肤色总数       
    end
end
toc;
%计算类条件概率密度分布
skinPDDofYCbCr = totalSkinHistogram / totalSkinPixel;  % skinProbabilityDensityDitribution：皮肤概率密度分布
nSkinPDDofYCbCr = totalNSkinHistogram / totalNSkinPixel; 
save probabilityDensityDitribution.mat skinPDDofYCbCr nSkinPDDofYCbCr;
disp(['统计图片/总图片：',num2str(statCount),'/',num2str(IMAGE_NUMBER)]);
subplot(1,2,1)
% bar3(totalSkinHistogram);
mesh(totalSkinHistogram);
axis([0 255 0 255]);
title('skin color distribution');
xlabel('cb');
ylabel('cr');
subplot(1,2,2)
% bar3(totalNSkinHistogram);
mesh(totalNSkinHistogram);
axis([0 255 0 255]);
title('non-skin color distribution');
xlabel('cb');
ylabel('cr');
          
        
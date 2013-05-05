%main.m
clc;
clear;

%��ʼ��
HISTOGRAM_SIZE =256;      %�Ҷ�ֱ��ͼ��С
BIT_PER_CHANNEL = 8;      %ÿ��ͨ����ʾ��λ��
% skinHistogram =  zeros(HISTOGRAM_SIZE,HISTOGRAM_SIZE,HISTOGRAM_SIZE); 
% nSkinHistogram = zeros(HISTOGRAM_SIZE,HISTOGRAM_SIZE,HISTOGRAM_SIZE); 
totalSkinHistogram = zeros(HISTOGRAM_SIZE,HISTOGRAM_SIZE,HISTOGRAM_SIZE); %����Ƥ��ͼƬ��ֱ��ͼ
totalNSkinHistogram = zeros(HISTOGRAM_SIZE,HISTOGRAM_SIZE,HISTOGRAM_SIZE); %���з�Ƥ��ͼƬֱ��ͼ
%��ȡͼƬ
skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinImageInfo= ReadImageInfo(skinPath);     %��λĿ¼����ȡĿ¼������ͼƬ��Ϣ
maskPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\masks';
maskImageInfo = ReadImageInfo(maskPath);

skinImageNum = length(skinImageInfo);       %Ƥ��ͼ����Ŀ
maskImageNum = length(maskImageInfo);      %ģ��ͼƬ��Ŀ
statCount =0; %ͳ�Ƶ�ͼƬ����
tic;
if skinImageNum~=0 && maskImageNum~=0     %�ж϶�ȡ��Ŀ¼�Ƿ���ͼ��
    if skinImageNum == maskImageNum       %Ƥ��ͼ��==ģ��ͼ��
        IMAGE_NUMBER = skinImageNum;         %ѧϰͼƬ������
        for i=1:IMAGE_NUMBER
            disp(['ͳ��ͼƬ����',num2str(i)]);
            skinImageStructInfo = skinImageInfo(i);   %ÿ��ͼƬ�ṹ��Ϣ
            maskImageStructInfo = maskImageInfo(i);
            isSkinImage = skinImageStructInfo.isdir;  %�ж���ͼƬ����Ŀ¼,1��ʾĿ¼��0��ʾͼƬ
            isMaskImage = maskImageStructInfo.isdir;
            if isSkinImage==0 && isMaskImage==0
                skinImageName = skinImageStructInfo.name;    %ͼƬ��
                maskImageName = maskImageStructInfo.name;
                skinImageNameLen = length(skinImageName);     %ͼƬ������
                maskImageNameLen = length(maskImageName);
                skinImageFormat = GetImageFormat(skinImageName);   %��ȡͼƬ��ʽ�ĳ���
                maskImageFormat = GetImageFormat(maskImageName);
%                 if strcmp(skinImageFormat,'gif') || strcmp(skinImageFormat,'png')
%                     
%                 end
                skinImageFormatLen = length(skinImageFormat);     %ͼƬ��ʽ�ĳ���
                maskImageFormatLen = length(maskImageFormat);
                skinImageMatchRange = skinImageNameLen - skinImageFormatLen - 1;   %����ƥ��ķ�Χ����-1���Ǽ�ȥ��.��
                maskImageMatchRange = maskImageNameLen - maskImageFormatLen - 1;
                if strcmp(skinImageName(1:skinImageMatchRange),maskImageName(1:maskImageMatchRange))  %�ж�Ƥ��ͼƬ��maskͼƬ�������Ƿ���ͬ
                    
                    skinImage = imread(strcat(skinPath,'\',skinImageName));    %��ȡͼƬ
                    [h,w,s]=size(skinImage);
                    if s==3;
                        maskImage = imread(strcat(maskPath,'\',maskImageName));
                        [totalSkinHistogram,totalNSkinHistogram]=GetHistogram( skinImage,maskImage,BIT_PER_CHANNEL,HISTOGRAM_SIZE,totalSkinHistogram,totalNSkinHistogram );    %һ��ͼƬ��ֱ��ͼ
%                         totalSkinHistogram = totalSkinHistogram + skinHistogram; %����ͼƬֱ��ͼ
%                         totalNSkinHistogram = totalNSkinHistogram + nSkinHistogram;
                        statCount = statCount + 1;
                    end
                    
                end
            end
        end
        totalSkinPixel = sum(sum(sum(totalSkinHistogram)));     %��ɫ����
        totalNSkinPixel = sum(sum(sum(totalNSkinHistogram)));   %�Ƿ�ɫ����       
    end
end
toc;
%���������������ܶȷֲ�
skinPDD = totalSkinHistogram / totalSkinPixel;  % skinProbabilityDensityDitribution��Ƥ�������ܶȷֲ�
nSkinPDD = totalNSkinHistogram / totalNSkinPixel; 
disp(['ͳ��ͼƬ/��ͼƬ��',num2str(statCount),'/',num2str(IMAGE_NUMBER)]);

          
        
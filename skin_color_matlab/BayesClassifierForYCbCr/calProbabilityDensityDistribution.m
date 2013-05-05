%main.m
clc;
clear;

%��ʼ��
MIN_CBCR = 16;  %CbCr����Сȡֵ
MAX_CBCR = 240;  %CbCr�����ȡֵ
CBCR_RANGE = MAX_CBCR - MIN_CBCR; %
BIT_PER_CHANNEL = 8;      %ÿ��ͨ����ʾ��λ��
totalSkinHistogram = zeros(MAX_CBCR,MAX_CBCR); %����Ƥ��ͼƬ��ֱ��ͼ
totalNSkinHistogram = zeros(MAX_CBCR,MAX_CBCR); %���з�Ƥ��ͼƬֱ��ͼ
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
                        %��RGB�ռ�ת��ΪYCbCr�ռ䣻RGB��ȡֵ��ΧΪ[0,255];
                        YCbCrSkinImage = RGB2YCbCr(skinImage);
                        [totalSkinHistogram,totalNSkinHistogram]=GetHistogramOfYCbCr( YCbCrSkinImage,maskImage,totalSkinHistogram,totalNSkinHistogram );    %һ��ͼƬ��ֱ��ͼ
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
skinPDDofYCbCr = totalSkinHistogram / totalSkinPixel;  % skinProbabilityDensityDitribution��Ƥ�������ܶȷֲ�
nSkinPDDofYCbCr = totalNSkinHistogram / totalNSkinPixel; 
save probabilityDensityDitribution.mat skinPDDofYCbCr nSkinPDDofYCbCr;
disp(['ͳ��ͼƬ/��ͼƬ��',num2str(statCount),'/',num2str(IMAGE_NUMBER)]);
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
          
        
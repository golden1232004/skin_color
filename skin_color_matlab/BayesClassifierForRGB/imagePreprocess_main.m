%main.m
%ͼƬԤ������ȡͼƬ������ʾ
clc;

skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinDir= dir(skinPath);     %��λĿ¼����ȡ����ͼƬ
maskPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\masks';
maskDir = dir(maskPath);

skinImageNum =length(skinDir);
maskImageNum = length(maskDir);
if skinImageNum == maskImageNum && skinImageNum~=0 && maskImageNum~=0  %�ж϶�ȡ�Ƿ�������
    for i=3:skinImageNum
        skinName = skinDir(i).name;   %��i��ͼƬ������
        maskName = maskDir(i).name;
        skinImageNameLength = length(skinName);   %ͼƬ���ֵĳ���
        maskImageNameLength = length(maskName);
        %��ȡ��ͬ��ʽͼƬ��ͬ������
        skinFormat = GetImageFormat(skinName);    %ͼƬ�ĸ�ʽ
        maskFormat = GetImageFormat(maskName);
        skinFormatLength = length(skinFormat);    %��ȡͼƬ��ʽ�ĳ���
        maskFormatLength = length(maskFormat);
        skinMatchRange = skinImageNameLength - skinFormatLength-1;   %����ƥ��ķ�Χ����-1���ǳ�ȥ��.��
        maskMatchRange = maskImageNameLength - maskFormatLength-1;
%         if i==2127 
        if strcmp(skinName(1:skinMatchRange),maskName(1:maskMatchRange));    %�ж�Ƥ��ͼƬ��maskͼƬ�������Ƿ���ͬ
            subplot(1,2,1);
            imshow(strcat(skinPath,'\',skinName));
            subplot(1,2,2);
            imshow(strcat(maskPath,'\',maskName));
        else
            disp(['skinImage:',skinName]);
            disp(['maskImage:',maskName]);
        end
%         end
        
    end
else
    disp('Ƥ��ͼƬ����Ŀ ~= ģ��ͼƬ����Ŀ');
end
        
        
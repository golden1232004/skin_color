%��������ʽgif,pngͼƬת��Ϊjpg��ʽ
skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
savePath = 'E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-image_jpg';
skinImageInfo= ReadImageInfo(skinPath);     %��λĿ¼����ȡĿ¼������ͼƬ��Ϣ
skinImageNum = length(skinImageInfo);       %Ƥ��ͼ����Ŀ
for i=1:skinImageNum
    skinImageStructInfo = skinImageInfo(i);   %ÿ��ͼƬ�ṹ��Ϣ
    skinImageName = skinImageStructInfo.name;    %ͼƬ��  
    skinImageNameLen = length(skinImageName);     %ͼƬ������
    isSkinImage = skinImageStructInfo.isdir;  %�ж���ͼƬ����Ŀ¼,1��ʾĿ¼��0��ʾͼƬ
    if isSkinImage==0
        skinImageFormat = GetImageFormat(skinImageName);   %��ȡͼƬ��ʽ�ĳ���
        skinImageFormatLen = length(skinImageFormat);     %ͼƬ��ʽ�ĳ���
        skinImageMatchRange = skinImageNameLen - skinImageFormatLen - 1;
        skinImage = imread(strcat(skinPath,'\',skinImageName));    %��ȡͼƬ
        imwrite(skinImage,strcat(savePath,'\',skinImageName(1:skinImageMatchRange),'.jpg'));

    end
end
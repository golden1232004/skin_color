%将其他格式gif,png图片转化为jpg格式
skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
savePath = 'E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-image_jpg';
skinImageInfo= ReadImageInfo(skinPath);     %定位目录，读取目录下所有图片信息
skinImageNum = length(skinImageInfo);       %皮肤图像数目
for i=1:skinImageNum
    skinImageStructInfo = skinImageInfo(i);   %每张图片结构信息
    skinImageName = skinImageStructInfo.name;    %图片名  
    skinImageNameLen = length(skinImageName);     %图片名长度
    isSkinImage = skinImageStructInfo.isdir;  %判断是图片还是目录,1表示目录，0表示图片
    if isSkinImage==0
        skinImageFormat = GetImageFormat(skinImageName);   %获取图片格式的长度
        skinImageFormatLen = length(skinImageFormat);     %图片格式的长度
        skinImageMatchRange = skinImageNameLen - skinImageFormatLen - 1;
        skinImage = imread(strcat(skinPath,'\',skinImageName));    %读取图片
        imwrite(skinImage,strcat(savePath,'\',skinImageName(1:skinImageMatchRange),'.jpg'));

    end
end
%main.m
%图片预处理，读取图片，并显示
clc;

skinPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\skin-images';
skinDir= dir(skinPath);     %定位目录，读取所有图片
maskPath='E:\projects\skin-color\skin-detection-db\skin-detection\skin-images\masks';
maskDir = dir(maskPath);

skinImageNum =length(skinDir);
maskImageNum = length(maskDir);
if skinImageNum == maskImageNum && skinImageNum~=0 && maskImageNum~=0  %判断读取是否有内容
    for i=3:skinImageNum
        skinName = skinDir(i).name;   %第i张图片的名字
        maskName = maskDir(i).name;
        skinImageNameLength = length(skinName);   %图片名字的长度
        maskImageNameLength = length(maskName);
        %获取不同格式图片相同的名字
        skinFormat = GetImageFormat(skinName);    %图片的格式
        maskFormat = GetImageFormat(maskName);
        skinFormatLength = length(skinFormat);    %获取图片格式的长度
        maskFormatLength = length(maskFormat);
        skinMatchRange = skinImageNameLength - skinFormatLength-1;   %名字匹配的范围，“-1”是除去“.”
        maskMatchRange = maskImageNameLength - maskFormatLength-1;
%         if i==2127 
        if strcmp(skinName(1:skinMatchRange),maskName(1:maskMatchRange));    %判断皮肤图片和mask图片的名字是否相同
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
    disp('皮肤图片的数目 ~= 模板图片的数目');
end
        
        
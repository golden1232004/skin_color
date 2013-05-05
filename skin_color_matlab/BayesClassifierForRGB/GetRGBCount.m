function [ skinHistogram,nSkinHistogram ] = GetHistogram( skinImage,maskImage,bitsPerChannel,histogramSize )
%获取每个RGB像素的直方图
%输入：skinImage: 皮肤图片
%      maskImage: 模板图片
%      bitsPerChannel: 每通道表示的位数
%      histogramSize: 直方图尺寸
%输出：skinHistogram: 皮肤像素直方图的个数

    ratio = round(2^bitsPerChannel/histogramSize);  %比例
    [skinImageHeight,skinImageWidth,skinImageDepth] = size(skinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
    skinHistogram = zeros(histogramSize,histogramSize,histogramSize);  % 初始化直方图尺寸,3维数组
    nSkinHistogram = zeros(histogramSize,histogramSize,histogramSize);
    if skinImageHeight == maskImageHeight && skinImageWidth == maskImageWidth  %判断skin图片与mask图片的尺寸是否相等
        for i=1:maskImageHeight
            for j=1:maskImageWidth
                r = round(skinImage(i,j,1)/ratio);
                g = round(skinImage(i,j,2)/ratio);
                b = round(skinImage(i,j,3)/ratio);
                if maskImage(i,j)==1  %mask的白色区域表示皮肤
                    skinHistogram(r,g,b) = skinHistogram(r,g,b) + 1;
                else
                    nSkinHistogram(r,g,b) = nSkinHistogram(r,g,b) + 1;
                end
            end
        end
    end
end


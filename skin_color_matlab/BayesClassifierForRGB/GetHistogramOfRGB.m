function [totalSkinHistogram, totalNSkinHistogram] = GetHistogramOfRGB( skinImage,maskImage,bitsPerChannel,histogramSize,totalSkinHistogram, totalNSkinHistogram )
%获取每个RGB像素的个数
%输入：skinImage: 皮肤图片
%      maskImage: 模板图片
%      bitsPerChannel: 每通道表示的位数
%      histogramSize: 直方图尺寸
%      skinHistogram: 皮肤像素直方图的个数，相当于指针作用
%      nSkinHistogram 非皮肤像素直方图的个数

    ratio = round(2^bitsPerChannel/histogramSize);  %比例
    [skinImageHeight,skinImageWidth,skinImageDepth] = size(skinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
%      skinHistogram = zeros(histogramSize,histogramSize,histogramSize);  % 初始化直方图尺寸,3维数组
%     nSkinHistogram = zeros(histogramSize,histogramSize,histogramSize);
    if skinImageHeight == maskImageHeight && skinImageWidth == maskImageWidth  %判断skin图片与mask图片的尺寸是否相等
        for i=1:maskImageHeight
            for j=1:maskImageWidth
%                 if skinImageDepth == 1
%                     
%                 end
                r = round(skinImage(i,j,1)/ratio) + 1;
                g = round(skinImage(i,j,2)/ratio) + 1;
                b = round(skinImage(i,j,3)/ratio) + 1;
                if maskImage(i,j)==1  %mask的白色区域表示皮肤
                    totalSkinHistogram(r,g,b) = totalSkinHistogram(r,g,b) + 1;
                else
                    totalNSkinHistogram(r,g,b) = totalNSkinHistogram(r,g,b) + 1;
                end
            end
        end
    else
        %抛出异常
    end
end


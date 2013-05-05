function [totalSkinHistogram, totalNSkinHistogram] = GetHistogramOfYCbCr( YCbCrSkinImage,maskImage,totalSkinHistogram, totalNSkinHistogram )
%获取每个RGB像素的个数
%输入：YCbCrSkinImage: 皮肤图片
%      maskImage: 模板图片
%      skinHistogram: 皮肤像素直方图的个数，相当于指针作用
%      nSkinHistogram 非皮肤像素直方图的个数

    [YCbCrSkinImageHeight,YCbCrSkinImageWidth,YCbCrSkinImageDepth] = size(YCbCrSkinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
    if YCbCrSkinImageHeight == maskImageHeight && YCbCrSkinImageWidth == maskImageWidth  %判断skin图片与mask图片的尺寸是否相等
        for i=1:maskImageHeight
            for j=1:maskImageWidth
                cb = YCbCrSkinImage(i,j,2);
                cr = YCbCrSkinImage(i,j,3);
                if maskImage(i,j)==1  %mask的白色区域表示皮肤
                    totalSkinHistogram(cb,cr) = totalSkinHistogram(cb,cr) + 1;
                else
                    totalNSkinHistogram(cb,cr) = totalNSkinHistogram(cb,cr) + 1;
                end
            end
        end
    else
        %抛出异常
    end
end


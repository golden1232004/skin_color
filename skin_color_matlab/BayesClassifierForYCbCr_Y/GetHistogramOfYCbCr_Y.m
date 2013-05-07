function  [totalSkinHistogram_YCb,totalSkinHistogram_YCr,totalNSkinHistogram_YCb,totalNSkinHistogram_YCr]=...
          GetHistogramOfYCbCr_Y( YCbCrSkinImage,maskImage,totalSkinHistogram_YCb,totalSkinHistogram_YCr,totalNSkinHistogram_YCb,totalNSkinHistogram_YCr )
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
                Y = YCbCrSkinImage(i,j,1);
                cb = YCbCrSkinImage(i,j,2);
                cr = YCbCrSkinImage(i,j,3);
                if maskImage(i,j)==1  %mask的白色区域表示皮肤
                    totalSkinHistogram_YCb(Y,cb) = totalSkinHistogram_YCb(Y,cb) + 1;
                    totalSkinHistogram_YCr(Y,cr) = totalSkinHistogram_YCr(Y,cr) + 1;
                else
                    totalNSkinHistogram_YCb(Y,cb) = totalNSkinHistogram_YCb(Y,cb) + 1;
                    totalNSkinHistogram_YCr(Y,cr) = totalNSkinHistogram_YCr(Y,cr) + 1;
                end
            end
        end
    else
        %抛出异常
    end
end


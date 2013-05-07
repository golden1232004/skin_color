function  [totalSkinHistogram_YCb,totalSkinHistogram_YCr,totalNSkinHistogram_YCb,totalNSkinHistogram_YCr]=...
          GetHistogramOfYCbCr_Y( YCbCrSkinImage,maskImage,totalSkinHistogram_YCb,totalSkinHistogram_YCr,totalNSkinHistogram_YCb,totalNSkinHistogram_YCr )
%��ȡÿ��RGB���صĸ���
%���룺YCbCrSkinImage: Ƥ��ͼƬ
%      maskImage: ģ��ͼƬ
%      skinHistogram: Ƥ������ֱ��ͼ�ĸ������൱��ָ������
%      nSkinHistogram ��Ƥ������ֱ��ͼ�ĸ���

    [YCbCrSkinImageHeight,YCbCrSkinImageWidth,YCbCrSkinImageDepth] = size(YCbCrSkinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
    if YCbCrSkinImageHeight == maskImageHeight && YCbCrSkinImageWidth == maskImageWidth  %�ж�skinͼƬ��maskͼƬ�ĳߴ��Ƿ����
        for i=1:maskImageHeight
            for j=1:maskImageWidth
                Y = YCbCrSkinImage(i,j,1);
                cb = YCbCrSkinImage(i,j,2);
                cr = YCbCrSkinImage(i,j,3);
                if maskImage(i,j)==1  %mask�İ�ɫ�����ʾƤ��
                    totalSkinHistogram_YCb(Y,cb) = totalSkinHistogram_YCb(Y,cb) + 1;
                    totalSkinHistogram_YCr(Y,cr) = totalSkinHistogram_YCr(Y,cr) + 1;
                else
                    totalNSkinHistogram_YCb(Y,cb) = totalNSkinHistogram_YCb(Y,cb) + 1;
                    totalNSkinHistogram_YCr(Y,cr) = totalNSkinHistogram_YCr(Y,cr) + 1;
                end
            end
        end
    else
        %�׳��쳣
    end
end


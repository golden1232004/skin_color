function [totalSkinHistogram, totalNSkinHistogram] = GetHistogramOfYCbCr( YCbCrSkinImage,maskImage,totalSkinHistogram, totalNSkinHistogram )
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
                cb = YCbCrSkinImage(i,j,2);
                cr = YCbCrSkinImage(i,j,3);
                if maskImage(i,j)==1  %mask�İ�ɫ�����ʾƤ��
                    totalSkinHistogram(cb,cr) = totalSkinHistogram(cb,cr) + 1;
                else
                    totalNSkinHistogram(cb,cr) = totalNSkinHistogram(cb,cr) + 1;
                end
            end
        end
    else
        %�׳��쳣
    end
end


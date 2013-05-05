function [totalSkinHistogram, totalNSkinHistogram] = GetHistogramOfRGB( skinImage,maskImage,bitsPerChannel,histogramSize,totalSkinHistogram, totalNSkinHistogram )
%��ȡÿ��RGB���صĸ���
%���룺skinImage: Ƥ��ͼƬ
%      maskImage: ģ��ͼƬ
%      bitsPerChannel: ÿͨ����ʾ��λ��
%      histogramSize: ֱ��ͼ�ߴ�
%      skinHistogram: Ƥ������ֱ��ͼ�ĸ������൱��ָ������
%      nSkinHistogram ��Ƥ������ֱ��ͼ�ĸ���

    ratio = round(2^bitsPerChannel/histogramSize);  %����
    [skinImageHeight,skinImageWidth,skinImageDepth] = size(skinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
%      skinHistogram = zeros(histogramSize,histogramSize,histogramSize);  % ��ʼ��ֱ��ͼ�ߴ�,3ά����
%     nSkinHistogram = zeros(histogramSize,histogramSize,histogramSize);
    if skinImageHeight == maskImageHeight && skinImageWidth == maskImageWidth  %�ж�skinͼƬ��maskͼƬ�ĳߴ��Ƿ����
        for i=1:maskImageHeight
            for j=1:maskImageWidth
%                 if skinImageDepth == 1
%                     
%                 end
                r = round(skinImage(i,j,1)/ratio) + 1;
                g = round(skinImage(i,j,2)/ratio) + 1;
                b = round(skinImage(i,j,3)/ratio) + 1;
                if maskImage(i,j)==1  %mask�İ�ɫ�����ʾƤ��
                    totalSkinHistogram(r,g,b) = totalSkinHistogram(r,g,b) + 1;
                else
                    totalNSkinHistogram(r,g,b) = totalNSkinHistogram(r,g,b) + 1;
                end
            end
        end
    else
        %�׳��쳣
    end
end


function [ skinHistogram,nSkinHistogram ] = GetHistogram( skinImage,maskImage,bitsPerChannel,histogramSize )
%��ȡÿ��RGB���ص�ֱ��ͼ
%���룺skinImage: Ƥ��ͼƬ
%      maskImage: ģ��ͼƬ
%      bitsPerChannel: ÿͨ����ʾ��λ��
%      histogramSize: ֱ��ͼ�ߴ�
%�����skinHistogram: Ƥ������ֱ��ͼ�ĸ���

    ratio = round(2^bitsPerChannel/histogramSize);  %����
    [skinImageHeight,skinImageWidth,skinImageDepth] = size(skinImage);
    [maskImageHeight,maskImageWidth,maskImageDepth] = size(maskImage);
    skinHistogram = zeros(histogramSize,histogramSize,histogramSize);  % ��ʼ��ֱ��ͼ�ߴ�,3ά����
    nSkinHistogram = zeros(histogramSize,histogramSize,histogramSize);
    if skinImageHeight == maskImageHeight && skinImageWidth == maskImageWidth  %�ж�skinͼƬ��maskͼƬ�ĳߴ��Ƿ����
        for i=1:maskImageHeight
            for j=1:maskImageWidth
                r = round(skinImage(i,j,1)/ratio);
                g = round(skinImage(i,j,2)/ratio);
                b = round(skinImage(i,j,3)/ratio);
                if maskImage(i,j)==1  %mask�İ�ɫ�����ʾƤ��
                    skinHistogram(r,g,b) = skinHistogram(r,g,b) + 1;
                else
                    nSkinHistogram(r,g,b) = nSkinHistogram(r,g,b) + 1;
                end
            end
        end
    end
end


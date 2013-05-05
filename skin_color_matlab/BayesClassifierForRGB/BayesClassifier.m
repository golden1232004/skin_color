function [ grayImage ] = BayesClassifier( image,pSkin,skinPDD,nSkinPDD,threshold,BIT_PER_CHANNEL,HISTOGRAM_SIZE )
%测试图片
%输入 ：image: 图片
%       pSkin: 皮肤概率
%       skinPDD：在皮肤情况下，RGB的概率密度分布
%       nSkinPDD: 在非皮肤情况下，RGB的概率密度分布
%       threshold: 阈值
%       BIT_PER_CHANNEL: 每通道的位数表示
%       HISTOGRAM_SIZE：直方图大小
%输出： grayImage: 二进制图片
    [height,width,depth] = size(image);
    grayImage = zeros(height,width);
    if depth == 3
        for j = 1:height
            for k = 1:width      
                %计算概率
                 RGBProbabilityOfSkin = CalProbability(image(j,k,1),image(j,k,2),image(j,k,3),skinPDD,BIT_PER_CHANNEL,HISTOGRAM_SIZE); %P(rgb|skin)
                 RGBProbabilityOfNSkin = CalProbability(image(j,k,1),image(j,k,2),image(j,k,3),nSkinPDD,BIT_PER_CHANNEL,HISTOGRAM_SIZE);
                 postProbability = CalBayes(RGBProbabilityOfSkin,RGBProbabilityOfNSkin,pSkin,1-pSkin);
                 if postProbability > threshold
                     grayImage(j,k)=postProbability * (2^BIT_PER_CHANNEL-1);
                 end
            end
        end
    end
    grayImage = uint8(grayImage);
end


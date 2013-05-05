function [ grayImage ] = BayesClassifierOfYCbCr( YCbCrImage,pSkin,skinPDD,nSkinPDD,threshold )
%测试图片
%输入 ：YCbCrImage: 图片
%       pSkin: 皮肤概率
%       skinPDD：在皮肤情况下，CbCr的概率密度分布
%       nSkinPDD: 在非皮肤情况下，CbCr的概率密度分布
%       threshold: 阈值
%       BIT_PER_CHANNEL: 每通道的位数表示
%       HISTOGRAM_SIZE：直方图大小
%输出： grayImage: 灰度图片
    [height,width,depth] = size(YCbCrImage);
    grayImage = zeros(height,width);
    if depth == 3
        for j = 1:height
            for k = 1:width      
                %计算概率
                 cb = YCbCrImage(j,k,2);
                 cr = YCbCrImage(j,k,3);
                 YCbCrProbabilityOfSkin = skinPDD(cb,cr); %P(c|skin)
                 YCbCrProbabilityOfNSkin =nSkinPDD(cb,cr);
%                  if  YCbCrProbabilityOfSkin > threshold * YCbCrProbabilityOfNSkin
%                      grayImage(j,k)=1 ;
%                  end
                 postProbability = CalBayes(YCbCrProbabilityOfSkin,YCbCrProbabilityOfNSkin,pSkin,1-pSkin);
                 if postProbability > threshold
                     grayImage(j,k)=postProbability * 255;
                 end
            end
        end
    end
    grayImage = uint8(grayImage);
end


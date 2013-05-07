function [ grayImage ] = BayesClassifierOfYCbCr_Y( YCbCrImage,pSkin,skinPDD_YCb,skinPDD_YCr,nSkinPDD_YCb,nSkinPDD_YCr,threshold )
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
                 Y = YCbCrImage(j,k,1);
                 cb = YCbCrImage(j,k,2);
                 cr = YCbCrImage(j,k,3);
                 YCbCrProbabilityOfSkin_YCb = skinPDD_YCb(Y,cb); %P(c|skin)
                 YCbCrProbabilityOfSkin_YCr = skinPDD_YCr(Y,cr); 
                 YCbCrProbabilityOfNSkin_YCb =nSkinPDD_YCb(Y,cb);
                 YCbCrProbabilityOfNSkin_YCr =nSkinPDD_YCr(Y,cr);
%                  if  YCbCrProbabilityOfSkin > threshold * YCbCrProbabilityOfNSkin
%                      grayImage(j,k)=1 ;
%                  end                                                     
                 postProbability_YCb = CalBayes(YCbCrProbabilityOfSkin_YCb,YCbCrProbabilityOfNSkin_YCb,pSkin,1-pSkin);
                 postProbability_YCr = CalBayes(YCbCrProbabilityOfSkin_YCr,YCbCrProbabilityOfNSkin_YCr,pSkin,1-pSkin);
                 if postProbability_YCb > threshold && postProbability_YCr>threshold
                     postProbability=max(postProbability_YCb,postProbability_YCr);
                     grayImage(j,k)=postProbability * 255;
                 end
            end
        end
    end
    grayImage = uint8(grayImage);
end


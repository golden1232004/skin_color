function [ postProbability ] = CalBayes(YCbCrProbabilityOfSkin,YCbCrProbabilityOfNSkin,skinProbability,nSkinProbability)
%计算贝叶斯后验概率
%输入：YCbCrProbabilityOfSkin：先验概率，是皮肤的情况下，RGB的概率
%     YCbCrProbabilityOfNSkin：先验概率，在非皮肤的情况下，RGB的概率
%     skinProbability :  皮肤的概率；
%     nSkinProbability:  非皮肤的概率；
   
    postProbability = YCbCrProbabilityOfSkin * skinProbability / (YCbCrProbabilityOfSkin * skinProbability + YCbCrProbabilityOfNSkin * nSkinProbability);

end


function [ probability ] = CalProbability(r,g,b,PDD,bitsPerChannel,histogramSize  )
%计算类条件概率
%输入：r,g,b：像素值
%     PDD: ProbabilityDensityDitribution;概率密度分布
%     bitsPerChannel:每通道的位数表示
%     histogramSize: 直方图尺寸
%输出：probability: 概率密度值
    ratio = round(2^bitsPerChannel/histogramSize);
    rValue = round(r/ratio) + 1;
    gValue = round(g/ratio) + 1;
    bValue = round(b/ratio) + 1;
    probability = PDD(rValue,gValue,bValue);

end


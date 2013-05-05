function [ probability ] = CalProbability(r,g,b,PDD,bitsPerChannel,histogramSize  )
%��������������
%���룺r,g,b������ֵ
%     PDD: ProbabilityDensityDitribution;�����ܶȷֲ�
%     bitsPerChannel:ÿͨ����λ����ʾ
%     histogramSize: ֱ��ͼ�ߴ�
%�����probability: �����ܶ�ֵ
    ratio = round(2^bitsPerChannel/histogramSize);
    rValue = round(r/ratio) + 1;
    gValue = round(g/ratio) + 1;
    bValue = round(b/ratio) + 1;
    probability = PDD(rValue,gValue,bValue);

end


function [ postProbability ] = CalBayes(RGBProbabilityOfSkin,RGBProbabilityOfNSkin,skinProbability,nSkinProbability)
%���㱴Ҷ˹�������
%���룺RGBProbabilityOfSkin��������ʣ���Ƥ��������£�RGB�ĸ���
%     RGBProbabilityOfNSkin��������ʣ��ڷ�Ƥ��������£�RGB�ĸ���
%     skinProbability :  Ƥ���ĸ��ʣ�
%     nSkinProbability:  ��Ƥ���ĸ��ʣ�
   
    postProbability = RGBProbabilityOfSkin * skinProbability / (RGBProbabilityOfSkin * skinProbability + RGBProbabilityOfNSkin * nSkinProbability);

end


function [ postProbability ] = CalBayes(YCbCrProbabilityOfSkin,YCbCrProbabilityOfNSkin,skinProbability,nSkinProbability)
%���㱴Ҷ˹�������
%���룺YCbCrProbabilityOfSkin��������ʣ���Ƥ��������£�RGB�ĸ���
%     YCbCrProbabilityOfNSkin��������ʣ��ڷ�Ƥ��������£�RGB�ĸ���
%     skinProbability :  Ƥ���ĸ��ʣ�
%     nSkinProbability:  ��Ƥ���ĸ��ʣ�
   
    postProbability = YCbCrProbabilityOfSkin * skinProbability / (YCbCrProbabilityOfSkin * skinProbability + YCbCrProbabilityOfNSkin * nSkinProbability);

end


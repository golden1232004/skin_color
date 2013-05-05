function [ grayImage ] = BayesClassifier( image,pSkin,skinPDD,nSkinPDD,threshold,BIT_PER_CHANNEL,HISTOGRAM_SIZE )
%����ͼƬ
%���� ��image: ͼƬ
%       pSkin: Ƥ������
%       skinPDD����Ƥ������£�RGB�ĸ����ܶȷֲ�
%       nSkinPDD: �ڷ�Ƥ������£�RGB�ĸ����ܶȷֲ�
%       threshold: ��ֵ
%       BIT_PER_CHANNEL: ÿͨ����λ����ʾ
%       HISTOGRAM_SIZE��ֱ��ͼ��С
%����� grayImage: ������ͼƬ
    [height,width,depth] = size(image);
    grayImage = zeros(height,width);
    if depth == 3
        for j = 1:height
            for k = 1:width      
                %�������
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


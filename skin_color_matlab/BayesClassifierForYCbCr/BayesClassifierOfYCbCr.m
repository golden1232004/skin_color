function [ grayImage ] = BayesClassifierOfYCbCr( YCbCrImage,pSkin,skinPDD,nSkinPDD,threshold )
%����ͼƬ
%���� ��YCbCrImage: ͼƬ
%       pSkin: Ƥ������
%       skinPDD����Ƥ������£�CbCr�ĸ����ܶȷֲ�
%       nSkinPDD: �ڷ�Ƥ������£�CbCr�ĸ����ܶȷֲ�
%       threshold: ��ֵ
%       BIT_PER_CHANNEL: ÿͨ����λ����ʾ
%       HISTOGRAM_SIZE��ֱ��ͼ��С
%����� grayImage: �Ҷ�ͼƬ
    [height,width,depth] = size(YCbCrImage);
    grayImage = zeros(height,width);
    if depth == 3
        for j = 1:height
            for k = 1:width      
                %�������
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


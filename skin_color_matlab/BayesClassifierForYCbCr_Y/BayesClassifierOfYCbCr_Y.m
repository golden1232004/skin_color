function [ grayImage ] = BayesClassifierOfYCbCr_Y( YCbCrImage,pSkin,skinPDD_YCb,skinPDD_YCr,nSkinPDD_YCb,nSkinPDD_YCr,threshold )
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


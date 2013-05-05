function [ YCbCrImage ] = RGB2YCbCr( RGBImage )
%将RGB色彩空间转换到YCbCr空间
% RGB取值范围为[0,255];
    [h,w,d] = size(RGBImage);
    YCbCrImage = zeros(h,w,d);
    VALUE = [0.257,  0.504,  0.098;...
            -0.148, -0.291,  0.439;...
             0.439, -0.368, -0.071];
    if nargin ==1
        for i = 1:h
            for j = 1:w
                rgb = [RGBImage(i,j,1), RGBImage(i,j,2), RGBImage(i,j,3)]';
                m = VALUE * double(rgb);
                ycbcr = [16,128,128]' + m;
                YCbCrImage(i,j,1) = ycbcr(1);
                YCbCrImage(i,j,2) = ycbcr(2);
                YCbCrImage(i,j,3) = ycbcr(3);
            end
        end
        YCbCrImage = uint8(YCbCrImage);
    else
        %报异常
    end
end


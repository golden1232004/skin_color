function [ rgbImage ] = YCbCr2RGB( ycbcrImage )
% YCbCr色彩空间转化为RGB空间
    [h,w,d] = size(ycbcrImage);
    rgbImage = zeros(h,w,d);
    VALUE = [1.1644,  0,       1.5960;...
             1.1644, -0.3918, -0.8130;...
             1.1644,  2.0172,  0 ];
    if nargin ==1
        for i=1:h
            for j=1:w
                ycbcr = [ycbcrImage(i,j,1),ycbcrImage(i,j,2),ycbcrImage(i,j,3)]';
                diff = ycbcr - [16, 288, 288]';
                rgb = VALUE * diff;
                rgbImage(i,j,1) = rgb(1);
                rgbImage(i,j,2) = rgb(2);
                rgbImage(i,j,3) = rgb(3);
            end
        end
        rgbImage = uint8(rgbImage);        
    else
       %报异常 
    end

end


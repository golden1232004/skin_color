function [ binaryImage ] = EasyImageClassifier( image )
    R_THRESHOLD = 95;
    G_THRESHOLD = 40;
    B_THRESHOLD = 20;
    [height,width,depth] = size(image);
    binaryImage = zeros(height,width);
    if depth ==3
        for i=1:height
            for j=1:width
                r = image(i,j,1);
                g = image(i,j,2);
                b = image(i,j,3);
                maxRGB = max([r,g,b]);
                minRGB = min([r,g,b]);
                if r > R_THRESHOLD && g > G_THRESHOLD && b > B_THRESHOLD
                    if (maxRGB - minRGB)>15 && abs(r - g)>15
                        if r > g && r > b
                            binaryImage(i,j) =1;
                        end
                    end
                end
            end
        end
    else
        %Å×³öÒì³£
    end

end
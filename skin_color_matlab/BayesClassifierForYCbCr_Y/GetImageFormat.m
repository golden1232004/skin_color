function [ format ] = GetImageFormat( imageName )
    len = length(imageName);
    CHARMATCH='.';
    startPoint = len-1;
    if ischar(imageName)
        for i=startPoint:-1:1
            if strcmp(imageName(i),CHARMATCH)
                format=imageName(i+1:len);
                return;
            end
        end
    else
        %±®“Ï≥£
    end
            


end


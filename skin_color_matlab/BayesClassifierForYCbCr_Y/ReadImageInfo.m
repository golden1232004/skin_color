function [ imageInfo ] = ReadImageInfo( path )
%读取图片信息，包括图片名字，创建日期，字节数，是否为文件等信息
%imageInfo是一个结构体数组，每个元素是一个结构体。
%输入：path，如：path='E:\skin-images';
    

    if ischar(path) && nargin==1
        imageInfo= dir(path);
    else
        %报异常
    end

end


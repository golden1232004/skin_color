function [ imageInfo ] = ReadImageInfo( path )
%��ȡͼƬ��Ϣ������ͼƬ���֣��������ڣ��ֽ������Ƿ�Ϊ�ļ�����Ϣ
%imageInfo��һ���ṹ�����飬ÿ��Ԫ����һ���ṹ�塣
%���룺path���磺path='E:\skin-images';
    

    if ischar(path) && nargin==1
        imageInfo= dir(path);
    else
        %���쳣
    end

end


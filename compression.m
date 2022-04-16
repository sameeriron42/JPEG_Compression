clc;                %clear the command window
%clear variables;    %clear all previously loaded variables
close all;          %clopse all previously opened windows

fileName ='images/raw/raw.nef';
%to import rgb images
    %I=imread("images\food.jpg");
%to import Color Filter array images(RAW imgs) use raw2rgb
    I=raw2rgb(fileName);

%Convert rgb image to YCbCr image
YCbCr=rgb2ycbcr(I);

%Downsampling of blue and red chrominance
%smoothen the image before downsampling
filtr=ones(4,4)/16;
cb=conv2(YCbCr(:,:,2),filtr);
cr=conv2(YCbCr(:,:,2),filtr);
CbDown=zeros(round(size(cb)/2));
CrDown=zeros(round(size(cr)/2));
%In a block of 2x2 taking only the fourth/last value
for i=2:2:size(YCbCr,1)
    for j=2:2:size(YCbCr,2)
        CbDown(i/2,j/2)=cb(i,j);
        CrDown(i/2,j/2)=cr(i,j);
    end
end
clear cb cr;

%Performing Discrete cosine Transform
%Luma Quant table
Q = [16 11 10 16 24 40 51 61 ;
     12 12 14 19 26 28 60 55 ;
     14 13 16 24 40 57 69 56 ;
     14 17 22 29 51 87 80 62 ;
     18 22 37 56 68 109 103 77 ;
     24 35 55 64 81 104 113 92 ;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
%Chroma Quant table
Qc= [17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99];
Q=cat(3,Q,Qc,Qc);

quality=input('Enter the quality setting(1<x<100): ');
if quality > 50
    %decrease quantization table values by a factor of (100-q)/50
    Q=((100-quality)/50)*Q;
elseif quality < 50
    %increase quantization table values by 50/q
    Q=(50/quality)*Q;
end

blocksize=8;
[row, col, dim]=size(YCbCr);
%zero padding to make img multiple of 8
row1=8*ceil(row/8);
col1=8*ceil(col/8);
YCbCr=padarray(YCbCr,[row1-row, col1-col],0,'post');

dct_coeff=zeros([row col dim]);
dct_quantized=dct_coeff;
dct_dequant=dct_coeff;
idct_signal=dct_coeff;
for k = 1:3
    for i=1:blocksize:row
        for j=1:blocksize:col
            %forward DCT on blocks of 8 for luminance
            dct_coeff(i:i+blocksize-1,j:j+blocksize-1,k)=dct2(YCbCr(i:i+blocksize-1,j:j+blocksize-1,k));
            %quantizing with Q matrix
            dct_quantized(i:i+blocksize-1,j:j+blocksize-1,k)=round(dct_coeff(i:i+blocksize-1,j:j+blocksize-1,k)./Q(:,:,k));
            %de-quantizing and performing inverse DCT
            dct_dequant(i:i+blocksize-1,j:j+blocksize-1,k)=Q(:,:,k).*dct_quantized(i:i+blocksize-1,j:j+blocksize-1,k);
            %getting image signal from quantized DCT coefficients
            idct_signal(i:i+blocksize-1,j:j+blocksize-1,k)=round(idct2(dct_dequant(i:i+blocksize-1,j:j+blocksize-1,k)));
        end
    end
end

compressed_img=cat(3,idct_signal(:,:,1),idct_signal(:,:,2),idct_signal(:,:,3));
clear dct_coeff dct_quantized dct_dequant idct_signal;
%JPEG files only support color space from 0-255
%i.e, it does not support anything other than uint8
if  not(isa(class(I),'uint8'))
    compressed_img = cast(compressed_img,'uint16');
    compressed_img = im2uint8(compressed_img);
end
compressed_img=ycbcr2rgb(compressed_img);
%crop image [top,left bottom,right] as [(x,y) (x,y)]
compressed_img=imcrop(compressed_img,[0 0 col row]);
imwrite(compressed_img,'result.jpg');

%text formating to show sizes and compression efficiency
temp=imfinfo(fileName).FileSize;
size1=round(temp/1024^2,2);
size2=round(imfinfo('result.jpg').FileSize/1024^2,2);
string1 = {'the original size',strcat(string(size1),' MB')};
string2 = {'the compressed size',strcat(string(size2),' MB')'};
string3 = {'Compression factor',strcat(string(round(size1/size2)),'X')};

%Displaying output
figure,subplot(1,2,1);
imshow(I);
title('Orginal Image','FontSize',16);
subplot(1,2,2);
imshow(compressed_img);
title('Compressed Image','FontSize',16);

annotation('textbox',[0.25 0.15 0.8 0.1],'String',string1,'FitBoxToText','on','FontSize',16);
annotation('textbox',[0.68 0.15 0.8 0.1],'String',string2,'FitBoxToText','on','FontSize',16);
annotation('textbox',[0.12 0.44 0.8 0.1],'String',string3,'FitBoxToText','on','FontSize',16,'HorizontalAlignment','center');





















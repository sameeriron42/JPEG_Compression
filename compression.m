clc;
close all;
I=imread("images\raw.dng");

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
if quality >= 50
    %decrease quantization table values by a factor of (100-q)/50
    Q=((100-quality)/50)*Q;
elseif quality < 50
    %increase quantization table values by 50/q
    Q=(50/quality)*Q;
end

blocksize=8;
[row, col, dim]=size(YCbCr);
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
subplot(1,2,1);
imshow(I);
title('orginal');
subplot(1,2,2);
X=ycbcr2rgb(uint8(compressed_img));
imshow(X);
title('compress');
imwrite(X,'result.jpg');




























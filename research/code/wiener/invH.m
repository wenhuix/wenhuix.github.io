N=256;
n=.0002;
% read image
f = double(imread('lenna.tif'));
figure;imshow(f,gray(256));title('orig');

% blur and add noise
b=ones(4,4)/4^2;
F=fft2(f);
B=fft2(b,N,N);
G=F.*B;
g=ifft2(G);
G=fft2(g);
figure; imshow(ifft2(G),gray(256));title('blur');

imwrite(uint8(ifft2(G)),'blur.jpg');

% inverse filter
B(abs(B)<n)=n;
H=ones(N,N)./B;
I=G.*H;
im=abs(ifft2(I));

figure; imshow(im,gray(256));title('blur Result');
imwrite(uint8(im),'blur_inv.jpg');

MSE = mean(mean((double(im) - double(f)).^2,2),1)

n=1;
% blur and add noise
b=ones(4,4)/4^2;
F=fft2(f);
B=fft2(b,N,N);
G=F.*B;
g=ifft2(G)+10*randn(N,N);
G=fft2(g);
figure; imshow(ifft2(G),gray(256));title('Add noise and blur');

imwrite(uint8(ifft2(G)),'blur_noise.jpg');

% inverse filter
B(abs(B)<n)=n;
H=ones(N,N)./B;
I=G.*H;
im=abs(ifft2(I));

figure; imshow(im,gray(256));title('blur&noise Result');
imwrite(uint8(im),'blur_noise_invres.jpg');

MSE = mean(mean((double(im) - double(f)).^2,2),1)

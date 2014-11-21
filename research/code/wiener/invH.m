N=256;
n=.2;
% read image
f = double(imread('lenna.tif'));
figure;imshow(x,gray(256));title('orig');

% blur and add noise
b=ones(4,4)/4^2;
F=fft2(f);
B=fft2(b,N,N);
G=F.*B;
g=ifft2(G)+10*randn(N,N);
G=fft2(g);
figure; imshow(ifft2(G),gray(256));title('Add noise and blur');

% inverse filter
B(abs(B)<n)=n;
H=ones(N,N)./B;
I=G.*H;
im=abs(ifft2(I));

figure; imshow(im,gray(256));title('Result');
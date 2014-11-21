%% Iterative Procedure

N=256;
lambda=0.1;
% read image
f = double(imread('lenna.tif'));
figure;imshow(x,gray(256));title('orig');

% blur
F=fft2(f);
b=ones(4,4)/16;
B=fft2(b,N,N);
G=F.*B;
figure;imshow(abs(ifft2(G)),gray(256));title('blured');

figure;
K=lambda*G;
for l=1:1500,
  if mod(l,25)==0
    lambda=lambda/5;
  end
  A=G-K.*B;
  K=K+lambda*A;
  if mod(l,50)==0
     l 
     sum(sum(A))
     imshow(abs(ifft2(K)),gray(256));title('deblured');
     pause
  end
end

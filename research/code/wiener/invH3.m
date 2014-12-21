%% Iterative Procedure

N=256;
lambda=0.1;
% read image
f = double(imread('lenna.tif'));
figure;imshow(f,gray(256));title('orig');

% blur
F=fft2(f);
b=ones(4,4)/16;
B=fft2(b,N,N);
G=F.*B;
%add noise
g=ifft2(G)+10*randn(N,N);
G=fft2(g);

figure;imshow(abs(ifft2(G)),gray(256));title('blured');
imwrite(uint8(ifft2(G)),'blur.jpg');
figure;
K=lambda*G;
for l=1:150,
  if mod(l,25)==0
    lambda=lambda/5;
  end
  A=G-K.*B;
  K=K+lambda*A;
  if mod(l,50)==0
     l 
     sum(sum(A))
     imshow(abs(ifft2(K)),gray(256));title('deblured');
     %pause
  end
end
im=abs(ifft2(K));
MSE = mean(mean((double(im) - double(f)).^2,2),1)
imwrite(uint8(im),'deblur_ite_inv_res.jpg');

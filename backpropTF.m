%backpropagation - transfer function approach

function[u0] = backpropTF(u1, L, lambda, z)

[M, N] = size(u1);
dx = L/M;
k = 2*pi/lambda;

fx = -1/(2*dx):1/L:1/(2*dx)-1/L;
fy = -1/(2*dx):1/L:1/(2*dx)-1/L;
[Fx, Fy] = meshgrid(fx,fy);


H = exp(1i*k*z*sqrt(1 - (lambda*Fx).^2 - (lambda*Fy).^2));
H(Fx.^2 + Fy.^2 > 1/lambda^2) = 0;
U1 = fftshift(fft2(fftshift(u1)));
U0 = H.*U1;
u0 = ifftshift(ifft2(ifftshift(U0)));

end

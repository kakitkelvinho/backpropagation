%propagation - transfer function approach

function[u1] = propTF(u0, L, lambda, z)

[M, N] = size(u0);
dx = L/M;
k = 2*pi/lambda;

fx = -1/(2*dx):1/L:1/(2*dx)-1/L;
fy = -1/(2*dx):1/L:1/(2*dx)-1/L;
[Fx, Fy] = meshgrid(fx,fy);


H = exp(-1i*k*z*sqrt(1 - (lambda*Fx).^2 - (lambda*Fy).^2));
H(Fx.^2 + Fy.^2 > 1/lambda^2) = 0;
U0 = fftshift(fft2(fftshift(u0)));
U1 = H.*U0;
u1 = ifftshift(ifft2(ifftshift(U1)));
end

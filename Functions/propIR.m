%propagation - transfer function approach

function[u1] = propIR(u0, L, lambda, z)

[M, N] = size(u0);
dx = L/M;
k = 2*pi/lambda;


h = (1/(1i*lambda*z))*exp(1i*k/(2*z)*(X.^2 + Y.^2));
H = fft2(fftshift(h))*dx^2;
U0 = fft2(fftshift(u0));
U1 = H.*U0;
u1 = ifftshift(ifft2(U1));
end

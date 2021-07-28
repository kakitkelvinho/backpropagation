%back beam with sinc function
close all;


% add path to find function scripts
addpath('./Functions');


lambda = 1e-3;
k0 = 2*pi/lambda;
L = 50e-3;
M = 512;
dx = L/M;
z = 20e-3;
x = dx*(-M/2:M/2-1);
y = dx*(-M/2:M/2-1);
[X, Y] = meshgrid(x, y);

%back beam
close all;
lambda = 1e-3;
k0 = 2*pi/lambda;
L = 50e-3;
M = 512;
dx = L/M;
z = 20e-3;
x = dx*(-M/2:M/2-1);
y = dx*(-M/2:M/2-1);
[X, Y] = meshgrid(x, y);


angle_offset = 45;
offset = z*tand(angle_offset);

r = sqrt((X+offset).^2 + Y.^2);


u1 = sin(k0.*r)./(k0.*r);
u1(isnan(u1)) = 1;
u0 = backpropTF(u1, L, lambda, z);
u0(X.^2+Y.^2 >(6e-3)^2) = 0;
reu1 = propTF(u0, L, lambda, z);

figure;
subplot(131);
imagesc(x, y, abs(u1));
colorbar;
axis square;
colormap jet;

subplot(132);
imagesc(x, y, abs(u0));
colorbar;
axis square;
colormap jet;

subplot(133);
imagesc(x, y, abs(reu1)/max(max(abs(reu1))));
colorbar;
axis square;
colormap jet;

figure;
title('Mesh of final repropagated beam');
mesh(x, y, abs(reu1)/max(max(abs(reu1))));
colorbar;
colormap jet;
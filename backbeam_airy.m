%back beam with airy function
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
Nfft = 2048;
dx = L/M;
z = 20e-3;
x = dx*(-M/2:M/2-1);
y = dx*(-M/2:M/2-1);
[X, Y] = meshgrid(x, y);


angle_offset = 30;
offset = z*tand(angle_offset);

r = sqrt((X+offset).^2 + Y.^2);

% airy function
u1 = besselj(1,k0*r);
u1(X.^2+Y.^2 > (18e-3)^2) = 0;

u0 = backpropTF(u1, L, lambda, z);
u0(X.^2+Y.^2 >(6e-3)^2) = 0;
reu1 = propTF(u0, L, lambda, z);

figure;
mesh(x,y,u1);

figure;
subplot(131);
imagesc(x, y, abs(u1)/max(max(u1)));
colorbar;
axis square;
colormap jet;
title("Defined Field");

subplot(132);
imagesc(x, y, abs(u0));
colorbar;
axis square;
colormap jet;
title("Antenna Plane defined by back propagation");

subplot(133);
imagesc(x, y, abs(reu1)/max(max(abs(reu1))));
colorbar;
axis square;
colormap jet;
title("Focal Plane after repropagation");

% figure;
% imagesc(x/1e-3, y/1e-3, abs(reu1)/max(max(abs(reu1))));
% colorbar;
% xlabel("mm");
% ylabel("mm");
% xlim([-17 -7]);
% ylim([-5 5]);
% colormap jet;
% axis square;
% title("Focal Plane after repropagation, zoomed");

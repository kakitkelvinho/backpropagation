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

angle_offset = 30;
offset = z*tand(angle_offset);


u0 = exp(1i*k0*sqrt(X.^2+(Y+offset).^2+z^2));
u0(abs(y) > 6e-3, :) = 0;
u0(:, abs(x)>6e-3) = 0;

u1 = propTF(u0, L, lambda, z);

figure;
subplot(121);
imagesc(x./1e-3, y./1e-3, angle(u0));
% xlim([-6.5 6.5]);
% ylim([-6.5 6.5]);
title("Antenna Plane");
xlabel("mm");
ylabel("mm");
colorbar;
axis square;
colormap jet;

subplot(122);
imagesc(x./1e-3, y./1e-3, abs(u1)/max(max(abs(u1))));
% xlim([-6.5 6.5]);
% ylim([-18.5 -5.5]);
title("Focal Plane");
xlabel("mm");
ylabel("mm");
colorbar;
colormap jet;
axis square;
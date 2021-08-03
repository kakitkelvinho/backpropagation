%back beam 2; cleaning
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

r = sqrt(X.^2 + Y.^2);

angle_offset = 0;
offset = z*tand(angle_offset);


uo = exp(1i*k0*sqrt(X.^2+Y.^2+z^2));
uo(abs(y) > 6e-3, :) = 0;
uo(:, abs(x)>6e-3) = 0;

u1 = propTF(uo, L, lambda, z);

% 'operate' on u1

u1(:, abs(x) > 5e-4) = 0;
u1(abs(y) > 5e-4,:) = 0;
% 'move' the spot focus to desired spot

u1 = circshift(u1, [-80,100]);

u0 = backpropTF(u1, L, lambda, z);
u0(X.^2+Y.^2 > (6e-3)^2) = 0;

reu1 = propTF(u0, L, lambda, z);


figure;
subplot(131);
imagesc(x, y, abs(u1));
colorbar;
axis square;
colormap jet;

subplot(132);
imagesc(x, y, angle(u0));
colorbar;
axis square;
colormap jet;

subplot(133);
imagesc(x, y, abs(reu1));
colorbar;
axis square;
colormap jet;

% figure("Name", "Recovered Focal Plane");
% subplot(121);
% imagesc(x/1e-3, y/1e-3, abs(u0 - uo));
% colorbar;
% title("Difference in amplitude of Focal Plane");
% xlabel("mm");
% ylabel("mm");
% axis square;
% colormap jet;
% 
% subplot(122);
% imagesc(x, y, angle(u0 - uo));
% title("Difference in phase of Focal Plane");
% xlabel("mm");
% ylabel("mm");
% c1 = colorbar;
% c1.Label.String = "Phase in Radians";
% axis square;
% colormap jet;

%back beam 2; cleaning
close all;

% add path to find function scripts
addpath('./Functions');


lambda = 1e-3;
k0 = 2*pi/lambda;
L = 200e-3;
M = 4096;
dx = L/M;
z = 20e-3;
x = dx*(-M/2:M/2-1);
y = dx*(-M/2:M/2-1);
[X, Y] = meshgrid(x, y);


x_angle = -35;
y_angle = -35;


xshift = fix(z*tand(x_angle)/dx);
yshift = fix(z*tand(y_angle)/dx);
ri = 1*lambda;

% perf = sin(k0*sqrt(X.^2+Y.^2))./(k0*sqrt(X.^2+Y.^2));
perf = zeros(M);
perf((X).^2+(Y).^2<(ri)^2) = 1;
perf = circshift(perf, [yshift xshift]);
focal_center = [xshift*dx/1e-3 yshift*dx/1e-3];

u1 = perf;
nsteps = 100;


u0 = backpropTF(u1, L, lambda, z);
u0(X.^2+Y.^2>(6e-3)^2) = 0;
u1 = propTF(u0, L, lambda, z);

figure;
subplot(121);
imagesc(x/1e-3, y/1e-3, abs(perf));
axis square;
colormap jet;

subplot(122);
imagesc(x/1e-3, y/1e-3, angle(u0));
axis square;
colormap jet;

figure;
imagesc(x/1e-3, y/1e-3, scaleabs(u1.^2));
hold on;
viscircles([0 0], 6, 'Color', 'magenta');
viscircles(focal_center,ri/1e-3, 'Color', 'blue');
hold off;
colorbar;
axis square;
colormap jet;


%% Image processing


%% Ellipse and stuff:

% bw = imbinarize(scaleabs(u1.^2));
% B = bwboundaries(bw);
% B = B{1};
% 
% bxmin = min(B(:,2));
% bxmax = max(B(:,2));
% bymin = min(B(:,1));
% bymax = max(B(:,1));
% 
% rx = (bxmax - bxmin)/2;
% ry = (bymax - bymin)/2;
% 
% xshift = fix((bxmax+bxmin)/2);
% yshift = fix((bymin+bymax)/2);
% 
% B = circshift(B, [-yshift -xshift]);
% 
% a = (rx + ry)/2;
% b = sqrt(rx*ry);
% 
% 
% figure;
% plot(B(:,2), B(:,1), '--');
% hold on;
% plot((bxmax+bxmin)/2,bymin, 'x');
% plot((bxmax+bxmin)/2,bymax, 'x');
% plot(bxmin, (bymin+bymax)/2, 'x');
% plot(bxmax, (bymin+bymax)/2, 'x');
% hold off;
% axis equal;



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
ri = 1*lambda; % scanning focus spot ring thingy, visual aid
antenna_r = 20e-3;

% adjust angle
x_angle = 45;
y_angle = 0;
xshift = z*tand(x_angle);
disp(xshift);
yshift = z*tand(y_angle);
xshiftblocks = fix(xshift/dx);
yshiftblocks = fix(yshift/dx);

no_distortion = zeros(M);
no_distortion(M/2, M/2) = 1;


u0 = backpropTF(no_distortion, L, lambda, z);
% u0(X.^2 + Y.^2 > antenna_r^2) = 0;
% u0(abs(y) > antenna_r) = 0;
% u0(abs(x) > antenna_r) = 0;
no_distortion = propTF(u0, L, lambda, z);
no_distortion_shift = no_distortion;
no_distortion_shift(X.^2+Y.^2>(5*lambda)^2) = 0;
no_distortion_shift = circshift(no_distortion_shift, [yshiftblocks, xshiftblocks]);

% make point source and back propagate
ps = zeros(M);
ps(M/2 + yshiftblocks, M/2+xshiftblocks) = 1;
u0 = backpropTF(ps, L, lambda, z);
% This is not distorted i.e. infinite extent antenna
nodistort = propTF(u0, L, lambda, z);
nodistortspectrum = fftshift(fft2(fftshift(nodistort)));

% This is distorted
% u0(X.^2 +Y.^2 > (antenna_r)^2) = 0;
antennaamp = zeros(M);
antennaamp(abs(x) < antenna_r, abs(y) < antenna_r) = 1;
u0 = antennaamp.*u0;
distort = propTF(u0, L, lambda, z);


% Apply GS algo

targetamp = zeros(M);
targetamp(X.^2+Y.^2 < (lambda*2)^2) = 1;
targetamp = circshift(targetamp, [yshiftblocks xshiftblocks]);
targetphase = zeros(M);

target = targetamp.*exp(1i*targetphase);

tic
for i = 1:5
ua = backpropTF(target, L, lambda, z);
% This is where they ifft the distribution
u00 = antennaamp.*exp(1i*angle(ua));
% Change the amplitude
% u10 = propTF(u00, L, lambda, z);
u10 = propTF(u00, L, lambda,z);
% fft it
target = targetamp.*exp(1i*angle(u10));
% Change the amplitude
end
toc

ua = ua.*antennaamp;
gdistort = propTF(ua, L, lambda, z);

antennaamp(antennaamp == 1) = true;

figure;
subplot(131);
imagesc(abs(nodistort));
hold on;
visboundaries(antennaamp);
hold off;
title("Infinite Extent Antenna");
axis square;
colormap jet;

subplot(132)
imagesc(abs(distort));
hold on;
visboundaries(antennaamp);
hold off;
axis square;
colormap jet;

subplot(133);
imagesc(abs(gdistort));
hold on;
visboundaries(antennaamp);
hold off;
axis square;
colormap jet;

figure;
subplot(121);
imagesc(x,y,abs(ua));
axis square;
colormap jet;
subplot(122);
imagesc(x, y, angle(ua));
colormap jet;
axis square;
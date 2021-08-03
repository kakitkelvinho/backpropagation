
perf = zeros(M);

perf((X/minorA).^2+(Y/majorA).^2 < 1) = 1; 
perf = imrotate(perf, ora, 'bilinear', 'crop');
perf = circshift(perf, [xshift yshift]);

% u1 = perf;

% 
% u0 = backpropTF(u1, L, lambda, z);
% u0(X.^2+Y.^2>(6e-3)^2) = 0;
% u1 = propTF(u0, L, lambda, z);

figure;
% subplot(121);
imagesc(x/1e-3, y/1e-3, abs(perf));
hold on;
viscircles(focal_center,ri/1e-3, 'Color', 'blue');
plot(0, 0, 'x');
hold off;
title("Altered focal plane");
axis square;
colormap jet;
% 
% subplot(122);
% imagesc(x/1e-3, y/1e-3, angle(u0));
% title("Altered antenna plane");
% axis square;
% colormap jet;

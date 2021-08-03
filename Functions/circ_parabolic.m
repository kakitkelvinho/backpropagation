% return array of offset values given angle

function [u0] = circ_parabolic(x_angle, y_angle, antenna_r, lambda, x, y, z)
    [X, Y] = meshgrid(x, y);
    x_offset = z*tand(x_angle);
    y_offset = z*tand(y_angle);
    k0 = 2*pi/lambda;

    u0 = exp(1i*k0*sqrt((X-x_offset).^2 + (Y-y_offset).^2 + z^2));
    u0(X.^2 + Y.^2 > antenna_r^2) = 0;
end
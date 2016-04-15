function z = phih2(i, xh,yh)

% Basis Functions On The Riferement Element For k = 2

switch i
    case 1
        z = (2*xh + 2*yh - 1)*(xh + yh - 1);
    case 2
        z = xh*(2*xh - 1);
    case 3
        z = yh*(2*yh - 1);
    case 4
        z = 4*xh*yh;
    case 5
        z = -4*yh*(xh + yh - 1);
    case 6
        z = -4*xh*(xh + yh - 1);
end


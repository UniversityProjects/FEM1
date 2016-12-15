function [gradx, grady] = ueGrad(x, y)

% gradx = 2*x;
% grady = -2*y;

% gradx = 2*x*exp(x^2 + y^2)*sin(y);
% grady = exp(x^2 + y^2)*cos(y) + 2*y*exp(x^2 + y^2)*sin(y);

%%%%%% Exam Project

% Equation 1
gradx = 2*x - (sin(x))^2 + (cos(x))^2 ;
grady = 2*y;
% Equation 2
% gradx = y*cos(x) + exp(x+y) + sin(y);
% grady = x*cos(y) + exp(x+y) + sin(x);

end
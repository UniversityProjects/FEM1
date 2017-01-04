function z = f(x,y)

% z = -4;

%%%%%% Exam Project

% Equation 1
%z = -2*x^2 ...
%	 + 3*x*(2*x - (sin(x))^2 + (cos(x))^2) ...
% 	 + 4*y^2 ...
%    - (-4*sin(x)*cos(x) + 2)*(x^2+y^2+1) ...
%    + (x^2 + y^2 + sin(x)*cos(x))*exp(x*y) ...
%    -2;

% Equation 2
z = y*(exp(x^2 + y^2)*cos(y) + 2*y*exp(x^2 + y^2)*sin(y)) - (exp(x + y) + 5)*(exp(x^2 + y^2)*sin(y) + 4*y*exp(x^2 + y^2)*cos(y) + 4*y^2*exp(x^2 + y^2)*sin(y)) - exp(x + y)*(exp(x^2 + y^2)*cos(y) + 2*y*exp(x^2 + y^2)*sin(y)) + exp(x^2 + y^2)*sin(y)*(x^2*y^2 + 15) - 2*x^2*exp(x^2 + y^2)*sin(y) - 2*exp(x^2 + y^2)*sin(y)*(exp(x + y) + 5) - 4*x^2*exp(x^2 + y^2)*sin(y)*(exp(x + y) + 5) - 2*x*exp(x^2 + y^2)*exp(x + y)*sin(y);
 
end

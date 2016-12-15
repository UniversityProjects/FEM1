function z = f(x,y)

% z = 0;

%z = (300*x^2*sin(10*x*y) - 2)*(x^2 + 3*y^2 + 1) - 2*x*(2*x - 1/(x + 1) + 30*y*cos(10*x*y)) - (x^2 + 3*y^2 + 1)*(1/(x + 1)^2 - 300*y^2*sin(10*x*y) + 2) - 6*y*(2*y + 30*x*cos(10*x*y));

%z = y*(exp(x^2 + y^2)*cos(y) + 2*y*exp(x^2 + y^2)*sin(y)) - (exp(x + y) + 5)*(exp(x^2 + y^2)*sin(y) + 4*y*exp(x^2 + y^2)*cos(y) + 4*y^2*exp(x^2 + y^2)*sin(y)) - exp(x + y)*(exp(x^2 + y^2)*cos(y) + 2*y*exp(x^2 + y^2)*sin(y)) + exp(x^2 + y^2)*sin(y)*(x^2*y^2 + 15) - 2*x^2*exp(x^2 + y^2)*sin(y) - 2*exp(x^2 + y^2)*sin(y)*(exp(x + y) + 5) - 4*x^2*exp(x^2 + y^2)*sin(y)*(exp(x + y) + 5) - 2*x*exp(x^2 + y^2)*exp(x + y)*sin(y);


%%%%%% Exam Project

% Equation 1
z = -2*x^2 + 3*x*(2*x - (sin(x))^2 + (cos(x))^2) + 4*y^2 ...
    - (-4*sin(x)*cos(x) + 2)*(x^2+y^2+1) + (x^2+y^2+sin(x)*cos(x))*exp(x*y) -2;

% Equation 2
%z = 3*x*(x*cos(y) + exp(x+y) + sin(x)) - 3*y*(y*cos(x) + exp(x+y) ...
%    - (3*x*y + 14)*(-x*sin(y) + exp(x+y)) - (3*x*y + 14)*(-y*sin(x) + exp(x+y)) ...
%    + (x*sin(y) + y*sin(x) + exp(x+y))*log(x+y+1);
 
end
function z = f(x,y)

%z = 0;

z = (300*x^2*sin(10*x*y) - 2)*(x^2 + 3*y^2 + 1) - 2*x*(2*x - 1/(x + 1) + 30*y*cos(10*x*y)) - (x^2 + 3*y^2 + 1)*(1/(x + 1)^2 - 300*y^2*sin(10*x*y) + 2) - 6*y*(2*y + 30*x*cos(10*x*y));

end
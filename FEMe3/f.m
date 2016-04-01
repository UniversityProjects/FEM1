function z = f(x,y)

z = (sin(x*y) + 1)*(x^2*y^3 + cos(6*x)*sin(3*x*y)) - 2*x*(2*x*y^3 - 6*sin(6*x)*sin(3*x*y) + 3*y*cos(6*x)*cos(3*x*y)) - 3*y^2*(3*x^2*y^2 + 3*x*cos(6*x)*cos(3*x*y)) + (x^2 + y^3 + 2)*(36*cos(6*x)*sin(3*x*y) - 2*y^3 + 9*y^2*cos(6*x)*sin(3*x*y) + 36*y*sin(6*x)*cos(3*x*y)) - (6*x^2*y - 9*x^2*cos(6*x)*sin(3*x*y))*(x^2 + y^3 + 2);

end
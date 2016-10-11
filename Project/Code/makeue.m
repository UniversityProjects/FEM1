clear all
close all

syms x y real

ue = x^2 + y^2+3*sin(10*x*y)-log(1+x);

c = 1 + x^2 + 3*y^2;

uex = diff(ue,x);
uey = diff(ue,y);

f = -diff(c*uex,x) -diff(c*uey,y);

ue
f
c
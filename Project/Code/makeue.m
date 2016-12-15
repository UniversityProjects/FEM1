clear all
close all
clc

pkg load symbolic

syms x y real

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ue = x^2 + y^2 + sin(x)*cos(x);

c = 1 + x^2 + y^2;
bx = 5*x;
by = 5*y;
a = exp(x*y);

uex = diff(ue,x);
uey = diff(ue,y);

f = -diff(c*uex,x) -diff(c*uey,y) + bx*uex + by*uey + a*ue;
    
ue
uex
uey
f
c
bx
by
a

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ue = exp(x+y) + x*sin(y) + y*sin(x);

c = 14 + 3*x*y;
bx = 0;
by = 0;
a = log(x+y+1);

uex = diff(ue,x);
uey = diff(ue,y);

f = -diff(c*uex,x) -diff(c*uey,y) + bx*uex + by*uey + a*ue;
    
ue
uex
uey
f
c
bx
by
a
% Define a problem that we know the solution of
clear all
close all

% Choose the exact solution
syms x y real
ue = sin(3*x*y)*cos(6*x)+ x^2 * y^3;

% Choose c(x,y) strictly positive
c = 2 + x^2 + y^3;

% Choose alfa non negative
alfa = 1 + sin(x*y);

% f Computing
% f = - div(c*grad u)
uex = diff(ue,x); % d(ue)/dx
uey = diff(ue,y); % d(ue)/dy
f = -( diff(c*uex,x) + diff(c*uey,y)) + alfa*ue; 

% Plot ue
ezsurf(ue, [0 1 0 1]);

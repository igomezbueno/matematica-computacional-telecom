%=====================================================================
% PROBLEMA 4.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.2')
disp('--------------------------------------------')

clear all
pkg load symbolic
syms x y real

disp('Apartado a) Calculo de c')

I=int(int(x+2*y,y,x^2,1),x,-1,0);
c=1/I

disp('Apartado b) Marginal de Y')

fy=c*int(x+2*y,x,-sqrt(y),0);
simplify(fy)

disp('Apartado c) Marginal de X')

fx=c*int(x+2*y,y,x^2,1);
simplify(fx)

disp('Apartado d) E(X) y V(X)')

EX=int(int(x*c*(x+2*y),y,x^2,1),x,-1,0);
simplify(EX)

m2X=int(int(x^2*c*(x+2*y),y,x^2,1),x,-1,0);
VX=m2X-EX^2

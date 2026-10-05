function y=simpsimp(f,a,b) 
% SIMPSIMP  Regla de Simpson simple para aproximar la integral de f en [a,b].
%   f es el nombre (cadena de caracteres) de la funcion integrando.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
if abs(a-b)<1e-16, y=0; return; end; h=(b-a)/2; 
y=h*(feval(f,a)+4*feval(f,(a+b)/2)+feval(f,b))/3;

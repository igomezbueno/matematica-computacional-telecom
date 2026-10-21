%=====================================================================
% PROBLEMA 5.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 5.1')
disp('--------------------------------------------')

clear all; format compact;

disp('Apartado a')
% Llamamos u=(x(t),y(t)) a la solucion
f = @(t,u)[u(2)+t; u(1)+sin(t)];
[ts,ws] = ode45(f,0:0.05:5,[1;0]);

xp = ws(:,2)+ts;
yp = ws(:,1)+sin(ts);

normup = sqrt(xp.^2+yp.^2);

efeu = 2*ws(:,1)+ws(:,2).^2;
global tabla;
format long;
tabla = [ts efeu.*normup];
simpcomp('tabfun',0,5,50)

disp('Apartado b')
eFeu = [ws(:,1)-ws(:,2), ws(:,1)+cos(ws(:,2))];
intgnds = sum(eFeu.*[xp yp],2);
tabla = [ts intgnds];
simpcomp('tabfun',0,5,50)

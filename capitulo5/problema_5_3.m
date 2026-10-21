%=====================================================================
% PROBLEMA 5.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 5.3')
disp('--------------------------------------------')

clear all; format compact;

disp('Apartado a')

% Llamamos u=(x(t),y(t)) a la solucion
f=@(t,u)[u(2)+cos(t); u(1)+t.^2];
[ts,ws]=ode45(f,0:0.05:5,[1;1]);

xp=ws(:,2)+cos(ts);
yp=ws(:,1)+ts.^2;

normup=sqrt(xp.^2+yp.^2);

efeu=ws(:,1).^2+ws(:,2).^2;

global tabla;
format long;
tabla=[ts efeu.*normup];
simpcomp('tabfun',0,5,50)

disp('Apartado b')

Fx=ws(:,1)+ws(:,2);
Fy=ws(:,1)-sin(ws(:,2));

intgnds=Fx.*xp+Fy.*yp;

tabla=[ts intgnds];
simpcomp('tabfun',0,5,50)

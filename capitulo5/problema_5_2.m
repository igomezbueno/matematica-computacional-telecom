%=====================================================================
% PROBLEMA 5.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 5.2')
disp('--------------------------------------------')

clear all; format compact;

f=@(t,u)[u(2)+cos(t); u(1)+t];
[ts,ws]=ode45(f,0:0.05:5,[0;1]);

xp=ws(:,2)+cos(ts);
yp=ws(:,1)+ts;

normup=sqrt(xp.^2+yp.^2);

h=ws(:,1).^2+ws(:,2);

global tabla;
tabla=[ts h.*normup];
simpcomp('tabfun',0,5,50)

Fx=ws(:,1)+ws(:,2);
Fy=ws(:,1)-ws(:,2);

intg=Fx.*xp+Fy.*yp;
tabla=[ts intg];
simpcomp('tabfun',0,5,50)

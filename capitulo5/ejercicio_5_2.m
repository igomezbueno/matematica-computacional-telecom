%=====================================================================
% EJERCICIO 5.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

clear all; format compact;


%Vamos a calcularlo numericamente:
%Llamamos u=(x(t),y(t)) a la solucion
f = @(t,u)[u(2); -u(1)+sin(t)];  % [x'(t); y'(t)]
[ts,ws] = ode45(f,0:0.1:5,[2;0]); %solucion numerica del sistema de EDOs usando el resolutor de cuarto orden ode45

xp = ws(:,2);               % x'(t)
yp = -ws(:,1)+sin(ts);    % y'(t)
normup = sqrt(xp.^2+yp.^2); %norma de alfa'(t)
efeu = exp(ws(:,1))+ws(:,2).^2; %h(alfa(t)) para h=e^x+y^2

global tabla;
format long;
tabla = [ts efeu.*normup]; %tabla para la integral de linea del campo escalar h=e^x+y^2
simpcomp('tabfun',0,5,25) %integral con Simpson compuesta


Fx = ws(:,2).^2;
Fy = cos(ws(:,1));
eFeu = [Fx Fy]; %campo vectorial F(x,y)=(y^2,cos(x))
intgnds = sum(eFeu.*[xp yp],2); %producto escalar F(alfa(t)) y la derivada de alfa(t)
tabla = [ts intgnds]; %tabla para la integral de linea del campo vectorial F(x,y)=(y^2,cos(x))
simpcomp('tabfun',0,5,25) %integral con simpson compuesta

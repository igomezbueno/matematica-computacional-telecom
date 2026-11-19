%=====================================================================
% EJERCICIO 5.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

clear all; format compact;


%Vamos a calcularlo numericamente:
%Llamamos u=(x(t),y(t)) a la solucion
f = @(t,u)[cos(t) + u(2); u(1)+t.^2];  % [x'(t); y'(t)]
[ts,ws] = ode45(f,0:0.1:5,[0;1]); %solucion numerica del sistema de EDOs usando el resolutor de cuarto orden ode45

xp = cos(ts) + ws(:,2);        % x'(t)
yp = ws(:,1) + ts.^2;          % y'(t)
normup = sqrt(xp.^2+yp.^2); %norma de alfa'(t)
efeu = ws(:,1).^2 + sin(ws(:,2)); %h(alfa(t)) para h=x^2+sin(y)

global tabla;
format long;
tabla = [ts efeu.*normup]; %tabla para la integral de linea del campo escalar h=x^2+sin(y)
simpcomp('tabfun',0,5,25) %integral con Simpson compuesta


Fx = 2 * ws(:,1);
Fy = cos(ws(:,1) .* ws(:,2));
eFeu = [Fx Fy]; %campo vectorial F(x,y)=(2x,cos(xy))
intgnds = sum(eFeu.*[xp yp],2); %producto escalar F(alfa(t)) y la derivada de alfa(t)
tabla = [ts intgnds]; %tabla para la integral de linea del campo vectorial F(x,y)=(2x,cos(xy))
simpcomp('tabfun',0,5,25) %integral con simpson compuesta

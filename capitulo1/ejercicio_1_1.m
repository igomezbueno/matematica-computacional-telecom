%=====================================================================
% EJERCICIO 1.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('EJERCICIO 1.1')
disp('--------------------------------------------')

clear all; close all; format compact;

t = linspace(0,1,500);    % vector de tiempo
x = 2 + sin(2*pi*4*t) + 0.1*randn(size(t)); % señal con offset

offset = mean(x)          % estimacion del offset
xc = x - offset;          % señal corregida
mean(xc)                  % valor medio de la señal corregida (practicamente nulo)

figure;
plot(t,x,'b',t,xc,'r');
legend('Original','Corregida');
grid on;
xlabel('Tiempo(s)');
ylabel('Amplitud');

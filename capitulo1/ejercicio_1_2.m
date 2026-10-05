%=====================================================================
% EJERCICIO 1.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('EJERCICIO 1.2')
disp('--------------------------------------------')

clear all; close all; format compact;

t = linspace(0,1,1000);
x = sin(2*pi*5*t) + 0.2*randn(size(t));

y3 = suavizadoF1(x);  % suavizado de tres puntos (actua sobre la primera fila, que es x)
y5 = suavizado5(x);   % suavizado de cinco puntos

figure;
plot(t,x,'b',t,y3,'r',t,y5,'g');
legend('Original','Suavizado de 3 puntos','Suavizado de 5 puntos');
grid on;
xlabel('Tiempo(s)');
ylabel('Amplitud');

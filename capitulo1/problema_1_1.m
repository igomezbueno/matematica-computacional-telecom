%=====================================================================
% PROBLEMA 1.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 1.1')
disp('--------------------------------------------')

clear all; close all; format compact;

disp('Apartado a)')
fs = 1000;                % numero de muestras
t = linspace(0,1,fs);     % vector de tiempo
x = sin(2*pi*3*t) + 0.5*cos(2*pi*10*t); % señal muestreada

figure;
plot(t,x);
grid on;
title('Señal de dos tonos');
xlabel('Tiempo(s)');
ylabel('Amplitud');

disp('Apartado b)')
[xmax,imax] = max(x)
[xmin,imin] = min(x)
tmax = t(imax) %instante en el que se alcanza el maximo
tmin = t(imin) %instante en el que se alcanza el minimo

disp('Apartado c)')
energia = sum(x.^2)

N = length(x);
energia_for = 0;
for k = 1:N
    energia_for = energia_for + x(k)^2;
end
energia_for

norm(x)^2 %cuadrado de la norma euclidea

disp('Apartado d)')
grandes = abs(x) > 1;   %vector logico
num_grandes = sum(grandes) %numero de muestras con valor absoluto mayor que 1
todas_acotadas = all(abs(x) <= 1.5)

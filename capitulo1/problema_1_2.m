%=====================================================================
% PROBLEMA 1.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 1.2')
disp('--------------------------------------------')

clear all; close all; format compact;

disp('Apartado a)')
t = linspace(0,1,1000);
x1 = sin(2*pi*5*t) + 0.1*randn(size(t));
x2 = 0.5*sin(2*pi*5*t + pi/2) + 0.1*randn(size(t));
x3 = 1 + 0.2*sin(2*pi*2*t) + 0.1*randn(size(t));
X = [x1; x2; x3];
size(X)

disp('Apartado b)')
energia_filas = sum(X.^2, 2) %cada fila de X es una señal

disp('Apartado c)')
N = size(X,2); %numero de muestras de cada canal
Xc = zeros(size(X));
for k = 1:3
    offset = sum(X(k,:))/N; %valor medio del canal k
    Xc(k,:) = X(k,:) - offset;
end
sum(Xc,2)/N %los valores medios de las señales corregidas son practicamente nulos

disp('Apartado d)')
A = [1 0.1 0; 0.1 1 0.1; 0 0.1 1];
Y = A*Xc; %cada fila de Y es una combinacion lineal de las filas de Xc

figure;
plot(t,Y(1,:),'b',t,Y(2,:),'r',t,Y(3,:),'g');
grid on;
title('Canales mezclados');
xlabel('Tiempo(s)');
ylabel('Amplitud');
legend('y_1','y_2','y_3');

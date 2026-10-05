%=====================================================================
% EJERCICIO 1.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('EJERCICIO 1.3')
disp('--------------------------------------------')

clear all; close all; format compact;

t = linspace(0,1,1000);
x = sin(2*pi*5*t) + 0.2*randn(size(t));

disp('Apartado a)')
umbral = abs(x) > 0.8;              % vector logico
num_umbral = sum(umbral)            % numero de muestras que superan el umbral
porcentaje = 100*num_umbral/length(x)

disp('Apartado b)')
idx_umbral = find(abs(x) > 0.8);    % posiciones que superan el umbral
t_umbral = t(idx_umbral);           % instantes correspondientes

figure;
plot(t,x,'b');
hold on;
plot(t_umbral,x(idx_umbral),'ro');
hold off;
grid on;
xlabel('Tiempo(s)');
ylabel('Amplitud');

disp('Apartado c)')
primer_decimo = t <= 0.1;           % muestras del primer decimo de segundo
hay_negativas = any(x(primer_decimo) < 0)

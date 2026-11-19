%=====================================================================
% PROBLEMA 4.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.1')
disp('--------------------------------------------')

pkg load statistics;

disp('Apartado a)')
% La estatura E sigue una N(1.65,0.25) y el peso P una N(60,4)
% Queremos estimar la proporcion p = P(IMC > 30), con IMC = P/E^2

N = 1e5; %numero de simulaciones Montecarlo
cont = 0; %contador de mujeres simuladas con obesidad

for k = 1:N
  E = normrnd(1.65,0.25); %simulamos la estatura
  P = normrnd(60,4); %simulamos el peso
  IMC = P/E^2; %indice de masa corporal
  if IMC > 30
     cont = cont + 1;
  end
end

p = cont/N %proporcion estimada de mujeres con obesidad

NumMujeres = 15000*p %numero estimado de mujeres con obesidad entre 15000

disp('Apartado b)')
q = 1 - p;

% Intervalo de confianza del 95% para la proporcion p
alfa = 1 - 0.95;
C = 1 - alfa/2;
z = norminv(C,0,1);

Ip = [p - z*sqrt(p*q/N), p + z*sqrt(p*q/N)] %intervalo [a,b] para la proporcion

% Intervalo de confianza para el numero de mujeres con obesidad
INumMujeres = 15000*Ip

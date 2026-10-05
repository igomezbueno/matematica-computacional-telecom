%=====================================================================
% EJERCICIO 4.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------')
disp('Duracion de piezas: simulacion Montecarlo')
disp('--------------------')
format compact

pkg load statistics;

disp('-----------------------------------------------')
disp('Apartado a): estimacion del numero de piezas que duran mas de 400 horas')
disp('-----------------------------------------------')

% La duracion de cada pieza sigue una N(300,50)
% Queremos estimar la probabilidad p = P(X > 400)
% y, a partir de ella, el numero esperado de piezas que superan 400 horas
% entre 10000 piezas fabricadas

N = 2e5; %numero de simulaciones Montecarlo
cont = 0; %contador de piezas simuladas con duracion mayor que 400

for k = 1:N
  x = normrnd(300,50); %simulamos la duracion de una pieza
  if x > 400
     cont = cont + 1;
  end
end

p = cont/N %proporcion estimada de piezas que duran mas de 400 horas

NumPiezas = 10000*p %numero estimado de piezas, entre 10000, que superan 400 horas

disp('-----------------------------------------------')
disp('Apartado b): intervalo de confianza al 99%')
disp('-----------------------------------------------')

q = 1 - p;

% Intervalo de confianza del 99% para la proporcion p
alfa = 1 - 0.99;
C = 1 - alfa/2;
z = norminv(C,0,1);

Ip = [p - z*sqrt(p*q/N), p + z*sqrt(p*q/N)] %intervalo para la proporcion

% Intervalo de confianza para el numero de piezas entre 10000
INumPiezas = 10000*Ip

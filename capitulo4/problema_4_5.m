%=====================================================================
% PROBLEMA 4.5
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.5')
disp('--------------------------------------------')

clear all;
pkg load statistics;
format long;

disp('--- Apartado a ---');
% Matriz de transicion (6 estados)
T = [ 0.5  0.5  0    0    0    0;
      0.5  0    0    0.5  0    0;
      0.25 0.25 0    0    0.25 0.25;
      0    0    1    0    0    0;
      0    0    0    0    1    0;
      0    0    0    0    0    1 ];

% pdf inicial: todo en estado 2
p0 = [0 1 0 0 0 0];

% pdf tras 100 transiciones
p100 = p0 * T^100;
p100(3) % Probabilidad de estar en estado 3

disp('--- Apartado b ---');

% Analisis espectral: valores y vectores propios de T'
[V, D] = eig(T');

% Autovalores
autovalores = abs(diag(D))
disp('El autovalor 1 es doble (los estados 5 y 6 son absorbentes), luego no hay una unica pdf estacionaria')
disp('La pdf limite depende de la pdf inicial. Partiendo del estado 2:')
plim = p0 * T^10000

disp('--- Apartado c ---');
NTARS = 10000;
clear v; v(1,:)=2*ones(1,NTARS);
Fxis=cumsum(T,2);

for k = 1:100
  for c = 1:NTARS
    e=v(k,c); x=rand;
    find(x<Fxis(e,:));v(k+1,c)=ans(1);
   end
end

v100=v(101,:);
Freq100=[sum(v100==1) sum(v100==2) sum(v100==3) sum(v100==4) sum(v100==5) sum(v100==6)]/NTARS

% Mostrar evolucion de tareas cada 3 instantes, una de cada 250 tareas
v(1:3:end, 1:250:NTARS)

%=====================================================================
% EJERCICIO 4.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

clear all;
pkg load statistics;
format long;

disp('--- Apartado a ---');
% Matriz de transicion (5 estados)
T = [ 0.3  0.3  0.2  0.1  0.1;
      0.0  0.0  1.0  0.0  0.0;
      0.0  0.0  0.5  0.4  0.1;
      0.0  1.0  0.0  0.0  0.0;
      0.0  1.0  0.0  0.0  0.0 ];

% pdf inicial: todo en estado 2
p0 = [0 1 0 0 0];

% pdf tras 100 pasos
p100 = p0 * T^100;
p100(3) % Probabilidad de estar en estado 3

disp('--- Apartado b ---');

% Analisis espectral: valores y vectores propios de T'
[V, D] = eigs(T');

% Autovalores
autovalores = diag(D)';
abs(autovalores)
disp('Como el autovalor 1 aparece solo una vez y todos los demas tienen modulo menor que 1, es convergente')
v=V(:,1)';v=v/sum(v) %funcion de probabilidad limite

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
Freq100=[sum(v100==1) sum(v100==2) sum(v100==3) sum(v100==4) sum(v100==5)]/NTARS

% Mostrar evolucion de tareas cada 2 instantes para algunas muestras
disp('Estados de tareas 1, 1001, 2001, ..., 9001 cada 2 instantes:');
v(1:2:end, 1:1000:NTARS)

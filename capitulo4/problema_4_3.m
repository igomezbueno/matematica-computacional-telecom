%=====================================================================
% PROBLEMA 4.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.3')
disp('--------------------------------------------')

clear all;
pkg load statistics;
format long;

% ------------------------
% Apartado a
% ------------------------
disp('--- Apartado a ---');

% Estados: A = 1, B = 2, C = 3, D = 4
T = [ 0.1  0.6  0.2  0.1;
      0.3  0.3  0.3  0.1;
      0.2  0.4  0.3  0.1;
      0.25 0.25 0.25 0.25 ];

% Parte del estado B → vector inicial: [0 1 0 0]
p0 = [0 1 0 0];

% Probabilidad de estar en D tras 100 pasos
p100 = p0* T^100; p100(4)


% ------------------------
% Apartado b
% ------------------------
disp('--- Apartado b ---');

% Análisis espectral de T transpuesta
[V, D] = eigs(T');
% Autovalores
autovalores = diag(D)';
abs(autovalores)

disp('Como el autovalor 1 aparece solo una vez y todos los demas tienen modulo menor que 1, es convergente')
v=V(:,1)';v=v/sum(v) %funcion de probabilidad limite


% ------------------------
% Apartado c
% ------------------------
disp('--- Apartado c ---');

NTARS = 12000;           % Número de tareas
clear v;
v(1,:) = 2*ones(1,NTARS);  % Todas comienzan en estado B (2)
Fxis = cumsum(T, 2);     % Matriz acumulada por filas

for k = 1:100
  for c = 1:NTARS
    e=v(k,c); x=rand;
    find(x<Fxis(e,:));v(k+1,c)=ans(1);
   end
end

v100=v(101,:);
Freq100=[sum(v100==1) sum(v100==2) sum(v100==3) sum(v100==4)]/NTARS

v(1:5:end, 1:300:NTARS)

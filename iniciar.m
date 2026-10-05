%=====================================================================
% INICIAR: prepara Octave para ejecutar las recetas del libro
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar una vez al comienzo de cada sesion desde la carpeta raiz
% del repositorio:
%    >> iniciar
%=====================================================================

raiz = fileparts(mfilename('fullpath'));
addpath(fullfile(raiz,'rutinas'));   % simpsimp, simpcomp, tabfun, ...
disp('Rutinas auxiliares anadidas a la ruta de busqueda.')
disp('Para ejecutar una receta, situate en la carpeta del capitulo, por ejemplo:')
disp('   >> cd capitulo2')
disp('   >> problema_2_1')

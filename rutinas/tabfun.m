function y=tabfun(x)
% TABFUN  Evalua una funcion conocida solo mediante una tabla de valores,
%   almacenada en la variable global tabla = [nodos valores].
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
global tabla; 
%Comunmente, cada funcion de MATLAB tiene sus propias variables locales, que estan separadas de las de otras funciones y de las del area de trabajo base. 
%No obstante, si varias funciones declaran un nombre de variable particular como global, todas compartiran una copia unica de esa variable. Cualquier cambio de valor para esa variable, en cualquier funcion, es visible para todas las funciones que la declaren como global.
y = tabla(find(abs(tabla(:,1)-x)<1e-15),2);
% mejor que y = tabla(find(tabla(:,1)==x),2);

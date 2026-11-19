%=====================================================================
% PROBLEMA 3.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 3.3')
disp('--------------------------------------------')

x=[2 4 6 8 10 12 14];
n=[18 42 75 96 63 39 27];

N=sum(n);
nac=cumsum(n); [n' nac']

disp('Obtengamos los momentos ordinarios de orden 1 a 4')
m1g=sum(n.*x)/N;
m2g=sum(n.*x.^2)/N;
m3g=sum(n.*x.^3)/N;
m4g=sum(n.*x.^4)/N;

disp('Obtengamos los momentos centrales de orden 3 y 4')
mu3g=m3g-3*m2g*m1g+2*m1g^3;
mu4g=m4g-4*m3g*m1g+6*m2g*m1g^2-3*m1g^4;

disp('Calculamos la media, la varianza, la desviacion tipica, el sesgo y la curtosis')
mediag=m1g;
varg=m2g-m1g^2;
sg=sqrt(varg);
sesgog=mu3g/sg^3;
curtg=mu4g/sg^4-3;

mediag, varg, sg, sesgog, curtg

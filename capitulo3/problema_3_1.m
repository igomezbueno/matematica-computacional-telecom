%=====================================================================
% PROBLEMA 3.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 3.1')
disp('--------------------------------------------')

disp('Apartado a')
n=[72 168 224 160 112 64];
Li=[20 40 60 80 100 140 200];

x=(Li(1:end-1)+Li(2:end))/2;
a=diff(Li);
h=n./a;

nac=cumsum(n); [n' nac']

N=sum(n);

[val,ind]=max(h);
d1=h(ind)-h(ind-1);
d2=h(ind)-h(ind+1);
Mo=Li(ind)+a(ind)*(d1/(d1+d2))

disp('Apartado b')
n2=N/2;
ind=find(n2<nac,1);
Me=Li(ind)+a(ind)*(n2-nac(ind-1))/n(ind) %mediana

m1=sum(n.*x)/N %media
m2=sum(n.*x.^2)/N
varianza=m2-m1^2 %varianza

disp('Apartado c')
m3=sum(n.*x.^3)/N; %momento ordinario de orden 3
m3_central=m3-3*m2*m1+2*m1^3; %momento central de orden 3
s=sqrt(varianza); %desviacion tipica
sesgo=m3_central/s^3
m4=sum(n.*x.^4)/N; %momento ordinario de orden 4
m4c=m4-4*m3*m1+6*m2*m1^2-3*m1^4; %momento central de orden 4
curtosis=m4c/s^4-3

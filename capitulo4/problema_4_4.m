%=====================================================================
% PROBLEMA 4.4
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.4')
disp('--------------------------------------------')

clear all;
pkg load statistics;
format long;

disp('Apartado a')

T = [0.1 0.7 0.2 0 0;
     0 0.15 0.65 0.2 0;
     0 0 0.55 0.3 0.15;
     0 0.2 0 0.5 0.3;
     0 0 0 0 1];

p0=[1 0 0 0 0];

p20=p0*T^20
p20(5)

disp('Apartado b')

[V,D]=eigs(T');
%Observamos que 1 es autovalor simple y todos los demas tienen modulo menor
abs(diag(D))
v=V(:,1)';
v=v/sum(v) %normalizamos el autovector asociado a 1 para obtener la pdf limite

disp('Apartado c')

NTARS=10000;

clear v;
v(1,:)=ones(1,NTARS); %estado inicial
Fxis=cumsum(T,2); %cdF por filas

for k=1:20
  for c=1:NTARS
    e=v(k,c); %estado actual
    x=rand;
    find(x < Fxis(e,:));
    v(k+1,c)=ans(1);
  end
end


v20=v(21,:);
Freq20=[sum(v20==1) sum(v20==2) sum(v20==3) sum(v20==4) sum(v20==5)]/NTARS



v(1:2:end,1:1000:NTARS)

%=====================================================================
% PROBLEMA 3.4
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 3.4')
disp('--------------------------------------------')

%Datos
x=[-2 -1 0 1 2 3 4];
y=[-17 -3 1 1 3 13 37];
N=length(x);

disp('Apartado a) Ajuste lineal')

p=polyfit(x,y,1);
b=p(1)
a=p(2)

mX=mean(x);
mY=mean(y);
vX=sum(x.^2)/N-mX^2;
vY=sum(y.^2)/N-mY^2;

covar=sum(x.*y)/N-mX*mY;
r=covar/sqrt(vX*vY);
Vr=(1-r^2)*vY;

SSE=N*Vr
R2=r^2

disp('--------------------------------------------')
disp('Apartado b) Representacion')
disp('--------------------------------------------')

xx=linspace(min(x),max(x),200);
yy=polyval(p,xx);

plot(x,y,'ro',xx,yy,'b-'), grid on;
hold on;

disp('--------------------------------------------')
disp('Apartado c) Ajuste cubico')
disp('--------------------------------------------')

p3=polyfit(x,y,3)

ye=polyval(p3,x);
e=y-ye;

SSE3=sum(e.^2)
Ve=var(e,1);
R2_3=1-Ve/vY

yy3=polyval(p3,xx);
plot(xx,yy3,'g-');
hold off;

disp('Comparacion:')
if (SSE3<SSE) && (R2_3>R2)
    disp('El ajuste cubico es mejor')
else
    disp('El ajuste lineal es mejor')
end

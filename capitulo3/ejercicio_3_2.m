%=====================================================================
% EJERCICIO 3.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('-----------')
disp('EJERCICIO 3.2')
disp('-----------')

disp('-----------')
disp('Apartado a)')
disp('-----------')
%Definicion de datos
x=[-2 -2 -1 -1 0 0 1 1 2 2];
y=[3 5 0 2 -1 1 0 2 3 5];

%Calculo del numero de elementos
N=length(x);

disp('Ajuste de una recta Y/X')
p=polyfit(x,y,1);
b=p(1)
a=p(2)

disp('Determinemos la bondad del ajuste')
mX=mean(x);
mY=mean(y);
vX=sum(x.^2)/N-mX^2; %O bien var(x,1)
vY=sum(y.^2)/N-mY^2; %O bien var(y,1)

covar=sum(x.*y)/N-mX*mY; %covarianza
r=covar/sqrt(vX*vY); %coeficiente de correlacion lineal
Vr=(1-r^2)*vY; %varianza residual

disp('Calculo de SSE y coeficiente de determinación (CDL)')
SSEL=N*Vr
CDL=r^2

disp('-----------')
disp('Apartado b)')
disp('-----------')

xx=-2.5:0.2:5;
yy=polyval(p, xx);
%Grafica
plot(x,y,'ro',xx,yy,'b-'), grid on;

disp('-----------')
disp('Apartado c)')
disp('-----------')

disp('Ajuste de una parabola')
p2 = polyfit(x,y,2)

%Bondad del modelo
ye=polyval(p2,x); %y estimados
e=y-ye; %errores
Ve=var(e,1); %varianza residual
disp('Calculo de SSE y coeficiente de determinación')
SSE=sum(e.^2)
R2=1-Ve/vY

% Dibujamos la parabola
yy2=polyval(p2,xx);
hold on;
plot(xx,yy2,'g-');
hold off;

disp('El mejor ajuste es el parabolico, ya que tiene menor SSE y R^2 mas cercano a 1')

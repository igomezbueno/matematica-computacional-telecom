%=====================================================================
% PROBLEMA 3.5
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 3.5')
disp('--------------------------------------------')

x=[-3 -2 -1 0 1 2 3];
y=[12 5 2 1 2 5 12];
N=length(x);

disp('Ajuste lineal')

p1=polyfit(x,y,1);
ye1=polyval(p1,x);
e1=y-ye1;

mY=mean(y);
vY=sum(y.^2)/N-mY^2;

SSE1=sum(e1.^2)
R2_1=1-var(e1,1)/vY

xx=linspace(min(x),max(x),200);
plot(x,y,'ro',xx,polyval(p1,xx),'b-'), grid on;
hold on;

disp('Ajuste parabolico')

p2=polyfit(x,y,2);
ye2=polyval(p2,x);
e2=y-ye2;

SSE2=sum(e2.^2)
R2_2=1-var(e2,1)/vY

plot(xx,polyval(p2,xx),'g-');
hold off;

disp('El mejor ajuste es el parabolico, porque tiene R2 mas cerca de 1 y SSE menor')

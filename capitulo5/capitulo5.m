%=====================================================================
% CAPITULO 5. METODOS NUMERICOS Y MODELADO GEOMETRICO EN TELECOMUNICACIONES
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

%% ---------------------------------------------------
%% Integracion numerica de magnitudes distribuidas
%% ---------------------------------------------------
disp('--------------------')
disp('CAPITULO 5 - Integracion numerica de magnitudes distribuidas')
disp('--------------------')
format compact

%Apartado a)
disp('--------------------')
disp('Apartado a)')
disp('--------------------')

clear all

% Queremos aproximar numericamente la integral doble
% \int_1^2 \int_{x^2}^{x^4} x^2 y \, dy \, dx
% usando Simpson simple en la variable y y Simpson compuesta en la variable x

a=1; b=2; n=16; m=2;
global tabla;

% Dividimos el intervalo [a,b] en n subintervalos iguales para integrar en x
h=(b-a)/n;
x=a:h:b;

% Para cada valor de x, los limites verticales son:
% y = x^2 (curva inferior) e y = x^4 (curva superior)
cx=x.^2;
dx=x.^4;

% Como en vertical vamos a aplicar Simpson simple,
% solo necesitamos dividir cada segmento vertical en 2 subintervalos
m=2;
kx=(dx-cx)/m; %tamano del paso vertical para cada x

% Ahora, para cada valor de x_i:
% 1) construimos una tabla con los valores de y y del integrando x_i^2*y
% 2) integramos respecto de y en [x_i^2, x_i^4]
% El resultado g(i) aproxima la integral interior para ese x_i fijo

for i=1:n+1
  y=cx(i):kx(i):dx(i);          % nodos verticales para ese x_i
  tabla=[y' x(i)^2*y'];         % tabla: primera columna = y, segunda = integrando
  g(i)=simpsimp('tabfun',cx(i),dx(i)); % aproximacion de la integral interior en y
end;

format long;

% Una vez obtenidos los valores g(i), los consideramos como valores tabulados
% de una nueva funcion g(x) = \int_{x^2}^{x^4} x^2 y \, dy
% y aplicamos Simpson compuesta en horizontal para integrar en x
tabla=[x' g'];
I=simpcomp('tabfun',a,b,n/2)

format short;

% Comparamos con el valor exacto calculado simbolicamente
pkg load symbolic;
syms x y real
double(int(int(x^2*y,y,x^2,x^4),x,1,2))


%Apartado b)
disp('--------------------')
disp('Apartado b)')
disp('--------------------')

clear all;
a=-1; b=1; n=16; m=2;
global tabla;

% Queremos comprobar numericamente si
% f(x,y)=1.25(x^2+y),  0 <= y <= 1-x^2
% integra 1 en su soporte.
% Si la integral total vale 1, entonces puede interpretarse como densidad conjunta.

% Dividimos el intervalo [-1,1] en n subintervalos para integrar respecto de x
h=(b-a)/n;
x=a:h:b;

% Para cada x, la region vertical va desde y=0 hasta y=1-x^2
cx=zeros(size(x));         % limite inferior
dx=1-x.^2;      % limite superior

% De nuevo aplicamos Simpson simple en vertical,
% asi que dividimos cada tramo vertical en 2 subintervalos
kx=(dx-cx)/m; %tamano del paso vertical

% Para cada x_i:
% 1) construimos la tabla de valores de la funcion en la variable y
% 2) integramos respecto de y en [0,1-x_i^2]
% Esto nos da una aproximacion de la integral interior

for i=1:n+1
  y=cx(i):kx(i):dx(i);                 % nodos verticales
  tabla=[y' 1.25*(x(i)^2+y)'];         % tabla de valores del integrando
  g(i)=simpsimp('tabfun',cx(i),dx(i)); % integral interior respecto de y
end;

format long;

% Ahora integramos en x los valores obtenidos de la integral interior
tabla=[x' g'];
I=simpcomp('tabfun',a,b,n/2)

format short;
I

% Si el resultado es cercano a 1, la funcion puede interpretarse como densidad.
% Si no es cercano a 1, entonces no es funcion de densidad.

%% ---------------------------------------------------
%% Representacion geometrica de la evolucion de la senal
%% ---------------------------------------------------
disp('--------------------')
disp('CAPITULO 5 - Representacion grafica de trayectorias y geometrias')
disp('--------------------')
format compact
clear all, clf, close all

% Segmento de (0,0) a (1,2)
t = linspace(0,1,100);
x1 = 0 + (1-0)*t;
y1 = 0 + (2-0)*t;
figure(1); plot(x1,y1); axis equal; grid on; title('Segmento');

% Quebrada de tres puntos (0,0)-(1,1)-(2,0)
xq = [0 1 2];
yq = [0 1 0];
figure(2); plot(xq,yq,'-o'); axis equal; grid on; title('Quebrada de tres puntos');

% Circunferencia centrada en (0,0), radio 1
t = linspace(0,2*pi,400);
xc = cos(t);
yc = sin(t);
figure(3); plot(xc,yc); axis equal; grid on; title('Circunferencia');

% Elipse centrada en (0,0), a=2, b=1
xe = 2*cos(t);
ye = sin(t);
figure(4); plot(xe,ye); axis equal; grid on; title('Elipse');

% Lemniscata
t1 = linspace(-pi/4,pi/4,200);
t2 = linspace(3*pi/4,5*pi/4,200);
t = [t1 t2];
rho = sqrt(cos(2*t));
xl = rho.*cos(t);
yl = rho.*sin(t);
figure(5); plot(xl,yl); axis equal; grid on; title('Lemniscata de Bernoulli');

% Caracol de Pascal
t = linspace(0,2*pi,400);
rho = 1 + 2*cos(t);
xp = rho.*cos(t);
yp = rho.*sin(t);
figure(6); plot(xp,yp); axis equal; grid on; title('Caracol de Pascal');

% Helice cilindrica
t = linspace(0,4*pi,400);
r = 1; a = 0.5;
xh = r*cos(t);
yh = r*sin(t);
zh = a*t;
figure(7); plot3(xh,yh,zh); grid on; axis equal; title('Helice cilindrica');

%% ---------------------------------------------------
%% Magnitudes acumuladas a lo largo de trayectorias
%% ---------------------------------------------------
disp('--------------------')
disp('CAPITULO 5 - Magnitudes acumuladas a lo largo de trayectorias')
disp('--------------------')

clear all; format compact; format short

%Apartado a)
disp('--------------------')
disp('Apartado a)')
disp('--------------------')

t=linspace(0,1,30);
x=2*cos(pi*t/2).^3; y=2*sin(pi*t/2).^3;
plot(x,y), grid on

pkg load symbolic;
syms u real
dx=diff(2*cos(pi*u/2)^3,u);
dy=diff(2*sin(pi*u/2)^3,u);
ds=simplify(sqrt(dx^2+dy^2)) %norma de alfa'(t)

L=int(ds,u,0,1) %longitud de arco

%Apartado b)
disp('--------------------')
disp('Apartado b)')
disp('--------------------')

t=linspace(0,2*pi,100); x=10*cos(t); y=10*sin(t); z=x.^2+2*y.^2;
plot3(x,y,z)

syms u real
dx=diff(10*cos(u));
dy=diff(10*sin(u));
ds=simplify(sqrt(dx^2+dy^2)) %norma de alfa'(t)

coste=int((100*cos(u)^2+2*100*sin(u)^2)*ds,u,0,2*pi)

%% ---------------------------------------------------
%% Integracion numerica sobre trayectorias obtenidas por simulacion
%% ---------------------------------------------------
disp('--------------------')
disp('CAPITULO 5 - Integración numérica sobre trayectorias obtenidas por simulación')
disp('--------------------')

clear all; format compact;

disp('--------------------')
disp('Apartados a y b')
disp('--------------------')

%Vamos a calcularlo numericamente:
%Llamamos u=(x(t),y(t)) a la solucion
f = @(t,u)[-u(2)+t^2+6*t+1;u(1)-3*t^2+3*t+1];
[ts,ws] = ode45(f,0:0.1:5,[4;3]);

xp = -ws(:,2)+ts.^2+6*ts+1;
yp = ws(:,1)-3*ts.^2+3*ts+1;
normup = sqrt(xp.^2+yp.^2);
efeu = ws(:,1)-ws(:,2);

global tabla;
format long;
tabla = [ts efeu.*normup];
simpcomp('tabfun',0,5,25)

eFeu = [ws(:,2) -ws(:,1)];
intgnds = sum(eFeu.*[xp yp],2);
tabla = [ts intgnds];
simpcomp('tabfun',0,5,25)

disp('--------------------')
disp('Apartados c y d')
disp('--------------------')

f = @(t,u)[-u(2)+t^2+6*t+1;u(1)-3*t^2+3*t+1];
[ts,ws] = ode45(f,0:0.1:5,[4;3]);

xp = -ws(:,2)+ts.^2+6*ts+1;
yp = ws(:,1)-3*ts.^2+3*ts+1;
normup = sqrt(xp.^2+yp.^2);
efeu = log(ws(:,1))+5*sqrt(ws(:,2));

global tabla;
format long;
tabla = [ts efeu.*normup];
simpcomp('tabfun',0,5,25)

smcs = ws(:,1).^2+ws(:,2).^2;
eFeu = [ws(:,2)./smcs -ws(:,1)./smcs];
intgnds = sum(eFeu.*[xp yp],2);
tabla = [ts intgnds];
simpcomp('tabfun',0,5,25)

%% ---------------------------------------------------
%% Reconstruccion y ajuste de senales a partir de datos
%% ---------------------------------------------------
disp('--------------------')
disp('CAPITULO 5 - Interpolacion y ajuste de datos experimentales')
disp('--------------------')

clear all; format compact; format short

disp('--------------------')
disp('Apartado a)')
disp('--------------------')

format long

% Datos experimentales (muestras de una señal)
% x: puntos donde se mide
% y: valor de la señal en esos puntos
x = [0 3 -5 6 8 1]; 
y = [-5 -2 -10 0 -1 -3];

% Calculamos el polinomio interpolante de grado 5
% (pasa exactamente por los 6 puntos)
p = polyfit(x,y,5)

% Generamos puntos para dibujar la señal interpolada
xs = linspace(min(x),max(x));
ys = polyval(p,xs);

% Representacion: señal reconstruida + datos
figure(1)
plot(xs,ys);              % polinomio interpolante
hold on; 
plot(x,y,'o');           % datos experimentales
grid on
hold off

% Estimacion de la señal en puntos no medidos
polyval(p,0.5), polyval(p,7)


disp('--------------------')
disp('Apartado b)')
disp('--------------------')

% Funcion teorica (modelo ideal de señal)
x=0:0.1:5;
g=1./sqrt((2-x).^2+x.^2);

% Ajuste polinomico de grado 6 (minimos cuadrados)
ag=polyfit(x,g,6);

% Evaluacion del polinomio ajustado
y=polyval(ag,x);

% Representacion: modelo vs aproximacion
figure(2)
plot(x,y,'y-',x,g,'g:'); grid on

% Resolucion equivalente mediante sistema sobredeterminado

% Pasamos a formato columna
x=(0:0.1:5)'; 
n=6; 
g=1./sqrt((2-x).^2+x.^2);

% Construimos la matriz de Vandermonde
M=ones(size(x));
for k = 1:6
  M(:,k+1) = x.*M(:,k);
end

% Analisis numerico de la matriz
size(M), rank(M), cond(M)

% Resolucion mediante QR (mas estable numericamente)
[Q,R]=qr(fliplr(M),0);
ag=R\(Q'*g)

% Comparacion con polyfit
[ag polyfit(x,g,n)']

% Resolucion directa (division a la izquierda)
fliplr(M)\g

% Error de aproximacion (norma L2)
error = norm(g-fliplr(M)*ag)

% Representacion comparativa
y = polyval(ag,x);
hold on
plot(x,y,'b-',x,g,'r:')
hold off


disp('--------------------')
disp('Apartado c)')
disp('--------------------')

% Señal suave en intervalo pequeño
x=0:0.1:1;
f=sin(x);

% Ajuste cuadratico (grado 2)
af=polyfit(x,f,2);

% Evaluacion del modelo
y=polyval(af,x);

% Representacion: señal vs aproximacion
figure(3)
plot(x,y,'y-',x,f,'g:'); grid on


% Resolucion mediante sistema sobredeterminado
x=(0:0.1:1)'; 
n=2; 
f=sin(x);

% Matriz de Vandermonde
M=ones(size(x));
for k = 1:n
  M(:,k+1) = x.*M(:,k);
end

size(M), rank(M), cond(M)

% Resolucion mediante QR
[Q,R]=qr(fliplr(M),0);
af=R\(Q'*f)

% Comparacion con polyfit
[af polyfit(x,f,n)']

% Resolucion directa
fliplr(M)\f

% Error del ajuste
error = norm(f-fliplr(M)*af)

% Representacion final
hold on
y = polyval(af,x);
plot(x,y,'b-',x,f,'r:')
hold off


disp('--------------------')
disp('Apartado d)')
disp('--------------------')

% Datos experimentales (medidas reales de un sistema)
x=0:0.1:1;
y=[-.447 1.978 3.28 6.16 7.08 7.34 7.66 9.56 9.48 9.3 11.2];

% Ajuste cuadratico (modelo suave)
fi=polyfit(x,y,2)

% Puntos densos para representacion
xi=linspace(0,1,100);
zi=polyval(fi,xi);

figure(4)
plot(x,y,'o',xi,zi,'r:') % datos + ajuste
grid on

% Polinomio interpolante (grado 10)
pe10=polyfit(x,y,10)

yi = polyval(pe10,xi);

hold on
plot(xi,yi,'b') % interpolacion exacta
hold off

% Observacion:
% El polinomio de grado alto oscila (fenomeno de polynomial wiggle)
% El ajuste de grado bajo es mas estable y representativo globalmente

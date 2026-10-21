%=====================================================================
% EJERCICIO 2.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('EJERCICIO 2.2')
disp('--------------------------------------------')

disp('Apartado a)')
clear all
pkg load symbolic; %Importamos el paquete symbolic

syms x1 x2 real %definimos variables simbolicas x1 y x2
f = (x1-2)^4+(x1-2*x2)^2 %definimos la funcion f
nablaf = jacobian(f)' %obtenemos el vector columna gradiente de f
nabla2f = jacobian(nablaf)' %obtenemos la matriz hessiana

function fun=f2a(u)
  x1=u(1);
  x2=u(2);
  fun=(x1-2)^4+(x1-2*x2)^2;
endfunction

function fun=gradf2a(u)
  x1=u(1);
  x2=u(2);
  fun=[4*(x1-2)^3+2*(x1-2*x2);
        -4*(x1-2*x2)];
endfunction

function fun=hesf2a(u)
  x1=u(1);
  x2=u(2);
  fun=[ 12*(x1-2)^2+2  -4;
        -4  8];
endfunction

%Primero , vamos a pintar el campo escalar
[x1,x2]= meshgrid(0:0.1:3,0:0.1:3); %creamos una malla a partir de dos vectores

figure(1)
contour(x1,x2,(x1-2).^4+(x1-2*x2).^2,0:40); %generamos las curvas de nivel de nuestra superficie 0 a 40
figure(2)
meshc(x1,x2,(x1-2).^4+(x1-2*x2).^2); %obtenemos la grafica de la malla construida sobre la superficie ( dibuja ademas curvas de nivel en el plano z =0)

%Usemos la rutina newton_sistemas para resolver el ejercicio
function [z,err,k,r] = newton_sistemas(Ffun,Jfun,x0,n,TOL)
% Metodo de Newton para sistemas no lineales
% Ffun = nombre de la funcion vectorial F (string)
% Jfun = nombre del Jacobiano (string)
% x0   = punto inicial
% n    = maximo de iteraciones
% TOL  = tolerancia
% z    = aproximacion final
% err    = 0 si valores finitos, 1 si NaN/Inf
% k    = numero de iteraciones
% r    = residual final F(z)

  err = 1;
  x = x0;

  for k = 1:n
    S  = feval(Ffun,x);
    A  = feval(Jfun,x);
    dx = A\(-S); %resuelvo el sistema A dx = -S

    if norm(dx,inf) < TOL
      break;
    end

    x = x + dx;
  end

  if any(isnan(x) | isinf(x))
    err = 1;
  else
    err = 0;
  end

  z = x;
  r = feval(Ffun,x);
endfunction

[xf,e,k,r]= newton_sistemas('gradf2a','hesf2a',[3;3],100,1e-6)

yf = f2a(xf) %evaluamos en f el valor obtenido xf

%Comprobemos que xf cumple la condicion suficiente de optimalidad:
r %el residuo es el gradiente de f evaluado en xf
norm(r) %obtenemos la norma del residuo

hesxf = hesf2a(xf) %evaluamos la Hessiana en xf
%La Hessiana en xf es simetrica
eig(hesxf) %calculamos los autovalores de la Hessiana en xf para ver si es definida positiva
%Los autovalores son mayores o iguales que cero , luego solo es simetrica semidefinida positiva,
%No podemos asegurar que sea minimo local estricto ni que no sea minimo local

det(hesxf(1:1,1:1)) %determinante de la submatriz principal sucesiva de orden 1
det(hesxf(1:2,1:2)) %determinante de la submatriz principal sucesiva de orden 2
%Hemos comprobado que no se cumple la condicion de minimalidad , por lo que no podemos asegurar que xf sea un minimo local
%tenemos que analizar los valores del campo escalar

disp('Apartado b)')
syms x y real %definimos variables simbolicas x y
f =(3-x+y)^4+(4-y)^2+x-y %definimos la funcion f
nablaf = jacobian(f)' %obtenemos el vector columna gradiente de f
nabla2f = jacobian(nablaf)' %obtenemos la matriz hessiana

function fun=f2b(u)
  x=u(1);
  y=u(2);
  fun=(3-x+y)^4+(4-y)^2+x-y;
endfunction

function fun=gradf2b(u)
  x=u(1);
  y=u(2);
  fun=[-4*(3-x+y)^3+1;
      4*(3-x+y)^3-9+2*y];
endfunction

function fun=hesf2b(u)
  x=u(1);
  y=u(2);
  fun=[12*(3-x+y)^2  -12*(3-x+y)^2;
        -12*(3-x+y)^2  12*(3-x+y)^2+2];
endfunction

%Primero , vamos a pintar el campo escalar
[x,y]= meshgrid(-10:0.1:10,-10:0.1:10); %creamos una malla a partir de dos vectores en [ -10 ,10] x [ -10 ,10]
figure(3)
contour(x,y,(3-x+y).^4+(4-y).^2+x-y,0:40); %generamos las curvas de nivel de nuestra superficie 0 a 40
figure(4)
meshc(x,y,(3-x+y).^4+(4-y).^2+x-y); %obtenemos la grafica de la malla construida sobre la superficie ( dibuja ademas curvas de nivel en el plano z =0)
[x,y]=meshgrid(5:0.1:7,3:0.1:5); %creamos una malla a partir de dos vectores en [5 ,7] x [3 ,5]
figure(5)
contour(x,y,(3-x+y).^4+(4-y).^2+x-y,0:40); %generamos las curvas de nivel de nuestra superficie 0 a 40

[xf,e,k,r]= newton_sistemas('gradf2b','hesf2b',[-7;-4],100,1e-6)

yf = f2b(xf) %evaluamos en f el valor obtenido xf

%Comprobemos que xf cumple la condicion suficiente de optimalidad :
r %el residuo es el gradiente de f evaluado en xf
norm(r) %obtenemos la norma del residuo
hesxf = hesf2b(xf) %evaluamos la Hessiana en xf
%La hessiana en xf es simetrica
eig(hesxf) %calculamos los autovalores de la hessiana en xf para ver si es definida positiva
%Los autovalores son positivos , luego es simetrica definida positiva
det(hesxf(1:1,1:1)) %determinante de la submatriz principal sucesiva de orden 1
det(hesxf(1:2,1:2)) %determinante de la submatriz principal sucesiva de orden 2
%Hemos comprobado que se cumple la condicion suficiente de optimalidad, luego xf es un minimo local estricto

%Cambiamos el vector inicial
[xf,e,k,r]= newton_sistemas('gradf2b','hesf2b',[-7;4],100,1e-6)

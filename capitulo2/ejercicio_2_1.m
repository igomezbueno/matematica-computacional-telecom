%=====================================================================
% EJERCICIO 2.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('EJERCICIO 2.1')
disp('--------------------------------------------')

pkg load symbolic
syms x y real

function fun=F(u)
    x=u(1);
    y=u(2);
    fun=[x^3+y-1;
        2*y^3-2*x+2];
endfunction

f1=x^3+y-1
f2=2*y^3-2*x+2
F=[f1;f2]
JF=jacobian(F)

function funJ=JF(u)
    x=u(1);
    y=u(2);
    funJ=[3*x^2 1;
          -2 6*y^2];
endfunction

% Metodo de Newton para sistemas
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

  if isnan(x) | isinf(x)
    err = 1;
  else
    err = 0;
  end

  z = x;
  r = feval(Ffun,x);
endfunction

[x,e,k,r]=newton_sistemas('F','JF',[0;0],100,1e-5)

x %solucion
norm(r,inf) %residual

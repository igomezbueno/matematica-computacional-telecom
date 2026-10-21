%=====================================================================
% PROBLEMA 2.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 2.1')
disp('--------------------------------------------')

pkg load symbolic
syms x y real

function fun=F(u)
    x=u(1);
    y=u(2);
    fun=[x^2+y^2-5;
         x-y^2+1];
endfunction

f1=x^2+y^2-5
f2=x-y^2+1
F=[f1;f2]
JF=jacobian(F)

function funJ=JF(u)
    x=u(1);
    y=u(2);
    funJ=[2*x 2*y;
          1  -2*y];
endfunction

% Metodo de Newton para sistemas
function [z,err,k,r] = newton_sistemas(Ffun,Jfun,x0,n,TOL)

  err = 1;
  x = x0;

  for k = 1:n
    S  = feval(Ffun,x);
    A  = feval(Jfun,x);
    dx = A\(-S);

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

[x,e,k,r]=newton_sistemas('F','JF',[2;1],100,1e-8)

x
k
norm(r,inf)

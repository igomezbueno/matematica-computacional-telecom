%=====================================================================
% PROBLEMA 2.6
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 2.6')
disp('--------------------------------------------')

clear all
pkg load symbolic

syms x y real

f = (x-1)^2 + 2*(y-2)^2 + (x-y)^2
gradf = jacobian(f)'
hesf = jacobian(gradf)'

function fun = grad(u)
  x = u(1); y = u(2);

  fun = [4*x - 2*y - 2;
         -2*x + 6*y - 8];
end

function fun = hes(u)
  fun = [4 -2;
         -2 6];
end

[xg,yg] = meshgrid(0:0.1:3,0:0.1:3);
contour(xg,yg,(xg-1).^2 + 2*(yg-2).^2 + (xg-yg).^2,0:2:40)

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

  if any(isnan(x)) || any(isinf(x))
    err = 1;
  else
    err = 0;
  end

  z = x;
  r = feval(Ffun,x);
endfunction

[xf,e,k,r] = newton_sistemas('grad','hes',[2;2],100,1e-8)


fval = (xf(1)-1)^2 + 2*(xf(2)-2)^2 + (xf(1)-xf(2))^2

H = hes(xf)
eig(H) % los autovalores son positivos, luego es minimo local estricto

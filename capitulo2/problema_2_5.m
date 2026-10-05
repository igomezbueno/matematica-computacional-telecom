%=====================================================================
% PROBLEMA 2.5
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 2.5')
disp('--------------------------------------------')

clear all
pkg load symbolic

syms x y real

f=(x-1)^4+(x+y-3)^2+(y-2)^2
gradf=jacobian(f)'
hesf=jacobian(gradf)'

function fun=grad(u)
 x=u(1); y=u(2);
 fun=[2*x+2*y+4*(x-1)^3-6;
      2*x+4*y-10];
end

function fun=hes(u)
 x=u(1); y=u(2);
 fun=[12*(x-1)^2+2 2;
      2 4];
end

% Metodo de Newton para sistemas
function [z,err,k,r] = newton_sistemas(Ffun,Jfun,x0,n,TOL)

  err = 1;
  x = x0;

  for k = 1:n
    S  = feval(Ffun,x);
    A  = feval(Jfun,x);
    dx = A\(-S);

    if norm(dx) < TOL
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


[xg,yg]=meshgrid(0:0.1:3,0:0.1:4);
contour(xg,yg,(xg-1).^4+(xg+yg-3).^2+(yg-2).^2,0:2:20)

[xf,e,k,r]=newton_sistemas('grad','hes',[2;3],100,1e-7)

fval=(xf(1)-1)^4+(xf(1)+xf(2)-3)^2+(xf(2)-2)^2

H=hes(xf)
eig(H) %autovalores positivos, luego es minimo local estricto

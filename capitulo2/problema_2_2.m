%=====================================================================
% PROBLEMA 2.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 2.2')
disp('--------------------------------------------')

pkg load symbolic; % Cargar paquete simbólico
clear all;

syms x y real;

% Definimos el sistema de ecuaciones
f1 = x*y + y - 2;
f2 = x^2 - y - 3;
F = [f1; f2];

JF = jacobian(F) % Jacobiana simbólica

% Función del sistema
function fun = F1(u)
    x = u(1);
    y = u(2);
    fun = [x*y + y - 2;
        x^2 - y - 3];
endfunction

% Función para la jacobiana
function funJ = JF1(u)
    x = u(1);
    y = u(2);
    funJ = [y, x+1;
            2*x, -1];
endfunction

% Método de Newton
function [z, e, k, r] = newton_sistemas(F, J, x0, n, TOL)
    e = 1;
    x = x0;
    for k = 1:n
        S = feval(F, x);
        A = feval(J, x);
        desx = A \ (-S);
        if norm(desx, 1) < TOL
            break;
        end
        x = x + desx;
    end
    if any(isnan(x)) || any(isinf(x))
        e = 1;
    else
        e = 0;
    end
    z = x;
    r = feval(F, x);
endfunction

% Aplicamos el método
[x, e, k, r] = newton_sistemas('F1', 'JF1', [1; 1], 100, 1e-6);

% Resultados
x
norm(r, 1)

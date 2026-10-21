%=====================================================================
% EJERCICIO 4.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

clear all; format compact;
pkg load symbolic;
syms x y real

disp('--------------------------------')
disp('Apartado a): constante c y soporte')
disp('--------------------------------')

% Soporte: 0 <= y <= x, 0 <= x <= 1
% Es un triangulo en el plano xy
I = int(int(x + 2*y, y, 0, x), x, 0, 1); %integral doble del numerador
c = simplify(I) %debe cumplirse I/c = 1, luego c = I


disp('--------------------------------')
disp('Apartado b): marginal de Y')
disp('--------------------------------')

% Sustituimos c = 2/3 en la densidad
fy = (3/2)*int(x + 2*y, x, y, 1); %para un y fijo, x recorre [y,1]
fy = simplify(fy)

% Funcion de distribucion de Y
FY = int(fy, y, 0, y);
FY = simplify(FY)

disp('--------------------------------')
disp('Apartado c): marginal de X e independencia')
disp('--------------------------------')

fx = (3/2)*int(x + 2*y, y, 0, x); %para un x fijo, y recorre [0,x]
fx = simplify(fx)

% Comprobacion de independencia:
% X e Y serian independientes si f(x,y)=fx(x)fy(y) en el soporte

fxy = (3/2)*(x + 2*y); %densidad conjunta con c=2/3
producto = simplify(fx*fy)

simplify(fxy - producto)

disp('Como f(x,y) no coincide con fx(x)*fy(y), X e Y no son independientes.')
disp('--------------------------------')
disp('Apartado d): E(X) y E(X|Y=1/2)')
disp('--------------------------------')

%-------------------------------
% Esperanza E(X)
%-------------------------------

EX = int(x*fx, x, 0, 1);
EX = simplify(EX)

%-------------------------------
% Esperanza condicionada E(X|Y=1/2)
%-------------------------------

% Densidad conjunta evaluada en y = 1/2
f_conj = subs(fxy,y,1/2);

% Valor de la marginal en y = 1/2
fy_half = subs(fy, y, 1/2);

% Densidad condicionada
fX_Y = simplify(f_conj / fy_half)

% Esperanza condicionada
EX_cond = int(x * fX_Y, x, 1/2, 1);
EX_cond = simplify(EX_cond)

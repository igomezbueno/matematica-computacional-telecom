%=====================================================================
% PROBLEMA 4.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 4.2')
disp('--------------------------------------------')

clear all; format compact;
pkg load symbolic;
syms x y real

disp('--------------------------------')
disp('Apartado a): constante c')
disp('--------------------------------')

% Soporte: x^2 <= y <= 1, -1 <= x <= 0 (en el soporte 2y-x >= 0)
I = int(int(2*y - x, y, x^2, 1), x, -1, 0); %integral doble del numerador
c = simplify(1/I) %debe cumplirse c*I = 1, luego c = 1/I

disp('--------------------------------')
disp('Apartado b): marginal de X y su funcion de distribucion')
disp('--------------------------------')

fx = c*int(2*y - x, y, x^2, 1); %para un x fijo, y recorre [x^2,1]
fx = simplify(fx)

% Funcion de distribucion de X (para -1 <= x < 0)
syms t real
FX = int(subs(fx,x,t), t, -1, x);
FX = simplify(FX)

disp('--------------------------------')
disp('Apartado c): marginal de Y e independencia')
disp('--------------------------------')

fy = c*int(2*y - x, x, -sqrt(y), 0); %para un y fijo, x recorre [-sqrt(y),0]
fy = simplify(fy)

% Comprobacion de independencia en el punto (-1/2,1/10):
% esta fuera del soporte (1/10 < 1/4), luego f(-1/2,1/10)=0
producto = subs(fx,x,-1/2)*subs(fy,y,1/10)

disp('Como f(-1/2,1/10)=0 y fx(-1/2)*fy(1/10)>0, X e Y no son independientes.')

disp('--------------------------------')
disp('Apartado d): E(X), E(X|Y=1) y P(Y-X<=0.5)')
disp('--------------------------------')

%-------------------------------
% Esperanza E(X)
%-------------------------------

EX = int(x*fx, x, -1, 0);
EX = simplify(EX)

%-------------------------------
% Esperanza condicionada E(X|Y=1)
%-------------------------------

fxy = c*(2*y - x); %densidad conjunta

% Densidad conjunta evaluada en y = 1
f_conj = subs(fxy,y,1);

% Valor de la marginal en y = 1
fy_1 = subs(fy, y, 1);

% Densidad condicionada
fX_Y = simplify(f_conj / fy_1)

% Esperanza condicionada
EX_cond = int(x * fX_Y, x, -1, 0);
EX_cond = simplify(EX_cond)

%-------------------------------
% Probabilidad P(Y-X<=0.5)
%-------------------------------

% En el soporte, y <= x+1/2 junto con y >= x^2 exige x^2 <= x+1/2,
% es decir, (1-sqrt(3))/2 <= x <= 0
a = (1-sqrt(sym(3)))/2;
P = int(int(fxy, y, x^2, x+1/2), x, a, 0);
P = simplify(P)
double(P)

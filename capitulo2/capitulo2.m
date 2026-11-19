%=====================================================================
% CAPITULO 2. METODOS ITERATIVOS Y ANALISIS DC DE CIRCUITOS
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

%% ---------------------------------------------------
%% Energia del circuito y punto de funcionamiento
%% ---------------------------------------------------
%================================================
% CAPITULO 2 - Métodos iterativos y análisis DC de circuitos
%================================================

clear all; close all; clc; %borramos todo, cerramos todo y reseteamos la ventana de comandos

disp('.............................................')
disp('ENERGIA DEL CIRCUITO Y PUNTO DE FUNCIONAMIENTO')
disp('.............................................')


% Definición simbólica de la energía E(x,y,z)

pkg load symbolic;   % TENEMOS QUE IMPORTAR EL CALCULO SIMBOLICO EN OCTAVE
syms x y z real

E_sym = (1/2)*x^4-(5/2)*x^2-18*x ...
      +(1/2)*y^4-5*y^2-54*y ...
      +(5/2)*z^4-(25/2)*z^2-666*z ...
      +(1/2)*(x-y)^2+(5/2)*(y-z)^2

% Gradiente y Hessiana (simbolico)
nablaE_sym  = jacobian(E_sym)'      % gradiente columna
nabla2E_sym = jacobian(nablaE_sym)'   % hessiana

% Rutinas numéricas: energia, gradiente y hessiana

function fun = E(u)
  x=u(1); y=u(2); z=u(3);
  fun = (1/2)*x^4-(5/2)*x^2-18*x...
      +(1/2)*y^4-5*y^2-54*y...
      +(5/2)*z.^4-(25/2)*z^2-666*z...
      +(1/2)*(x-y)^2+(5/2)*(y-z)^2;
endfunction

function fun = gradE(u)
  x=u(1); y=u(2); z=u(3);
  fun = [2*x^3-4*x-y-18;
       2*y^3-4*y-x-5*z-54;
       10*z^3-20*z-5*y-666];
endfunction

function fun = hesE(u)   % Jacobiano de F = Hessiana de E
  x=u(1); y=u(2); z=u(3);
  fun = [6*x^2-4 -1 0;
          -1 6*y^2-4 -5;
          0 -5 30*z^2-20];
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

    if norm(dx) < TOL
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

%Ejecución de método de Newton
x0 = [3;4;5];
[x_sol,err,k,r] = newton_sistemas('gradE','hesE',x0,100,1e-6)

disp('Residual:')
r
disp('Norma 2 del residual:')
norm(r,2)

disp('Valor de la energia en la solucion:')
E(x_sol)

% Interpretación como minimización: análisis local (es un mínimo local estricto si hessiana definida positiva)

Hsol = hesE(x_sol);
disp('Hessiana en el punto:');
Hsol

disp('Autovalores de la Hessiana en el punto:')
eig(Hsol)

disp('Comprobacion de menores principales sucesivos:')
det(Hsol(1:1,1:1))
det(Hsol(1:2,1:2))
det(Hsol(1:3,1:3))

% Si los autovalores son positivos (o los menores principales sucesivos >0),el punto crítico es un mínimo local estricto de la energía.

% Curvas de nivel de la energia (z fijado)

% Fijamos z al valor del punto de funcionamiento
z0 = x_sol(3);

% Creamos una malla en el plano (x,y)
[xm,ym] = meshgrid(-10:0.1:10, -10:0.1:10);

% Energia evaluada en la malla con z=z0 (energia modificada)
Em = (1/2)*xm.^4-(5/2)*xm.^2-18*xm...
   +(1/2)*ym.^4-5*ym.^2-54*ym...
   +(5/2)*z0.^4-(25/2)*z0.^2-666*z0...
   +(1/2)*(xm-ym).^2+(5/2)*(ym-z0).^2; %aqui son imprescindibles los .^ porque estamos operando elemento a elemento

% Curvas de nivel
figure();
contour(xm,ym,Em,30); %dibujamos 30 curvas de nivel
hold on;
plot(x_sol(1),x_sol(2),'ro'); %dibujamos con un punto rojo las dos primeras componentes de la solucion de Newton
grid on;
xlabel('x'); ylabel('y');
title('Curvas de nivel de la energia E(x,y,z_{sol})');
legend('Curvas de nivel','Punto de funcionamiento');

% Superficie con curvas de nivel
figure();
meshc(xm,ym,Em); %dibujamos una superficie 3D tipo malla de la funcion dada por Em sobre la rejilla definida por xm e ym
%meshc tambien añade las curvas de nivel proyectadas en el plano inferior
hold on;
plot3(x_sol(1),x_sol(2),E(x_sol),'ro'); %marcamos con un circulo rojo en la gráfica 3D el punto de funcionamiento hallado por Newton
%Las coordenadas del punto de funcionamiento son (x_sol(1), x_sol(2)) en el plano y altura E(x_sol); 
xlabel('x'); ylabel('y'); zlabel('E');
title('Superficie de energia y punto de funcionamiento');
grid on;

%% ---------------------------------------------------
%% Modelos lineales del circuito: pequena senal y calibracion
%% ---------------------------------------------------
disp('...........')
disp('PEQUEÑA SEÑAL EN EL PUNTO DE FUNCIONAMIENTO')
disp('...........')

% Matriz incremental del circuito en el punto de funcionamiento
A = hesE(x_sol);          % Jacobiano J_F(x_sol)

% Término independiente del sistema linealizado
b = -gradE(x_sol);        % -F(x_sol)

% Resolución del sistema lineal de pequeña señal
d = A\b                  % corrección de tensiones DC

% Cálculo del residual del SEL
r = b - A*d;             % residual lineal
norm_r = norm(r)       % norma euclídea del residual

% Número de condición de la matriz incremental
condA = cond(A)          % condicionamiento en norma 2

disp('...........')
disp('CALIBRACION DEL MODELO')
disp('...........')

b = [1; 3; 5; -2];

M1 = [1 1;
      1 2;
      1 3;
      1 4];

M2 = [1 2;
      1 2;
      1 2;
      1 2];

% Analisis de rango
rank(M1)
rank(M2)

% --- Campaña 1 ---
disp('Campaña M1')

p_DI_1 = M1\b
p_PS_1 = pinv(M1)*b
p_QR_1 = solqr(M1,b)

norm(b-M1*p_DI_1)
cond(M1)

% --- Campaña 2 ---
disp('Campaña M2')

p_DI_2 = M2\b
p_PS_2 = pinv(M2)*b
p_QR_2 = solqr(M2,b)

norm(b-M2*p_PS_2) %si la matriz no tiene rango completo por columnas, la pseudoinversa da la solucion de minima norma
cond(M2)

%% ---------------------------------------------------
%% Modos incrementales y ajuste de un bloque no lineal del circuito
%% ---------------------------------------------------
disp('...........')
disp('ANALISIS ESPECTRAL')
disp('...........')

A = hesE(x_sol); % A=J_F(x_sol)

[V,D] = eig(A)

% Mayor autovalor 
aut = diag(D); %vector con la diagonal principal de la matriz D
[autmax,idx] = max(aut);
vmax = V(:,idx); %me quedo con la columna de V con el autovector correspondiente al mayor autovalor

autmax
norm(vmax,2) %comprobar normalización en norma 2
norm(A*V - V*D,2) %comprobar A V = V D

disp('...........')
disp('AJUSTE DE UN MODELO APROXIMADO')
disp('...........')

u = (0:0.1:1)'; %particion del intervalo [0,1]
y = sin(u); %salida 

% Matriz tipo Vandermonde truncada (grado 2)
M = [ones(size(u)) u u.^2];

format long
disp('Division a la izquierda')
aDI = M\y, norm(aDI,2)

disp('Pseudoinversa') %solucion de minima norma
aPS = pinv(M)*y, norm(aPS,2)

disp('QR (solqr)')
aQR = solqr(M,y), norm(aQR,2)

disp('QR reducido (qr(M,0))')
[Q1,R1] = qr(M,0);
aQR1 = R1\(Q1'*y), norm(aQR1,2)

disp('QR explicito')
[Q,R] = qr(M);
c = Q'*y;
aQR2 = R(1:3,1:3)\c(1:3), norm(aQR2,2)

disp('Ecuaciones normales')
aEN = (M'*M)\(M'*y), norm(aEN,2)

disp('Condicionamiento')
cond(M)
cond(M'*M)

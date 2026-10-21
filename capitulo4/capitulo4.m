%=====================================================================
% CAPITULO 4. MODELOS PROBABILISTICOS, SIMULACION Y CADENAS DE MARKOV EN TELECOMUNICACIONES
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

%% ---------------------------------------------------
%% Simulacion de medidas aleatorias en un sistema de telecomunicaciones
%% ---------------------------------------------------
disp('--------------------')
disp('Simulacion de medidas aleatorias en un sistema de telecomunicaciones')
disp('--------------------')
format compact

pkg load statistics;

disp('--------------------')
disp('Apartado a)')
disp('--------------------')

k = 10/11; lambda = 2;
xs = 0:1e-3:15;
ys = wblpdf(xs,lambda,k);

figure(1);
plot(xs,ys), grid on
title('X \sim Wbl(10/11,2)')

disp('--------------------')
disp('Apartado b)')
disp('--------------------')

sigma = 2; k = 2; lambda = sigma*sqrt(2);

yws = wblpdf(xs,lambda,k);
yrs = raylpdf(xs,sigma);

figure(2);
plot(xs,yws,'r-',xs,yrs,'b:'), grid on
title('Y \sim Wbl(2,\sigma\sqrt{2}), Z \sim Ray(\sigma)')

disp('--------------------')
disp('Apartado c)')
disp('--------------------')

N1 = 4+7*randn(5,10)
N1b = normrnd(4,7,5,10)

N2 = -3+2*randn(5,10)
N2b = normrnd(-3,2,5,10)

U1 = unidrnd(6,5,10)

U2 = unifrnd(-2,2,5,10)

B = binornd(100,0.4,5,10)
P = poissrnd(9,5,10)
R = raylrnd(4,5,10)

p = 1-0.70; %Geo(q=0.70), con q = probabilidad de fracaso
G = geornd(p,5,10)+1

%Apartado d)
disp('--------------------')
disp('Apartado d)')
disp('--------------------')

mean(N1(:)), std(N1(:),1)
mean(N2(:)), std(N2(:),1)
mean(U1(:)), std(U1(:),1)
mean(U2(:)), std(U2(:),1)
mean(B(:)), std(B(:),1)
mean(P(:)), std(P(:),1)
mean(R(:)), std(R(:),1)
mean(G(:)), std(G(:),1)

disp('--------------------')
disp('Apartado e)')
disp('--------------------')

disp('Variables discretas: U(6), Bin(100,0.4), Poi(9), Geo(0.7)')
disp('Variables continuas: N(4,7), N(-3,2), U(-2,2), Ray(4)')

%% ---------------------------------------------------
%% Simulacion mediante TIP y metodo de Montecarlo
%% ---------------------------------------------------
disp('--------------------')
disp('Simulacion mediante TIP')
disp('--------------------')
format compact
pkg load statistics;

disp('--------------------')
disp('Apartado a)')
disp('--------------------')

%Simulacion TIP de la seleccion de recurso
clear all;
xis = 1:6; %soporte
pxis = [0.1 0.2 0.4 0.1 0.1 0.1]; %pdf
Fxis = cumsum(pxis); %cdF

u = rand %valor uniforme en (0,1)
find(u < Fxis); xis(ans(1))
%nos quedamos con el primer recurso cuya cdF acumulada supera a u

disp('--------------------')
disp('Apartado b)')
disp('--------------------')

function y = sim_TIP_Montecarlo(instante,vez,intentos)
% Estudia por simulacion (Montecarlo) la probabilidad de que:
% en el instante numero "instante" aparezca por "vez"-esima vez
% el recurso 5, usando simulacion TIP de la variable discreta.
%
% Interpretacion:
% - En cada instante se selecciona un recurso segun una distribucion discreta.
% - Queremos que el "vez"-esimo 5 ocurra exactamente en ese instante.
%
% Esto corresponde a una variable NegBin(vez,p), donde p=0.1.

pxis = [0.1 0.2 0.4 0.1 0.1 0.1]; xis = 1:6; Fxis = cumsum(pxis);

exitos = 0;
for n = 1:intentos
   s = 0; %contador de veces que aparece el recurso 5
   for k = 1:instante
      find(rand < Fxis); recurso = xis(ans(1));
      u = (recurso == 5); %1 si sale 5, 0 si no
      s = s + u;
   end

   %Comprobamos que:
   % - han salido exactamente "vez" veces el recurso 5
   % - y el ultimo instante ha sido un 5
   if (s == vez) && (u == 1)
      exitos = exitos + 1;
   end
end
y = exitos/intentos;
endfunction;

sim_TIP_Montecarlo(20,3,10000)

% Comparacion con el valor teorico
% Estamos modelando el numero de fallos cometidos hasta obtener la tercera vez el recurso 5.
% Esto sigue una distribucion binomial negativa NegBin(n,p), donde:
%   n = 3  (numero de exitos que queremos)
%   p = 0.1 (probabilidad de exito en cada instante, es decir, obtener un 5)
% Queremos calcular:
%  P(que el 3er exito ocurra en el instante 20)
% En una NegBin(n,p), la funcion nbinpdf(k,n,p) en Octave devuelve:
%  P(que haya k fallos antes del n-esimo exito)
% Si el n-esimo exito ocurre en el instante 20:
%   - hay 3 exitos en total
%   - por tanto, hay 20 - 3 = 17 fallos antes del ultimo exito
% Por eso usamos:
%   k = 17, n = 3, p = 0.1

nbinpdf(17,3,0.1)

disp('--------------------')
disp('Apartado c)')
disp('--------------------')

N = 1000;        % numero de muestras que vamos a generar
lambda = 3;      % parametro de la exponencial Exp(lambda)
% Simulacion TIP de una variable exponencial
% Si U ~ U(0,1), entonces X = -log(1-U)/lambda ~ Exp(lambda)
% Generamos N valores independientes de la variable exponencial
t = -log(1-rand(1,N))/lambda;
% Construccion del histograma
% Dividimos el intervalo [0,lambda] en subintervalos de amplitud 0.1
% histc cuenta cuantos valores caen en cada intervalo
ni = histc(t,0:0.1:lambda); % frecuencias absolutas
% Representacion del histograma normalizado
% Para aproximar la densidad:
% dividimos las frecuencias entre (N * amplitud del intervalo = 0.1)
figure(3)
bar(0:0.1:lambda,ni/(0.1*N),'histc')
% La pdf de una Exp(3) es: f(x)=3*exp(-3*x)
% La representamos en el mismo grafico para comparar
hold on
fplot('3*exp(-3*x)',[0 3])
hold off
grid on
title('Histograma normalizado y pdf teorica de Exp(3)')

disp('--------------------')
disp('Estimacion de cobertura mediante Montecarlo e intervalos de confianza')
disp('--------------------')
format compact

% Generacion de puntos (Montecarlo)
% Simulamos N posibles terminales distribuidos uniformemente en R
N = 1e4;
x = [20*rand(N,1) 10*rand(N,1)]; % peticiones de servicio en [0,20]x[0,10]

% Comprobacion de cobertura por cada antena:
% Para cada antena, calculamos la distancia al punto
% y comprobamos si es menor o igual que el radio (3 km)

%veamos si las señales estan cubiertas por la antena centrada en (-1,5).
%Para ello, estudiamos si la distancia de la señal a la antena es menor o
%igual que 3. c1 es un vector booleano donde 0 indica que la señal
%no queda cubierta por la antena y 1 indica que queda cubierta
xx=[x(:,1)+1 x(:,2)-5];d1=sqrt(xx(:,1).^2+xx(:,2).^2);c1=(d1<=3);

%veamos si las señales estan cubiertas por la antena centrada en (5,4).
xx=[x(:,1)-5 x(:,2)-4];d2=sqrt(xx(:,1).^2+xx(:,2).^2);c2=(d2<=3);

%veamos si las señales estan cubiertas por la antena centrada en (15,7).
xx=[x(:,1)-15 x(:,2)-7];d3=sqrt(xx(:,1).^2+xx(:,2).^2);c3=(d3<=3);

%veamos si las señales estan cubiertas por la antena centrada en (10,1).
xx=[x(:,1)-10 x(:,2)-1];d4=sqrt(xx(:,1).^2+xx(:,2).^2);c4=(d4<=3);

%veamos si las señales estan cubiertas por la antena centrada en (12,2).
xx=[x(:,1)-12 x(:,2)-2];d5=sqrt(xx(:,1).^2+xx(:,2).^2);c5=(d5<=3);

%veamos si las señales estan cubiertas por la antena centrada en (19,1).
xx=[x(:,1)-19 x(:,2)-1];d6=sqrt(xx(:,1).^2+xx(:,2).^2);c6=(d6<=3);

%veamos si las señales estan cubiertas por la antena centrada en (15,2).
xx=[x(:,1)-15 x(:,2)-2];d7=sqrt(xx(:,1).^2+xx(:,2).^2);c7=(d7<=3);

% Numero de antenas que cubren cada peticion de servicio
c = c1 + c2 + c3 + c4 + c5 + c6 + c7;

disp('-------------------------------------------------')
disp('Apartado a): cobertura por al menos una antena')
disp('-------------------------------------------------')

Na = sum(c > 0);      % numero de peticiones cubiertas
p = Na/N;             % proporcion estimada
S = p*20*10;      % area estimada (area total = 200)

q = 1-p;

% Intervalo de confianza (95%)
alfa=1-0.95; rho=alfa/2;
pkg load statistics;
zc=norminv(1-rho,0,1)

Ip = [p - zc*sqrt(p*q/N), p + zc*sqrt(p*q/N)]
Is = Ip*200 % intervalo para el area

disp('--------------------------------------------------')
disp(' Apartado b): cobertura por mas de una antena')
disp('--------------------------------------------------')

Nb = sum(c > 1); % peticiones con solapamiento
pb = Nb/N;
Sb = pb*200;

qb = 1-pb;

Ipb = [pb - zc*sqrt(pb*qb/N), pb + zc*sqrt(pb*qb/N)]
Isb = Ipb*200

disp('--------------------')
disp('Cobertura con poblacion no uniforme (normal bivariante)')
disp('--------------------')
format compact
pkg load statistics;

disp('--------------------------------------------------')
disp(' Apartado a): Generacion de puntos (normal bivariante)')
disp('--------------------------------------------------')

N = 1e4;
mu = [12;6];
Sigma = [3 0.5; 0.5 2];
x = mvnrnd(mu',Sigma,N); %puntos no uniformes

%--------------------------------------------------
% Filtrado: nos quedamos solo con los puntos en R
%--------------------------------------------------
R = (x(:,1)>=0).*(x(:,1)<=20).*(x(:,2)>=0).*(x(:,2)<=10);
%R es 0 si alguna de esas condiciones no se cumple, y es 1 si todas se cumplen

Nr = sum(R>0); %numero de señales que han caido en el rectangulo R

disp('--------------------------------------------------')
disp(' Apartado b): Proporcion de usuarios cubiertos por al menos una antena')
disp('--------------------------------------------------')


% Cobertura (igual que antes)
xx=[x(:,1)+1 x(:,2)-5];d1=sqrt(xx(:,1).^2+xx(:,2).^2);c1=(d1<=3);
xx=[x(:,1)-5 x(:,2)-4];d2=sqrt(xx(:,1).^2+xx(:,2).^2);c2=(d2<=3);
xx=[x(:,1)-15 x(:,2)-7];d3=sqrt(xx(:,1).^2+xx(:,2).^2);c3=(d3<=3);
xx=[x(:,1)-10 x(:,2)-1];d4=sqrt(xx(:,1).^2+xx(:,2).^2);c4=(d4<=3);
xx=[x(:,1)-12 x(:,2)-2];d5=sqrt(xx(:,1).^2+xx(:,2).^2);c5=(d5<=3);
xx=[x(:,1)-19 x(:,2)-1];d6=sqrt(xx(:,1).^2+xx(:,2).^2);c6=(d6<=3);
xx=[x(:,1)-15 x(:,2)-2];d7=sqrt(xx(:,1).^2+xx(:,2).^2);c7=(d7<=3);

c = c1+c2+c3+c4+c5+c6+c7;

% Proporcion de cobertura (solo peticiones en R)
Na = sum(c.*R>0); %de las señales en R vemos cuales estan cubiertas por alguna antena

p = Na/Nr %proporcion estimada

q = 1-p;
% Intervalo de confianza
alfa=1-0.95; rho=alfa/2;
zc=norminv(1-rho,0,1);

Ip = [p - zc*sqrt(p*q/Nr), p + zc*sqrt(p*q/Nr)]

disp('--------------------------------------------------')
disp(' Apartado c): Numero de usuarios cubiertos por al menos una antena')
disp('--------------------------------------------------')
Pobl = 25000*p %personas cubiertas
Ipobl = 25000*Ip

disp('--------------------')
disp('Estimacion de probabilidades de retardo mediante Montecarlo')
disp('--------------------')
format compact
pkg load statistics;

disp('-----------------------------------------------')
disp('Apartado a): suma de retardos Erlang/Gamma')
disp('-----------------------------------------------')

% Recordemos que una Erl(n,beta) es una Gamma con parametro de forma n
% y parametro de escala beta, cuando n es natural

N = 1e4; %numero de simulaciones
cont = 0;  %contador de exitos
for k = 1:N
  % Generamos un retardo de cada subsistema
  x1 = gamrnd(2,5);
  x2 = gamrnd(3,3);
  % Comprobamos si el retardo total supera el umbral
  if x1 + x2 > 10
     cont = cont + 1;
  end
end

p = cont/N %proporcion estimada
q = 1 - p;
% Intervalo de confianza al 95%
alfa = 1 - 0.95; rho = alfa/2;
zc = norminv(1-rho,0,1);

Ip = [p - zc*sqrt(p*q/N), p + zc*sqrt(p*q/N)]

disp('-----------------------------------------------------------')
disp('Apartado b): suma de retardos exponenciales independientes')
disp('-----------------------------------------------------------')

N = 1e5;   %numero de simulaciones
cont = 0;  %contador de exitos
for k = 1:N
  % Generamos un vector con los 10 retardos exponenciales
  % En Octave, exprnd usa el parametro beta = 1/lambda
  x = exprnd(1./(1:10));

  % Comprobamos si el retardo total supera el umbral
  if sum(x) > 3
     cont = cont + 1;
  end
end

p = cont/N %proporcion estimada
q = 1 - p;
% Intervalo de confianza del 99%
alfa = 1 - 0.99; rho=alfa/2;
zc = norminv(1-rho,0,1);

Ip = [p - zc*sqrt(p*q/N), p + zc*sqrt(p*q/N)]

%% ---------------------------------------------------
%% Modelizacion conjunta de dos magnitudes aleatorias
%% ---------------------------------------------------
clear all; format compact;
pkg load symbolic;
syms x y real;

disp('Apartado a)');
% Soporte: x >= 0, x^2 <= y <= 1
I = int(int(x + y, y, x^2, 1), x, 0, 1); % integral doble sobre el soporte
c = 1 / I

disp('Apartado b)');
fx = c * int(x + y, y, x^2, 1);  % para un x fijo, y pertenece a [x^2,1]
fx = simplify(fx)

FX = int(fx, x, 0, x);
FX = simplify(FX)

fy = c * int(x + y, x, 0, sqrt(y)); % para un y fijo, x pertenece a [0, sqrt(y)]
fy = simplify(fy)

FY = int(fy, y, 0, y);
FY = simplify(FY)

disp('Apartado c)');
% Esperanza E(X)
EX = int(x * fx, x, 0, 1);
EX = simplify(EX)

% Varianza V(X) = E(X^2) - (E(X))^2
EX2 = int(x^2 * fx, x, 0, 1);
VX = simplify(EX2 - EX^2)

% Esperanza E(Y)
EY = int(y * fy, y, 0, 1);
EY = simplify(EY)

% Varianza V(Y)
EY2 = int(y^2 * fy, y, 0, 1);
VY = simplify(EY2 - EY^2)

%% ---------------------------------------------------
%% Evolucion temporal de tareas en una red: cadenas de Markov
%% ---------------------------------------------------
disp('--------------------')
disp('Cadena de Markov: evolucion de tareas')
disp('--------------------')
format compact

disp('-----------------------------------------------')
disp('Apartado a): matriz de transicion del sistema')
disp('-----------------------------------------------')

% Matriz de transicion
T=[0.99 0.01 0 0 0;
   0.05 0.8 0.1 0.05 0;
   0 0 0.8 0.15 0.05;
   0 0 0.15 0.85 0;
   0 0 0 0 1]

disp('-----------------------------------------------')
disp('Apartado b): distribucion tras 10, 100 y 10000 instantes')
disp('-----------------------------------------------')

% Funcion de probabilidad inicial
p0=[1 0 0 0 0] %todas las tareas fuera del sistema

% Evolucion teorica
p10=p0*T^10
p100=p0*T^100
p10000=p0*T^10000

disp('-----------------------------------------------')
disp('Apartado c): distribucion estacionaria')
disp('-----------------------------------------------')

[V,D]=eig(T');
autovalores=abs(diag(D))
%1 es simple y todos los demas tienen modulo menor
v=V(:,1)';
v=v/sum(v) %normalizamos: pdf estacionaria

disp('-----------------------------------------------')
disp('Apartado d): simulacion TIP de 10^4 tareas')
disp('-----------------------------------------------')

NTARS=1e4;
clear v;
v(1,:)=ones(1,NTARS); %estado inicial: todas en "fuera"
Fxis=cumsum(T,2); %cdF por filas
for k=1:100 %100 instantes
  for c=1:NTARS
    e=v(k,c); %estado actual
    x=rand;
    find(x < Fxis(e,:));
    v(k+1,c)=ans(1);
  end
end

disp('----------------------------------------------------')
disp('Frecuencias empiricas tras 10 y 100 instantes')
disp('----------------------------------------------------')

v10=v(11,:);
Freq10=[sum(v10==1) sum(v10==2) sum(v10==3) sum(v10==4) sum(v10==5)]/NTARS

v100=v(101,:);
Freq100=[sum(v100==1) sum(v100==2) sum(v100==3) sum(v100==4) sum(v100==5)]/NTARS

disp('----------------------------------------------------')
disp('Visualizacion: cada 500 tareas, cada 4 instantes')
disp('----------------------------------------------------')

v(1:4:end,1:500:NTARS)

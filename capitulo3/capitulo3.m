%=====================================================================
% CAPITULO 3. ESTADISTICA DESCRIPTIVA Y CALIBRACION DE MEDIDAS EN TELECOMUNICACIONES
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

%% ---------------------------------------------------
%% Depuracion de errores de medida: datos anomalos
%% ---------------------------------------------------
%================================================
% CAPITULO 3 - Depuracion de outliers
%================================================
clear all; close all; clc; format long;
disp('.............................................')
disp('CAPITULO 3 - Depuracion de outliers')
disp('.............................................')

%Cargamos los datos desde el fichero datos.mat
load datos
whos %Vemos que variables hay definidas
N = length(X);

%Visualizamos los datos originales (errores de medida)
figure(1); plot(X,'.'); grid on;
title('Datos originales X (errores de medida)');

%Ordenamos la muestra para localizar cuartiles
XX = sort(X);
figure(2), plot(XX); %Ordenamos los datos de X en la variable XX usando sort y los dibujamos en la figura 2

%Calculamos cuartiles con una regla discreta simple (con interpolacion)
disp ('Obtengamos los cuartiles')
n1=N*1/4 , n2=N*1/2 , n3=N*3/4 %calculamos cN para c de cada cuartil
nn1=floor(n1), nn2=floor(n2), nn3=floor(n3) %queremos comprobar si cN es un numero natural usando floor
%floor(cN) devuelve el entero inferior a cN truncando

%Calculamos el primer cuartil
if n1 == nn1, Q1=(XX(nn1)+XX(nn1+1))/2, else, Q1=XX(nn1+1), end;
%Calculamos el segundo cuartil , que es la mediana
if n2 == nn2, Me=(XX(nn2)+XX(nn2+1))/2, else, Me=XX(nn2+1), end;
%Calculamos el tercer cuartil
if n3 == nn3, Q3 =(XX(nn3)+XX(nn3+1))/2, else,
Q3=XX(nn3+1), end;

disp('Obtengamos el intervalo para datos no anomalos')
Lmin=Me-3*(Me-Q1); %Calculamos el extremo inferior del intervalo para datos no anomalos del enunciado y lo guardamos en Lmin
Lmax=Me+3*(Q3-Me); %Calculamos el extremo superior del intervalo para datos no anomalos del enunciado y lo guardamos en Lmax
disp('Vamos a buscar los datos no anomalos')
La = find((X > Lmax)|(X < Lmin)); %Utilizamos el comando find para filtrar los datos de X menores que Lmin o los mayores de Lmax
L = find((X <= Lmax)&(X >= Lmin)); %Utilizamos el comando find para filtrar los datos de X mayores o iguales que Lmin y menores o iguales que Lmax (es decir, los contenidos en el intervalo del enunciado)

Y=X(L); %Creamos la variable Y con los datos de X no anomalos (los que pertenecen al intervalo del enunciado)
Ny = length(Y);

disp('Numero de outliers eliminados: ')
length(La)

%Comparamos media y varianza (varianza poblacional: divisor N)
mediaX = mean(X);
varX   = var(X,1);

mediaY = mean(Y);
varY   = var(Y,1);

disp('Comparacion [media varianza]: filas (X, Y)')
[mediaX, varX;
 mediaY, varY]

%Ojo: al no tener mismas medias, no basta con ver quien tiene mas desviacion tipica (hay que calcular coeficientes de variacion, con la salvedad de que hay positivos y negativos)

%% ---------------------------------------------------
%% Caracterizacion estadistica del error
%% ---------------------------------------------------
disp('.............................................')
disp('CAPITULO 3 - Caracterizacion estadistica')
disp('.............................................')

%-----------------------------
%(A) Medidas SIN agrupar sobre Y
%-----------------------------
disp('--- Medidas sin agrupar (Y) ---')

YY = sort(Y);
Ny = length(Y);

%Cuartiles discretos (misma regla que en la depuracion de outliers)
n1 = Ny/4;  n2 = Ny/2;  n3 = 3*Ny/4;
nn1 = floor(n1); nn2 = floor(n2); nn3 = floor(n3);
if n1 == nn1, Q1Y = (YY(nn1)+YY(nn1+1))/2; else, Q1Y = YY(nn1+1); end
if n2 == nn2, MeY = (YY(nn2)+YY(nn2+1))/2; else, MeY = YY(nn2+1); end
if n3 == nn3, Q3Y = (YY(nn3)+YY(nn3+1))/2; else, Q3Y = YY(nn3+1); end

Q1Y, MeY, Q3Y

% Medidas basicas
mediaY = mean(Y);
varY   = var(Y,1); %Varianza
sY     = sqrt(varY);
sesgoY = skewness(Y); %Fisher
curtY  = kurtosis(Y) - 3; %Curtosis

mediaY, varY, sY, sesgoY, curtY

DMY = mean(abs(Y-mediaY)); %Desviacion media respecto a la media
MCY = sqrt(mean((Y-mediaY).^2)); %Media cuadratica de las desviaciones a la media
DMY, MCY

%-----------------------------
% (B) Agrupacion en 7 clases + histograma por densidades
%-----------------------------
disp('--- Medidas agrupadas (7 clases) ---')

disp ('Vamos a agrupar los datos en 7 clases')
n = zeros(1,7); %Agrupemos los datos de Y en 7 clases
%Para ello creamos un vector fila n de 7 componentes con las frecuencias absolutas que inicializamos a cero.
for k = 1:Ny %En un bucle, barremos los datos en Y, vemos a que clase pertenece e incrementamos en uno su frecuencia absoluta
    if Y(k) < -5
      n(1)=n(1)+1;
    elseif Y(k) < -3
      n(2)=n(2)+1;
    elseif Y(k) < -1
      n(3)=n(3)+1;
    elseif Y(k) < 1
      n(4)=n(4)+1;
    elseif Y(k) < 3
      n(5)=n(5)+1;
    elseif Y(k) < 5
      n(6)=n(6)+1;
    else
      n(7)=n(7)+1;
    end
end
n

Li = [-7, -5, -3, -1, 1, 3, 5, 7]; %limites
x  = [-6 -4 -2 0 2 4 6]; %Marcas de clase: para obtener las marcas de clase usamos el criterio de intervalos de amplitud infinita

disp('Calculemos la moda')
a  = diff(Li); h = n./a; %Obtenemos la amplitud de cada clase y su altura en el histograma

function barhistc(limits,heights)
    % (by Pablo Guerrero-Garcia <pablito@ctima.uma.es>, May 2025)
    % (   Dept. Applied Mathematics, University of Malaga, Spain)
    % Version adaptada: recibe todos los extremos de las clases (n+1 valores)
    widths = diff(limits); figure, hold on
    for currect=[limits(1:end-1);zeros(size(heights));widths;heights]
        rectangle('Position',currect','FaceColor',[0 0.5 0.5]);
    end; xticks(limits)
    axis([limits(1) limits(end) 0 min(heights)/2+max(heights)]), hold off
endfunction

barhistc(Li,h), hold on;
%plot(x,h); %Descomentar si quiero el poligono de frecuencias
hold off;
%histograma sin normalizar, i.e., en funcion de ni y no de fi

[val,ind]=max(h) %Obtenemos la clase modal, que es la que tiene mayor altura en el histograma: ind es el indice de la clase modal
d1=h(ind)-h(ind-1), d2=h(ind)-h(ind+1) %Usaremos estas diferencias para calcular la moda
Mo=Li(ind)+a(ind)*d1/(d1+d2) %formula de la moda en el caso continuo

disp('Obtengamos los cuartiles')
n1=Ny/4, n2=Ny/2, n3=3*Ny/4 %Calculamos cN con c=0.25, c=0.5 y c=0.75, para obtener Q1, Q2 y Q3
nac=cumsum(n); [n' nac'] %Con cumsum obtenemos las frecuencias absolutas acumuladas
L=find(n1<nac); ind=L(1); %Cuscamos la primera frecuencia absoluta acumulada que rebasa el valor 0.25N
Q1=Li(ind)+a(ind)*(n1-nac(ind-1))/n(ind) %Aplicamos la formula para obtener Q1
L=find(n2<nac); ind=L(1); %Buscamos la primera frecuencia absoluta acumulada que rebasa el valor 0.5N
Me=Li(ind)+a(ind)*(n2-nac(ind-1))/n(ind) %Aplicamos la formula para obtener Q2=Me (mediana)
L=find(n3<nac); ind=L(1); %Buscamos la primera frecuencia absoluta acumulada que rebasa el valor 0.75N
Q3=Li(ind)+a(ind)*(n3-nac(ind-1))/n(ind) %Aplicamos la formula para obtener Q3

disp('Obtengamos los momentos ordinarios de orden 1 a 4')
m1g=sum(n.*x)/Ny;
m2g=sum(n.*x.^2)/Ny;
m3g=sum(n.*x.^3)/Ny;
m4g=sum(n.*x.^4)/Ny;
disp('Obtengamos los momentos centrales de orden 3 y 4')
mu3g=m3g-3*m2g*m1g+2*m1g^3;
mu4g=m4g-4*m3g*m1g+6*m2g*m1g^2-3*m1g^4;

disp('Calculamos la media de x, la varianza, la desviacion tipica, el coeficiente de asimetria de Fisher y el coeficiente de puntiagudez de Fisher')
mediag=m1g;
varg=m2g-m1g^2;
sg=sqrt(varg);
sesgog=mu3g/sg^3;
curtg=mu4g/sg^4-3;
mediag, varg, sesgog, curtg

disp('obtenemos la desviacion media respecto a su media y media cuadratica de las desviaciones a su media, definiendo la variable dg=x-m1g')
dg =x-m1g;
DMg=sum(n.*abs(dg))/Ny;
MCg=sqrt(sum(n.*dg.^2)/Ny);
DMg, MCg

disp('Comparacion (sin agrupar vs agrupado): [media var sesgo curtosis]')
[mediaY, varY, sesgoY, curtY;
 mediag, varg, sesgog, curtg]

%% ---------------------------------------------------
%% Campana de calibracion
%% ---------------------------------------------------
disp('.............................................')
disp('CAPITULO 3 - Campaña de calibracion + error depurado')
disp('.............................................')

%------------------------------------------------
%Datos base: excitacion controlada y salida ideal
%------------------------------------------------
X_cal = [1 3 5 6 7 10];
Z_base = [0.5 13 47.1 68 95.3 196.5];

%------------------------------------------------
%Medida real: añadimos una fraccion del error depurado Y
%------------------------------------------------
%Usamos las 6 primeras muestras de Y para "contaminar" la calibracion.
%El factor alpha controla el nivel de perturbacion.
alpha = 0.5;
Z=Z_base+alpha*Y(1:6)

%------------------------------------------------
%Diagrama de dispersion (X_cal, Z)
%------------------------------------------------
figure; grid on; hold on;
plot(X_cal, Z, 'ro');
xlabel('X_{cal}'); ylabel('Z');
title('Calibracion: datos medidos (tabla base + error depurado)');

%------------------------------------------------
%Ajuste lineal: z = a + b x
%------------------------------------------------
disp ('Ajuste lineal')
p1 = polyfit(X_cal, Z, 1);     % p1(1)=b, p1(2)=a

disp ('Determinemos la bondad del ajuste')
N = length(X_cal);
%Medias y varianzas
mX= mean(X_cal);
mZ= mean(Z);
vX=sum(X_cal.^2)/N-mX^2; %O bien var(X_cal,1)
vZ=sum(Z.^2)/N-mZ^2; %O bien var(Z,1)
covar=sum(X_cal.*Z)/N-mX*mZ; %Covarianza
r=covar/sqrt(vX*vZ); %Coeficiente de correlacion lineal
Vr=(1-r^2)*vZ; %Varianza residual
disp('Calculo de SSE y coeficiente de determinacion (CDL) caso lineal')
SSEL=N*Vr
CDL=r^2

disp('Ajuste cuadratico')
p2=polyfit(X_cal,Z,2)
%Bondad del modelo
Ze=polyval(p2,X_cal); %Z estimados
e=Z-Ze; %Errores
Ve=var(e,1); %Varianza residual
disp('Calculo de SSE y coeficiente de determinacion caso cuadratico')
SSEC=sum(e.^2)
R2C=1-Ve/vZ

disp('Comparacion (lineal vs cuadratico): [SSE, R2]')
[SSEL, CDL;
 SSEC, R2C]

disp ('Representacion grafica de los ajustes')
hold on
%Generacion de puntos para la grafica
Xpintar = min(X_cal):0.1:max(X_cal);
ZpintarL = polyval(p1,Xpintar);
%Grafica
grid on;
plot(Xpintar,ZpintarL,'b')
ZpintarC = polyval(p2,Xpintar);
plot(Xpintar,ZpintarC,'r')

%Ajuste lineal con pesos
%------------------------------------------------
disp('Ajuste lineal con pesos')

%Pesos: damos mas peso a los puntos centrales (5,6,7)
w=[1 2 4 4 4 1]; %Pesos (a mayor w, mayor importancia)

M=[ones(length(X_cal),1) X_cal(:)] %Matriz del sistema sobredeterminado
Wsqrt=diag(sqrt(w)) %Generamos una matriz diagonal con las raices de los pesos

pw=(Wsqrt*M)\(Wsqrt*Z'); %Resolvemos el sistema sobredeterminado con pesos
aw=pw(1)
bw=pw(2)

Zw=aw+bw*X_cal; %O bien polyval([bw aw],X_cal)
ew=Z-Zw;

SSEw=sum(ew.^2); %SSE sin ponderar de la recta con pesos

disp('Comparacion de la SSE (sin ponderar) de la recta sin pesos y de la recta con pesos:')
SSEL, SSEw

%Dibujamos en la misma grafica la recta del ajuste con pesos en verde
Zpintarw = aw+bw*Xpintar; %O bien polyval([bw aw], Xpintar)
plot(Xpintar,Zpintarw,'g')
hold off

%% ---------------------------------------------------
%% Regresion lineal multiple y analisis de correlacion
%% ---------------------------------------------------
disp('.............................................')
disp('CAPITULO 3 - Regresión múltiple y análisis de correlación (RLM y SVD)')
disp('.............................................')

%Partimos de los datos de la campaña de calibracion (6 observaciones) y del error depurado Y
%X_cal, Z  y el error depurado Y
%------------------------------------------------
X_cal=X_cal(:); %Aseguramos vector columna
N=length(X_cal);

%Para usar el error depurado en la simulacion, tomamos 6 valores:
Y6=Y(1:6); %nos quedamos con los 6 primeros valores de Y
Y6=Y6(:); %aseguramos vector columna

%Construimos T y F (variables auxiliares)

%Tiempo discreto de la campaña (6 instantes)
t = (1:N)';

%T: temperatura equivalente (variacion lenta + pequeño ruido)
T=25+2*sin(2*pi*t/N)+0.2*randn(size(t));

%F: deriva/offset equivalente
F=-0.10+0.15*X_cal+0.15*randn(size(t));


disp('Ajuste RLM')
b0 = 0.20; b1 = 1.50; b2 = 0.05; b3 = 0.80; %Parametros de referencia
Z2 = b0 + b1*X_cal + b2*T + b3*F + 0.5*Y6;
M = [ones(N,1) X_cal T F]; %Matriz M del sistema sobredeterminado
beta = M\Z2; %Resolvemos el sistema sobredeterminado con la division a la izquieda

Z2M=M*beta; %valores estimados
eM=Z2-Z2M; %vector de errores

SSE_M=sum(eM.^2); %SSE para el ajuste RLM
VeM=var(eM,1);
R2_M =1-VeM/var(Z2,1); %Coeficiente de determinacion para el ajuste RLM

SSE_M, R2_M


%Covarianzas y correlaciones de D = [Z2, X_cal, T, F]
disp('Covarianzas y correlaciones')
D=[Z2 X_cal T F];
COV=cov(D,1) %matriz de covarianzas
COR=corr(D) %matriz de correlaciones

disp('Matrices centrado--escalada y tipificado--escalada')
mu=mean(D) %vector de medias
sig=std(D,1) %vector de desviaciones tipicas

Dv=(D-ones(N,1)*mu)/sqrt(N); %matriz centrado-escalada (le restamos la media y dividimos entre la raiz de N)
Dr=Dv./(ones(N,1)*sig); %matriz tipificado-escalada (dividimos la matriz centrado-escalada entre las desviaciones tipicas)

%Comprobaciones (deberian dar valores cercanos a 0)
norm(Dv'*Dv - COV)
norm(Dr'*Dr - COR)

disp('Autovalores de covarianzas/correlacions con eig y ordenados')
lambda_cov_eig=sort(eig(COV))
lambda_cor_eig=sort(eig(COR))

disp('Autovalores de covarianzas/correlacions con SVD y ordenados')
[U,S,V]  = svd(Dv);
[U2,S2,V2] = svd(Dr);

lambda_cov_svd=sort(diag(S).^2)
lambda_cor_svd=sort(diag(S2).^2)

%Comparaciones (deberian dar valores cercanos a 0)
norm(lambda_cov_eig-lambda_cov_svd)
norm(lambda_cor_eig-lambda_cor_svd)

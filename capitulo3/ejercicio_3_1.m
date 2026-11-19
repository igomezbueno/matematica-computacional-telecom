%=====================================================================
% EJERCICIO 3.1
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('-----------')
disp('EJERCICIO 3.1')
disp('-----------')

disp('-----------')
disp('Apartado a)')
disp('-----------')
%Definicion de datos
n=[54, 96, 130, 88, 85, 47]; %frecuencias
Li=[100, 300, 400, 500, 600, 700, 900]; %extremos de los intervalos

%Calculo de puntos medios
x=(Li(1:end-1)+Li(2:end))/2;
%Calculo de amplitudes
a=diff(Li);
%Calculo de alturas en el histograma
h=n./a;

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

disp('Grafica del histograma sin normalizar')

barhistc(Li,h), hold on;
%plot(x,h); %Descomentar si quiero el poligono de frecuencias
hold off;
%histograma sin normalizar, i.e., en funcion de ni y no de fi

disp('Calculo de la frecuencia acumulada')
nac=cumsum(n); [n' nac']

disp('-----------')
disp('Apartado b)')
disp('-----------')

disp('Cálculo de la moda')
[val,ind]=max(h);
d1=h(ind)-h(ind-1);
d2=h(ind)-h(ind+1);
Mo=Li(ind)+a(ind)*(d1/(d1+d2));
Mo

disp('Calculo de la mediana')
N=sum(n);
n2=N/2;
L=find(n2<nac); ind=L(1) % Encuentra el primer índice donde n2 < nac %O bien ind=find(n2<nac,1)
Me=Li(ind)+a(ind)*(n2-nac(ind-1))/n(ind);
Me

disp('Calculo de la media')
m1=sum(n.*x)/N;
media=m1;
media

disp('Calculo de la varianza')
m2=sum(n.*x.^2)/N;%segundo momento ordinario
varianza=m2-m1^2;
varianza

disp('-----------')
disp('Apartado c)')
disp('-----------')

disp('Calculemos el sesgo')
m3=sum(n.*x.^3)/N; %momento ordinario de orden 3
m3_central=m3-3*m2*m1+2*m1^3; %momento central de orden 3
s=sqrt(varianza); %desviacion tipica
sesgo=m3_central/s^3;
sesgo

%=====================================================================
% CAPITULO 1. INTRODUCCION A OCTAVE MEDIANTE EL ANALISIS DE SENALES
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

fs = 1000;                % número de muestras por segundo
t = linspace(0,1,fs);     % vector de tiempo

x = sin(2*pi*5*t);

  size(t), size(x)

x = sin(2*pi*5*t) + 0.2*randn(size(t));

xu = sin(2*pi*5*t) + 0.2*rand(size(t));

figure;
plot(t,x);
grid on;
title('Señal');
xlabel('Tiempo(s)');
ylabel('Amplitud');

figure;
clf;
plot(t,x,'b');      % primera curva
hold on;
plot(t,xu,'r');     % segunda curva superpuesta
hold off;
grid on;
title('Señales en la misma figura');
xlabel('Tiempo(s)');
ylabel('Amplitud');
legend('x','xu');

xmax = max(x)
[xmin,ind] = min(x)

energia = sum(x.^2)

N = length(x);
energia = 0;
for k = 1:N
    energia = energia + x(k)^2;
end

k = 1;
N = length(x);
energia = 0;
while k <= N
    energia = energia + x(k)^2;
    k = k + 1;
end

offset = mean(x);

xc = x - offset;

figure;
plot(t,x,'b',t,xc,'r');
legend('Original','Corregida');
grid on;

positivos = xc > 0

umbral = abs(xc) > 0.5

idx_pos = find(xc > 0)

idx_umbral = find(abs(xc) > 0.5)

valores_grandes = xc(idx_umbral);

hay_valores_grandes = any(abs(xc) > 1)

todas_acotadas = all(abs(xc) <= 1)

x2 = 0.8*sin(2*pi*5*t + pi/4) + 0.2*randn(size(t));

X = [xc; x2];

size(X)

A = [1 0.2; 0.1 1];

Y = A*X;

x1 = X(1,:);
N = length(x1);
y_filt = x1;
for k = 2:N-1
    y_filt(k) = (x1(k-1) + x1(k) + x1(k+1))/3;
end

y_filt=suavizadoF1(X)

figure;
plot(t,x1,'b',t,y_filt,'r');
legend('Original','Suavizada');
grid on;

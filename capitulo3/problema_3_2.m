%=====================================================================
% PROBLEMA 3.2
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y MATLAB.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('--------------------------------------------')
disp('PROBLEMA 3.2')
disp('--------------------------------------------')

% Frecuencias
n = [30, 90, 210, 150, 90, 30];
Li = [0, 2, 4, 6, 8, 9.5, 10]; % límites de clase

% Puntos medios
x = (Li(1:end-1) + Li(2:end)) / 2;

% Amplitudes
a = diff(Li);

% Alturas del histograma
h = n./a;

disp('-----------')
disp('Apartado b)')
disp('-----------')

% Gráfica del histograma
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

barhistc(Li,h);


% Frecuencias absolutas acumuladas
nac = cumsum(n)

disp('-----------')
disp('Apartado a)')
disp('-----------')

N = sum(n);
% Media
media = sum(n.*x)/N

% Varianza
m2 = sum(n.*x.^2)/N;
varianza = m2 - media^2

% Mediana
n2 = N / 2;
ind = find(n2 < nac, 1); % Encuentra el primer índice donde n2 < nac
Me = Li(ind)+a(ind)*(n2-nac(ind-1))/n(ind);
Me

disp('-----------')
disp('Apartado c)')
disp('-----------')

% Moda
[val, ind] = max(h);
h1 = h(ind) - h(ind-1);
h2 = h(ind) - h(ind+1);
Mo = Li(ind)+a(ind)*(h1/(h1+h2));
Mo

% Curtosis
m3 = sum(n.*x.^3)/N;
m4 = sum(n.*x.^4)/N;
mu4=m4-4*m3*media+6*m2*media^2-3*media^4
curt=(mu4/(varianza^2))-3

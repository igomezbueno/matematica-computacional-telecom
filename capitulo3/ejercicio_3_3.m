%=====================================================================
% EJERCICIO 3.3
% Matematica computacional para telecomunicaciones.
% Un enfoque practico con Octave y Matlab.
% Irene Gomez Bueno y Pablo Guerrero Garcia.
%
% Ejecutar desde esta carpeta tras haber ejecutado iniciar.m en la raiz
% del repositorio.
%=====================================================================

disp('-----------')
disp('EJERCICIO 3.3')
disp('-----------')

disp('-----------')
disp('Apartado a)')
disp('-----------')

%Datos
x=[0 2 4 5 8 12];
y=[1 9 29 45 90 180];
N=length(x);

%Ajuste lineal y = a + b*x
p= polyfit(x, y, 1) % grado 1
a=p(2);
b=p(1);

%Medias y varianzas
mX=mean(x);
mY=mean(y);
vX=sum(x.^2)/N-mX^2; %O bien var(x,1)
vY=sum(y.^2)/N-mY^2; %O bien var(y,1)

%Covarianza y r
covar=sum(x.*y)/N-mX*mY;
r=covar/sqrt(vX*vY);
Vr=(1-r^2)*vY;

%SSE y coeficiente de determinacion
SSEL=N*Vr
CDL=r^2

disp('-----------')
disp('Apartado b)')
disp('-----------')

xs=linspace(min(x),max(x));
ys=polyval(p,xs);
plot(x,y,'ro');
hold on;
plot(xs,ys,'b-'); grid on;

disp('-----------')
disp('Apartado c)')
disp('-----------')

%Tomamos logaritmos: ln(y)=ln(c)+d*x
lny=log(y);
p_exp=polyfit(x,lny,1);
d_exp=p_exp(1)
ln_c_exp=p_exp(2);
c_exp=exp(ln_c_exp)

%Estimaciones con el modelo exponencial
yexp_est=c_exp*exp(d_exp*x);
e_exp=y-yexp_est; %errores

SSE_exp=sum(e_exp.^2)
Ve_exp= var(e_exp,1);
R2_exp=1-Ve_exp/vY

% Comparacion final
if (SSE_exp<SSEL) && (R2_exp > CDL)
    disp('El ajuste exponencial es mejor (menor SSE y mayor R^2)')
else
    disp('El ajuste lineal es mejor.');
end

ye=c_exp*exp(d_exp*xs);
plot(xs,ye);
hold off

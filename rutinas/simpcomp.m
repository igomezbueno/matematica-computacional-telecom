function y=simpcomp(f,a,b,p)
% SIMPCOMP  Regla de Simpson compuesta con p subintervalos en [a,b].
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
h=(b-a)/p; y=0;
for k=1:p
    y=y+simpsimp(f,a+(k-1)*h,a+k*h);
end;

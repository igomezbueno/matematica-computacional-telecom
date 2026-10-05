function [x,e]=sustreg(A,b)
% SUSTREG  Sustitucion regresiva: resuelve A*x = b con A triangular superior.
%   b puede tener varias columnas (varios sistemas con la misma matriz A).
%   e = 0 si todo es correcto; e = 1 si las dimensiones no son compatibles.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
% Version adaptada: se inicializan las salidas x y e.
x=[]; e=0;
[m,n]=size(A);
[m1,n1]=size(b);
if m~=n
    e=1;
    return
end
if n~=m1
    e=1;
    return
end
for k=n:-1:1,
   x(k,:)=b(k,:)/A(k,k);
   for t=1:k-1,
      b(t,:)=b(t,:)-A(t,k)*x(k,:);
   end
end

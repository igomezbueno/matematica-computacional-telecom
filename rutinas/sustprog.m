function [x,e]=sustprog(A,b)
% SUSTPROG  Sustitucion progresiva: resuelve A*x = b con A triangular inferior.
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
for k=1:n,
   x(k,:)=b(k,:)/A(k,k);
   for t=k+1:n
      b(t,:)=b(t,:)-A(t,k)*x(k,:);
   end
end

function [x,e]=gauss(A,b)
% GAUSS  Metodo de Gauss con pivotaje normal (solo si el pivote es nulo).
%   Resuelve A*x = b; b puede tener varias columnas.
%   e = 0 si todo es correcto; e = 1 si las dimensiones no son compatibles.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
% Version adaptada: se inicializan las salidas x y e.
x=[]; e=0;
[m,n]=size(A);
[m1,n1]=size(b);% Permite resolver varios sistemas con igual A, simultaneamente.
% Comprobacion errores
   if m~=n, e=1;return,end
   if m1~=m, e=1;return,end
   C=[A b];

% Bucle principal
for k=1:m-1,
   % Intercambio de filas si es necesario
   if C(k,k)==0,% Solo se intercambia si C(k,k)==0, 
      [i,ii]=max(abs(C(k+1:m,k)));ii=ii+k; 
      d=C(k,:);C(k,:)=C(ii,:);C(ii,:)=d;
   end
   % Triangularizacion
   for l=k+1:m,
      coef=-C(l,k)/C(k,k);
      C(l,:)=C(l,:)+coef*C(k,:);
   end
end
x=sustreg(C(:,1:m),C(:,m+1:m+n1));

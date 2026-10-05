function [x,e]=gaussjor(A,b)
% GAUSSJOR  Metodo de Gauss-Jordan.
%   Resuelve A*x = b; b puede tener varias columnas.
%   e = 0 si todo es correcto; e = 1 si las dimensiones no son compatibles.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
% Version adaptada: se inicializan las salidas x y e, y se intercambian
% filas cuando aparece un pivote nulo (como en gauss.m).
x=[]; e=0;
[m,n]=size(A);
[m1,n1]=size(b);
% Comprobacion errores
   if m~=n, e=1;return,end
   if m1~=m, e=1;return,end
   C=[A b];

% Bucle principal
for k=1:m,
   % Intercambio de filas si es necesario (como en gauss.m)
   if C(k,k)==0 && k<m,
      [i,ii]=max(abs(C(k+1:m,k)));ii=ii+k;
      d=C(k,:);C(k,:)=C(ii,:);C(ii,:)=d;
   end
    C(k,:)=C(k,:)/C(k,k); %Si queremos la diagonal con 1 (util para calcular la inversa)
   % Diagonalizacion
   for l=1:m,
      if l~=k,
         coef=-C(l,k); % coef=-C(l,k)/C(k,k);
         C(l,:)=C(l,:)+coef*C(k,:);
      end
   end
end
x=C(:,m+1:m+n1);

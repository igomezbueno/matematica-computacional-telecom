function H = pasohold(A, i)
% PASOHOLD  Matriz de Householder H que anula los elementos de la columna i de A
%   por debajo de la diagonal. La utiliza sobredqr.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
% Version adaptada: si A(i,i)=0 se toma signo positivo para evitar una reflexion degenerada.
    n = max(size(A));
    sg = sign(A(i,i)); if sg==0, sg=1; end   % si A(i,i)=0 se toma signo positivo
    s= sg*sqrt(sum(A(i:n,i).^2));
    w=[ (zeros(i-1,1)) ; (A(i,i)+s) ; (A(i+1:n,i)) ];
    H=eye(n)-(2/(w'*w))*w*w' ;

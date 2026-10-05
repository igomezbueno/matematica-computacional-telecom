function x=solqr(A,b)
% SOLQR  Resuelve A*x = b (o el problema de minimos cuadrados si A es m x n, m > n)
%   mediante la factorizacion QR de A y sustitucion regresiva.
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
[m,n]=size(A);
[Q,R]=qr(A);
bb=Q'*b;
x=sustreg(R(1:n,1:n),bb(1:n,:));
endfunction

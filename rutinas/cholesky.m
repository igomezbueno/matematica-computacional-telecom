function [x,p]=cholesky(A,b)
% CHOLESKY  Resuelve A*x = b mediante la factorizacion de Cholesky A = M'*M.
%   A debe ser simetrica y definida positiva; si no lo es, p > 0 y x = [].
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
% Version adaptada: se inicializa la salida x.
x=[];
% A debe ser simetrica y definida positiva
[M,p]=chol(A);         % A=M'M    Ax=M'Mx=b
if p==0,
y=sustprog(M',b);  % M'y=b
x=sustreg(M,y);    % M x=y
end

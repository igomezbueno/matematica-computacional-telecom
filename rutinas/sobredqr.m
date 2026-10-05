function [R,yg] = sobredqr(M,y)
% SOBREDQR  Factorizacion QR reducida de M (m x n, m >= n) mediante reflexiones
%   de Householder. Devuelve R (n x n) y yg = (Q'*y)(1:n), de modo que la solucion
%   de minimos cuadrados de M*a = y se obtiene con sustreg(R,yg).
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
    c = min(size(M)); R = M; yg = y;
    for k=1:c
        H = pasohold(R,k); R = H*R; yg = H*yg;
    end;
    R = R(1:c,1:c); yg = yg(1:c);

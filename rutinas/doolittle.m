function x=doolittle(A,b)
% DOOLITTLE  Resuelve A*x = b mediante la factorizacion LU (con permutacion P*A = L*U).
% Matematica computacional para telecomunicaciones. Irene Gomez Bueno y Pablo Guerrero Garcia.
[L,U,P]=lu(A);
bb=P*b;
y=sustprog(L,bb);
x=sustreg(U,y);

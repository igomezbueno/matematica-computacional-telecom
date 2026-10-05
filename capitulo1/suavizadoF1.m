function y_filt = suavizadoF1(X)
  x1 = X(1,:);
  N = length(x1);
  y_filt = x1;
  for k = 2:N-1
    y_filt(k) = (x1(k-1) + x1(k) + x1(k+1))/3;
  end
end
